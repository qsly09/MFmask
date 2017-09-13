%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A stratied random sampling approach was applied in this version. by Shi.
% at 6,Feb.,2017
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [zen,azi,ptm,Temp,t_templ,t_temph,WT,Snow,Cloud,Shadow,...
    dem,dem_b,dim,mask,ul,resolu,zc]=plcloud_ratelapse(fullfile_path,image,cldprob,num_Lst)
    % resolution of Fmask results
    fprintf('Loading input data.\n');
    [dem,slope,aspect,Temp,data,dim,ul,zen,azi,zc,satu_B1,satu_B2,satu_B3,resolu]=nd2toarbt_xml(fullfile_path,image);
    fprintf('Detecting clouds. This might take some minutes so be patient.\n');
    if num_Lst < 8 % Landsat 4~7
        data_nir=data(:,:,4);
        data_swir=data(:,:,5);
        Thin_prob = 0; % there is no contribution from the new bands
    else 
        data_nir=data(:,:,4);
        data_swir=data(:,:,5);
        Thin_prob = data(:,:,end)/400;
    end
    % fprintf('Read in TOA ref ...\n');
    Cloud=zeros(dim,'uint8');  % cloud mask
    Snow=zeros(dim,'uint8'); % Snow mask
    WT=zeros(dim,'uint8'); % Water msk
    % process only the overlap area
    mask=data(:,:,1)>-9999;
    Shadow=zeros(dim,'uint8'); % shadow mask
    NDVI=(data(:,:,4)-data(:,:,3))./(data(:,:,4)+data(:,:,3));
    NDSI=(data(:,:,2)-data(:,:,5))./(data(:,:,2)+data(:,:,5));

    NDVI((data(:,:,4)+data(:,:,3))==0)=0.01;
    NDSI((data(:,:,2)+data(:,:,5))==0)=0.01;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%saturation in the three visible bands
    satu_Bv=satu_B1+satu_B2+satu_B3>=1;
    clear satu_B1; % clear satu_B;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Basic cloud test
    idplcd=NDSI<0.8&NDVI<0.8&data(:,:,6)>300&Temp<2700;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Snow test
    % It takes every snow pixels including snow pixel under thin clouds or icy clouds
    Snow(NDSI>0.15&Temp<1000&data(:,:,4)>1100&data(:,:,2)>1000)=1;
    % Snow(mask==0)=255;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Water test
    % Zhe's water test (works over thin cloud)
    WT((NDVI<0.01&data(:,:,4)<1100)|(NDVI<0.1&NDVI>0&data(:,:,4)<500))=1;
    if (isequal(size(mask)==size(dem),[1,1]))
        WT=WT&(slope<10);
    else
        Temp=-1;
        t_templ=-1;
        t_temph=-1;
        return;
    end
    WT(mask==0)=255;

    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Whiteness test
    % visible bands flatness (sum(abs)/mean < 0.6 => brigt and dark cloud )
    visimean=(data(:,:,1)+data(:,:,2)+data(:,:,3))/3;
    whiteness=(abs(data(:,:,1)-visimean)+abs(data(:,:,2)-visimean)+...
        abs(data(:,:,3)-visimean))./visimean;
    clear visimean;
    % update idplcd
    whiteness(satu_Bv==1)=0;% If one visible is saturated whiteness == 0
    idplcd=idplcd==true&whiteness<0.7;

    % clear whiteness;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Haze test
    HOT=data(:,:,1)-0.5*data(:,:,3)-800;% Haze test
    idplcd=idplcd==true&(HOT>0|satu_Bv==1);
    clear HOT; % need to find thick warm cloud
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ratio4/5>0.75 cloud test
    Ratio4_5=data(:,:,4)./data(:,:,5);
    idplcd=idplcd==true&Ratio4_5>0.75;
    clear Ratio45;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Cirrus tests from Landsat 8
    idplcd = idplcd == true|Thin_prob > 0.25;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%constants%%%%%%%%%%%%%%%%%%%%%%%%%%
    l_pt = 0.175; % low percent
    h_pt = 1-l_pt; % high percent
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%(temperature & snow test )
    % test whether use thermal or not
    idclr = idplcd==false&mask==1;%&TempDif<3&Cirrus<3; % thin_prob < ...
    ptm=100*sum(idclr(:))/sum(mask(:));% percent of clear pixel
    idlnd = idclr&WT==false; % buffer for water...
    idwt = idclr&WT==true;%&data(:,:,6)<=300;
    dem_b=0.0;
    lndptm=100*sum(idlnd(:))/sum(mask(:));

    % enviwrite('idclr',idlnd,'single',resolu,ul,'bsq',zc);
    if ptm <= 0.1 % no thermal test => meanless for snow detection (0~1)
        % fprintf('No clear pixel in this image (clear prct = %.2f)\n',ptm);
        Cloud(idplcd==true)=1; % all cld
        % % improving by majority filtering
        % Cloud=bwmorph(Cloud,'majority');% exclude <5/9
        Shadow(Cloud==0)=1;
        Temp=-1;
        t_templ=-1;
        t_temph=-1;
        Cloud(mask==0)=255;
    else
        % fprintf('Clear pixel EXIST in this scene (clear prct = %.2f)\n',ptm);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%(temperature test )
        if lndptm >= 0.1
            ratelaspe_cl=idlnd;
        else
            ratelaspe_cl=idclr;
        end
        dem_b=double(prctile(dem(mask),0.7));
        temp_min=prctile(Temp(ratelaspe_cl),l_pt*100);
        temp_max=prctile(Temp(ratelaspe_cl),h_pt*100);
        ratelaspe_cl=(Temp>temp_min&Temp<temp_max)&ratelaspe_cl;
        data_bt_c_clear=double(Temp(ratelaspe_cl));
        data_dem_clear=double(dem(ratelaspe_cl));
        % stratified random samples select
        total_sample=50000;
        ele_strata=300;% meters
        samp_distance=450;% meters
        dem_t=double(prctile(dem(mask),100-0.7));
%         binScatterPlot(data_dem_clear,data_bt_c_clear)
        samples_ids=stratiedSampleHanlder(data_dem_clear,dem_b,dem_t,dim,total_sample,ele_strata,samp_distance);

        data_dem_clear_tmp=data_dem_clear;
        data_bt_c_clear_tmp=data_bt_c_clear;
        clear data_dem_clear data_bt_c_clear;
        
        data_dem_clear=data_dem_clear_tmp(samples_ids,:);
        data_bt_c_clear=data_bt_c_clear_tmp(samples_ids,:);
        clear data_dem_clear_tmp data_bt_c_clear_tmp samples_ids;
        
       %% regress
        alpha=0.05;
        [b,bint,r,rint,stats]=regress(data_bt_c_clear,[ones(size(data_dem_clear)),data_dem_clear],alpha);
        rate_lapse=0.0;
        if stats(3)<alpha && double(b(2)) < 0
            rate_lapse=double(b(2));% -0.00
        end
%         heatscatter(data_dem_clear, data_bt_c_clear);
%         heatscatter(data_dem_clear, data_bt_c_clear, [0 dem_t 0 7000],['F:\Data\dem2temp_plots\p36r37_dem2temp_plot\'],'test',...
% '50','10','o',1,1,...
% 'Real Landsat ETM+ Image Reflectance (¡Á10^4)',...
% 'Simulated Landsat ETM+ Image Reflectance (¡Á10^4)');
%         scatter(data_dem_clear,data_bt_c_clear);
%         mmm=[data_dem_clear,data_bt_c_clear];
%         xlswrite('F:\Data\dem2temp_plots\p36r37_dem2temp_plot\p36_r37_plots_data_stratified_samples.xlsx',mmm);
%         corrcoef(data_bt_c_clear,data_dem_clear)
        clear randc data_dem_clear data_bt_c_clear ratelaspe_cl;
        clear b bint r rint stats;
%         rate_lapse % test samples
%         return; % test samples
        
        if rate_lapse==0.0
            Tempd=double(Temp);
        else
            Tempd=double(Temp)-rate_lapse.*double(dem-dem_b);
        end
       %% temperature test (over water)
        F_wtemp=Temp(idwt); % get clear water temperature
        t_wtemp=prctile(F_wtemp,100*h_pt);
        wTemp_prob=(t_wtemp-Temp)./400;
        wTemp_prob(wTemp_prob<0)=0;
        clear F_wtemp t_wtemp;
    %    wTemp_prob(wTemp_prob > 1) = 1;
        %% Brightness test (over water)
        t_bright=1100;
        Brightness_prob=data(:,:,5)./t_bright;
        Brightness_prob(Brightness_prob>1)=1;
        Brightness_prob(Brightness_prob<0)=0;
       %% Var land
        NDSI(satu_B2==true&NDSI<0)=0;
        NDVI(satu_B3==true&NDVI>0)=0;
        Vari_prob=1-max(max(abs(NDSI),abs(NDVI)),whiteness);
        
        clear data NDSI NDVI whiteness satu_B2 satu_B3;
        %% Final prob mask (water)
        wfinal_prob=100*wTemp_prob.*Brightness_prob + 100*Thin_prob; % cloud over water probability
        wclr_max=prctile(wfinal_prob(idwt),100*h_pt)+cldprob;% dynamic threshold (water)
        id_final_cld_wt=(idplcd==true&wfinal_prob>wclr_max&WT==1);% thin cloud over water

        clear Brightness_prob wTemp_prob wfinal_prob wfinal_pro wclr_max;

       %% temperature test (over land)
        if lndptm >= 0.1
            F_temp=Tempd(idlnd); 
        else
            F_temp=Tempd(idclr); 
        end
        % 0.175 percentile background temperature (low)
        t_templ=prctile(F_temp,100*l_pt);
        % 0.825 percentile background temperature (high)
        t_temph=prctile(F_temp,100*h_pt);% exclude the hot points like city.
        % Get cloud prob over water
        
        %% Temperature test
        t_buffer=4*100;
        t_tempL=t_templ-t_buffer;
        t_tempH=t_temph+t_buffer;
        Temp_l=t_tempH-t_tempL;
        Temp_prob=(t_tempH-Tempd)/Temp_l;
        Temp_prob(Temp_prob<0)=0;
        clear t_buffer t_tempL t_tempH Temp_l;

       %% Final prob mask (land) 
        final_prob=100*Temp_prob.*Vari_prob + 100*Thin_prob; % cloud over land probability
        clear  Temp_prob Vari_prob Thin_prob;
        clr_max=prctile(final_prob(idlnd),100*h_pt)+cldprob;% dynamic threshold (land)
        % 2016/2/22
        id_final_cld=(idplcd==true&final_prob>clr_max&WT==0)|...% cloud over land
            id_final_cld_wt|...% thin cloud over water
            Tempd<t_templ-3500;%|...;% extremly cold cloud
        clear  Tempd final_prob clr_max;
        clear  id_final_cld_wt;
        Cloud(id_final_cld)=1;
        Cloud(mask==0)=255;
        clear id_final_cld;
        idlnd(Snow==1)=0;% exclude snow pixels.
        Shadow=plshadow( data_nir,data_swir,idlnd,mask,l_pt,...
            zen,azi, slope,aspect,dim);
        clear aspect slope idlnd;
    end
end

