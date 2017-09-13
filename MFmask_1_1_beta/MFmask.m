function clr_pct = MFmask(fullfile_path,im,demtype,cldpix,sdpix,snpix,cldprob,num_Lst,num_near,gap_off)

    [zen,azi,ptm,Temp,t_templ,t_temph,Water,Snow,pCloud,pShadow,....
        dem,dem_b,dim,mask,ul,resolu,zc]...
        =plcloud_ratelapse2(fullfile_path,im,demtype,cldprob,num_Lst);
    clear cldprob num_Lst;
%     clr_pct=0;% test dem spacing.
%     return; % test dem spacing.
    % expand pixels to project DEM map
%     ele_max=double(prctile(dem(mask),100-0.7))-dem_b;
%     pixels_bias_max=tan(deg2rad(zen))*ele_max;
%     pixels_bias_max=round(pixels_bias_max/resolu(1));
%     dim_expd=3000;% max 3000 pixels   out of memery.
%     if dim_expd>pixels_bias_max
%         dim_expd=pixels_bias_max;
%     end
    dim_expd=1000;
%     if strcmp(pro_type,'L1G')% dem bias
%         [dX,dY] = projectPixel(dim,mask,dem,dem_b,zen,azi,dim_expd);
%     else
%         [dX,dY] = projectPixel2(dim,dem,dem_b,zen,azi,dim_expd);
%     end
    % construct pixel-relation table.
    [dRow,dCol] = projectPixel2(dim,dem,dem_b,zen,azi,dim_expd,resolu);
    [similar_num,cloud_cal, shadow_cal]=cld2slds_match3(pCloud,pShadow,...
        dRow,dCol,...
        dem ,Temp,t_templ,t_temph,zen,...
        azi,dim,ptm,dem_b,num_near,dim_expd,gap_off);

    clear pCloud pShadow;
    clear dX dY dem Temp t_templ t_temph;
    clear zen azi ptm dem_b num_near gap_off;
    
    % dialte shadow first
    if sdpix>0
        SEs=strel('square',2*sdpix+1);
        shadow_cal=imdilate(shadow_cal,SEs);
    end
    clear SEs sdpix;
    % dialte cloud
    if cldpix>0
        SEc=strel('square',2*cldpix+1);
        cloud_cal=imdilate(cloud_cal,SEc);
    end
    clear SEc cldpix;
    % dialte snow
    if snpix>0
        SEsn=strel('square',2*snpix+1);
        Snow=imdilate(Snow,SEsn);
    end
    clear SEsn snpix;

    cs_final=zeros(dim,'uint8');
    cs_final(Water==1)=1;
    clear dim Water;
    % mask from plcloud
    % step 1 snow or unknow
    cs_final(Snow==1)=3; % snow
    clear Snow;
    % step 2 shadow above snow and everyting
    cs_final(shadow_cal==1)=2; %shadow
    clear shadow_cal;
    % step 3 cloud above all
    cs_final(cloud_cal==1)=4; % cloud
    clear cloud_cal;
    cs_final(mask==0)=255;
    norln=strread(im,'%s','delimiter','.'); 
    n_name=char(norln(1));
%     enviwrite([fullfile_path,n_name,'_MFmask_topo_none_c'],cs_final,'uint8',resolu,ul,'bsq',zc);
%     enviwrite([fullfile_path,n_name,'_MFmask_topo_in_c_cosi_strat'],cs_final,'uint8',resolu,ul,'bsq',zc);
    enviwrite([fullfile_path,n_name,'_MFmask'],cs_final,'uint8',resolu,ul,'bsq',zc);
    % record clear pixel percent;
    tmpcs = cs_final <= 1;
    clr_pct = 100*sum(tmpcs(:))/sum(mask(:));
    fprintf('MFmask finished for %s with %.0f%% clear pixels\n',n_name,clr_pct);
    % toc
end