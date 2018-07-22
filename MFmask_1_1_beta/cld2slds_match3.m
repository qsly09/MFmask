%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This functin is used to match cloud shadow with cloud.
% The similarity defineing cloud shadow is larger than 0.3 only for those
% clouds, of which all pixels are included in the Landsat observations.
% This minor modification was made because the match similarity may be
% wrong when some parts of cloud are out of the observations.
% 
% fix the bug that double projected pixels may be out of the observation range   by Shi. at 21. Jul., 2018
% fix the bug that this cannot work when the number of cloud objects is
% less than 14  by Shi. at 20, Dec., 2017.
% still improve the prediction of cloud shadow location when no DEMs  by Shi. at 13, Sept., 2017
% revisit the first 12 cloud objects.   by Shi. at 21,Feb.,2017
% fix the bugger, struct2table for lt. struct2table. at 21,Feb.,2017
% search neighboring clouds by distance rule. by Shi. at 13,Feb.,2017
% fix the bugger that bias for the location of real cloud object. at 13,Oct.,2016
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ similar_num,data_cloud_matched, data_shadow_matched] = cld2slds_match3(...
    plcim,plsim,recorderRow,recorderCol,...
    data_dem ,data_bt_c,t_templ,t_temph,sun_zenith_deg,...
    sun_azimuth_deg,dim,ptm,dem_base_heigh,num_near,dim_expd,gap_off)

    sub_size=30;% spatial resolution of the image
    win_height=dim(1);win_width=dim(2);
    masker_observation=plcim<255;
    sun_elevation_deg=90-sun_zenith_deg;
    sun_elevation_rad=deg2rad(sun_elevation_deg);
    % solar azimuth anngle
    Sun_tazi=sun_azimuth_deg-90;
    sun_tazi_rad=deg2rad(Sun_tazi);
    clear sun_elevation_deg sun_elevation_deg;
    % potential cloud & shadow layer
    data_cloud_potential=zeros(dim,'uint8'); 
    data_shadow_potential=zeros(dim,'uint8');
    % matched cloud & shadow layer
    data_cloud_matched=zeros(dim,'uint8');
    data_shadow_matched=zeros(dim,'uint8');
    % boundary layer
    data_boundary=zeros(dim,'uint8');
    data_boundary(plcim<255)=1; % boundary layer
    data_cloud_potential(plcim==1)=1;% plcloud layer
    data_cloud_potential=data_cloud_potential==1&masker_observation==1;

    % get potential mask values
    data_shadow_potential(plsim==1)=1;% plshadow layer
    clear plsim plcim masker_observation; % empty memory

    % revised percent of cloud on the scene after plcloud
    revised_ptm=sum(data_cloud_potential(:))/sum(data_boundary(:));
    if ptm <=0.1||revised_ptm>=0.90
        fprintf('Skip cloud shadow detection because high cloud cover\n');
        data_cloud_matched(data_cloud_potential==true)=1;
        data_shadow_matched(data_shadow_potential==false)=1;
        similar_num=-1;
%   height_num=-1;
    else
      % define constants
        Tsimilar=0.30;
        Tbuffer=0.95; % threshold for matching buffering
        max_similar = 0.95; % max similarity threshold
        num_cldoj=3; % minimum matched cloud object (pixels)
        num_pix=3; % number of inward pixes (240m) for cloud base temperature
        % enviromental lapse rate 6.5 degrees/km
        rate_elapse=6.5;
        % dry adiabatic lapse rate 9.8 degrees/km
        rate_dlapse=9.8;
        step_interval=2*sub_size*tan(sun_elevation_rad);
         % get track derection
        [rows,cols]=find(data_boundary==1);
        [cor_ul_y,num]=min(rows);cor_ul_x=cols(num);
        [cor_lr_y,num]=max(rows);cor_lr_x=cols(num);
        [cor_ll_x,num]=min(cols);cor_ll_y=rows(num);
        [cor_ur_x,num]=max(cols);cor_ur_y=rows(num);
        % get view angle geometry
        [A,B,C,omiga_par,omiga_per]=getSensorViewGeo(cor_ul_x,cor_ul_y,cor_ur_x,cor_ur_y,cor_ll_x,cor_ll_y,cor_lr_x,cor_lr_y);
        clear cor_ul_x cor_ul_y cor_ur_x cor_ur_y cor_ll_x cor_ll_y cor_lr_x cor_lr_y;
        % Segmentate each cloud
        segm_cloud_init=bwlabeln(data_cloud_potential,8);
        clear data_cloud_potential;
        L = segm_cloud_init;
        s = regionprops(L,'area');
        area = [s.Area];
        % filter out cloud object < than num_cldoj pixels
        idx = find(area >= num_cldoj);
        segm_cloud_tmp = ismember(L,idx);
        [segm_cloud,num]=bwlabeln(segm_cloud_tmp,8);
        s = regionprops(segm_cloud,'area');
        area_final = [s.Area];
        obj_num=area_final;
        clear segm_cloud_init L idx area_final s;
        % Get the x,y of each cloud
        % Matrix used in recording the x,y
        stats= regionprops(segm_cloud,'Centroid','PixelList');
%         stats_table=struct2table(stats);
        match_clds=zeros(1,num,'uint8'); % cloud shadow match similarity (m)
        matched_clds_centroid=[];
        height_clds_recorder=[]; % cloud shadow match heights (m)
        % Use iteration to get the optimal move distance
        % Calulate the moving cloud shadow 
        similar_num=zeros(1,num); % cloud shadow match similarity (m)
        l_pt=0.175; h_pt=1-l_pt;
        dim_expand=dim+2*dim_expd;
        record_base_h_num=0;
        fprintf('Detecting cloud shadows. This might take some minutes so be patient.\n');
        num_revisited = 0;
        if num > num_near
            num_revisited=num_near;
        end
        num_all=num+num_revisited;
        for cloud_type_cur= 1:num_all %num
            % revisit the first 12 cloud objects.
            cloud_type=cloud_type_cur;
            if cloud_type>num && num_revisited<num
                cloud_type=num-num_revisited;
            end
%             cloud_object=zeros(dim,'uint8'); 
% %            fprintf('Shadow Match of the %d/%d_th cloud with %dpixels\n',cloud_type,num,obj_num(cloud_type));
            % moving cloud xys
            XY_type=zeros(obj_num(cloud_type),2);
            % record the max threshold moving cloud xys
            tmp_XY_type=zeros(obj_num(cloud_type),2);
            % corrected for view angle xys
            tmp_xys=zeros(obj_num(cloud_type),2);
            % record the original xys
            orin_xys=zeros(obj_num(cloud_type),2);
            % record the original xys
            orin_xys(:,:)=stats(cloud_type,:).PixelList(:,:);
            % record this orinal ids
            orin_cid=sub2ind(dim,orin_xys(:,2),orin_xys(:,1)); 
%             cloud_object(orin_cid)=1;
            % Temperature of the cloud object
            temp_obj=data_bt_c(orin_cid);
            % the base temperature for cloud
            % assume object is round r_obj is radium of object 
            r_obj=sqrt(obj_num(cloud_type)/2*pi);
            % number of inward pixes for correct temperature
        %        num_pix=8;
            pct_obj=(r_obj-num_pix)^2/r_obj^2;
            pct_obj=min(pct_obj,1); % pct of edge pixel should be less than 1
            t_obj=quantile(temp_obj(:),pct_obj); 
            clear pct_obj;
            t_obj=double(t_obj);
            % put the edge of the cloud the same value as t_obj
            temp_obj(temp_obj>t_obj)=t_obj;
            % refine cloud height range (m)
            % initialize height and similarity info
            if isequal(data_dem,0)
                base_heigh_cloud=0;
            else
                dem_base_cloud=data_dem(orin_cid);
                % The min height should be the max dem of dem_base_cloud.
                % However, the commission error from snow may lead to overestimate the base heigh. 
                base_heigh_cloud=prctile(dem_base_cloud,100*h_pt)-dem_base_heigh;
                % base_heigh_cloud=max(dem_base_cloud)-dem_base_heigh;
                clear dem_base_cloud;
            end
            Min_cl_height=200+base_heigh_cloud;
%             Min_cl_height=base_heigh_cloud;
            Min_cl_height=max(Min_cl_height,10*(t_templ-400-t_obj)/rate_dlapse);
            Max_cl_height=12000.00+base_heigh_cloud;% Max cloud base height (m)
            Max_cl_height=min(Max_cl_height,10*(t_temph+400-t_obj));
%             clear base_heigh_cloud;
            record_h=0;
            record_thresh=0;
            record_base_h=0;
            record_base_h_near=0;% it is available only when >0 
            center_cur=stats(cloud_type,:).Centroid;
            % height estimated by neighboring clouds.
            if record_base_h_num>=num_near
                % the centers of already matched clouds
                % current cloud's center
                % the nearest cloud among all matched clouds.
                nearest_cloud_centers=knnsearch(matched_clds_centroid,center_cur,'k',num_near, 'distance','cityblock');% less time-consuming method chebychev
                
                % get all matched clouds' height.
                record_base_h_tmp=height_clds_recorder(nearest_cloud_centers);
                
                record_base_h_near=prctile(record_base_h_tmp,100*h_pt);
                h_pre_std=std(record_base_h_tmp);
                clear record_base_h_tmp;
                if h_pre_std>=1000||record_base_h_near <= Min_cl_height||record_base_h_near >= Max_cl_height
                    record_base_h_near=0;
                end
                clear h_pre_std;
            end
           
            dist_pre=0;
            dist_passed=false;
            dist_first=true;
            % all pixels of projected cloud object 
            if numel(orin_cid(:))==0
                dist_passed=true;
            else
                cpc_i=center_cur(2);
                cpc_j=center_cur(1);
            end
            
            clear orin_cid;
            num_matched=0;
            for base_h=Min_cl_height:step_interval:Max_cl_height % iterate in height (m)
                % Get the true postion of the cloud
                % calculate cloud DEM with initial base height
                h=double(10*(t_obj-temp_obj)/rate_elapse+base_h);% relative to the reference plane.
%                 [tmp_xys(:,1),tmp_xys(:,2)]=getRealCloudPosition(orin_xys(:,1),...
%                     orin_xys(:,2),h,A,B,C,omiga_par,omiga_per);
                % the height for the bias of the real cloud location should exclude the
                % surface elevation below the cloud object.
                h_bias=h-base_heigh_cloud;% hc-Ec the height between cloud object and its surface.
                sensor_heigh_bias=base_heigh_cloud+dem_base_heigh; % used to exclude the elevation of cloud' surface.
                [tmp_xys(:,1),tmp_xys(:,2)]=getRealCloudPosition(orin_xys(:,1),...
                    orin_xys(:,2),h_bias,A,B,C,omiga_par,omiga_per,sensor_heigh_bias);
         
                % shadow moved distance (pixel)
                i_xy=h/(sub_size*tan(sun_elevation_rad)); % real cloud height relative to the plane.
                if sun_azimuth_deg< 180
                    XY_type(:,2)=round(tmp_xys(:,1)-i_xy*cos(sun_tazi_rad)); % X is for j,2
                    XY_type(:,1)=round(tmp_xys(:,2)-i_xy*sin(sun_tazi_rad)); % Y is for i,1
                else
                    XY_type(:,2)=round(tmp_xys(:,1)+i_xy*cos(sun_tazi_rad)); % X is for j,2
                    XY_type(:,1)=round(tmp_xys(:,2)+i_xy*sin(sun_tazi_rad)); % Y is for i,1
                end
                % this location is relative to reference plane.
                tmp_j_plane=XY_type(:,2);% col
                tmp_i_plane=XY_type(:,1);% row
                % back project
%                 dim_expd=1000;% 1000 pixels buffer
                % some projected pixels out of observations.
                tmp_i_plane_expd_tmp=tmp_i_plane+dim_expd;
                tmp_j_plane_expd_tmp=tmp_j_plane+dim_expd;
                % out_piexls=find(tmp_i_plane_expd_tmp<dim_expand(1)|tmp_j_plane_expd_tmp<dim_expand(2));
                % tmp_i_plane_expd=tmp_i_plane_expd_tmp(out_piexls);
                % tmp_j_plane_expd=tmp_j_plane_expd_tmp(out_piexls);
                avail_pixels=find(tmp_i_plane_expd_tmp>0&tmp_j_plane_expd_tmp>0&...
                    tmp_i_plane_expd_tmp<=dim_expand(1)&tmp_j_plane_expd_tmp<=dim_expand(2));
                tmp_i_plane_expd=tmp_i_plane_expd_tmp(avail_pixels);
                tmp_j_plane_expd=tmp_j_plane_expd_tmp(avail_pixels);
                
                clear tmp_i_plane_expd_tmp tmp_j_plane_expd_tmp avail_pixels;
                tmp_id_plane_expd=sub2ind(dim_expand,tmp_i_plane_expd,tmp_j_plane_expd); % matched shadow locations
                clear tmp_i_plane_expd tmp_j_plane_expd;
                
                tmp_i_obs=recorderRow(tmp_id_plane_expd);
                tmp_j_obs=recorderCol(tmp_id_plane_expd);
                
                % must beyond the location of the orgianl cloud.
                if ~dist_passed
                    sum_cpmp_i=sum(tmp_i_obs(:));
                    sum_cpmp_j=sum(tmp_j_obs(:));
                    area_cpmp=numel(tmp_j_obs(:));
                    ctmp_i=sum_cpmp_i/area_cpmp;
                    ctmp_j=sum_cpmp_j/area_cpmp;
                    dist_cur = pdist2([ctmp_j,ctmp_i],[cpc_j,cpc_i],'Euclidean');
                    if dist_first
                        dist_pre=dist_cur;
                        dist_first=false;
                    else
                        if dist_pre>=dist_cur
                            dist_pre=dist_cur;
                            record_thresh=0;
                            record_h=0;
                            continue;
                        else
                            dist_passed=true;
                        end
                    end
                end

                % the id that is out of the image
                out_id=tmp_i_obs<1|tmp_i_obs>win_height|tmp_j_obs<1|tmp_j_obs>win_width;
                out_all=sum(out_id(:));
                tmp_ii_obs=tmp_i_obs(out_id==0);
                tmp_jj_obs=tmp_j_obs(out_id==0);
                tmp_id=sub2ind(dim,tmp_ii_obs,tmp_jj_obs); % matched shadow locations
                % out of observation, 
                if gap_off
                    match_id=(data_boundary(tmp_id)==0)|...
                        (segm_cloud(tmp_id)~=cloud_type&(data_shadow_potential(tmp_id)==1|segm_cloud(tmp_id)>0)); 
                else
                    match_id=(segm_cloud(tmp_id)~=cloud_type&(data_shadow_potential(tmp_id)==1|segm_cloud(tmp_id)>0));     
                end
                matched_all=sum(match_id(:))+out_all;
                
                total_id=(segm_cloud(tmp_id)~=cloud_type);
                total_all=sum(total_id(:))+out_all;

                thresh_match=matched_all/total_all;
                
                num_in_bound=0;
                if ~gap_off
                    num_in_bound_tmp=(data_boundary(tmp_id)==0);
                    num_in_bound=sum(num_in_bound_tmp(:));
                end
                iter_con=0;% used to determine whether the iteration continues or not.
                % the following rules are used to decide to continue or not.
                if (thresh_match >= Tbuffer*record_thresh)&&(base_h < Max_cl_height-step_interval)&&(record_thresh<max_similar)
                    % set continue when it passes the above rules.
                    iter_con=1;
                    % only when expected height available
                    if num_matched==1&&record_base_h_near>0&&base_h>record_base_h_near
                        % exceed the neighboring clouds' height & have been matched before.
                        iter_con=0;
                    elseif thresh_match > record_thresh
                        % record max similarity and the corresponding cloud base height.
                        record_thresh=thresh_match;
                        record_h=h;
                        record_base_h=base_h;
                        continue;
                    end
                else % the iteration stops
                    if (record_thresh > Tsimilar||num_in_bound>0)
                        num_matched=1;
                    end
                    % only when expected height available. (record_base_h_near>0)
                    if base_h<record_base_h_near
                        % but allow the searching reach to the neighboring clouds' height
                        if thresh_match>=record_thresh||thresh_match>=max_similar
                            % record cloud base height if the current similarity is not less than the max.
                            % if current matched similarity is more tha 0.95, MFmask record it as new height.
                            record_thresh=thresh_match;
                            record_h=h;
                            record_base_h=base_h;
                        end
                        continue;
                    end
                end
                % 1: continues; 0: not continue and get a cloud shadow
                if iter_con==1
                   continue;
                else
                    clear num_in_bound_tmp;
                    if (record_thresh > Tsimilar||num_in_bound>0)
                        % update neighboring cloud set.
                        if r_obj>num_pix
                            matched_clds_centroid=[matched_clds_centroid;center_cur];
                            match_clds(cloud_type)=1;
                            height_clds_recorder=[height_clds_recorder;record_base_h];
%                             height_clds_recorder(cloud_type)=record_base_h;
                            record_base_h_num=record_base_h_num+1;
                        end
                        similar_num(cloud_type)=record_thresh;
                        
                        h_bias=record_h-base_heigh_cloud;% hc-Ec
                        sensor_heigh_bias=base_heigh_cloud+dem_base_heigh;
                        [tmp_xys(:,1),tmp_xys(:,2)]=getRealCloudPosition(orin_xys(:,1),...
                        orin_xys(:,2),h_bias,A,B,C,omiga_par,omiga_per,sensor_heigh_bias);
                        i_vir=record_h/(sub_size*tan(sun_elevation_rad));
                        if sun_azimuth_deg < 180
                            tmp_XY_type(:,2)=round(tmp_xys(:,1)-i_vir*cos(sun_tazi_rad)); % X is for col j,2
                            tmp_XY_type(:,1)=round(tmp_xys(:,2)-i_vir*sin(sun_tazi_rad)); % Y is for row i,1
                        else
                            tmp_XY_type(:,2)=round(tmp_xys(:,1)+i_vir*cos(sun_tazi_rad)); % X is for col j,2
                            tmp_XY_type(:,1)=round(tmp_xys(:,2)+i_vir*sin(sun_tazi_rad)); % Y is for row i,1
                        end

                        tmp_scol_plane=tmp_XY_type(:,2);
                        tmp_srow_plane=tmp_XY_type(:,1);
                        tmp_tmp_i_plane_expd=tmp_srow_plane+dim_expd;
                        tmp_tmp_j_plane_expd=tmp_scol_plane+dim_expd;
                        
%                         % some projected pixels out of observations.
                        avail_pixels=find(tmp_tmp_i_plane_expd>0&tmp_tmp_j_plane_expd>0&...
                            tmp_tmp_i_plane_expd<dim_expand(1)&tmp_tmp_j_plane_expd<dim_expand(2));
                        tmp_tmp_i_plane_expd=tmp_tmp_i_plane_expd(avail_pixels);
                        tmp_tmp_j_plane_expd=tmp_tmp_j_plane_expd(avail_pixels);
                        clear avail_pixels;
                        
                        tmp_tmp_id_plane_expd=sub2ind(dim_expand,tmp_tmp_i_plane_expd,tmp_tmp_j_plane_expd); % matched shadow locations
                        clear tmp_srow_plane tmp_scol_plane tmp_tmp_i_plane_expd tmp_tmp_j_plane_expd;
    
                        tmp_srow=recorderRow(tmp_tmp_id_plane_expd);
                        tmp_scol=recorderCol(tmp_tmp_id_plane_expd);
                        % put data within range
                        tmp_srow(tmp_srow<1)=1;
                        tmp_srow(tmp_srow>win_height)=win_height;
                        tmp_scol(tmp_scol<1)=1;
                        tmp_scol(tmp_scol>win_width)=win_width;

                        tmp_sid=sub2ind(dim,tmp_srow,tmp_scol);
                        % give shadow_cal=1
                        data_shadow_matched(tmp_sid)=1;
                        break;
                    else
                        record_thresh=0;
%                        num_matched=0;
                        continue;
                    end
                    clear center_cur;
                end
            end
        end
        data_cloud_matched=segm_cloud_tmp;
        data_shadow_matched(data_cloud_matched==1)=0; % do not make the overlap, but need to remove clouds.
    end
end
