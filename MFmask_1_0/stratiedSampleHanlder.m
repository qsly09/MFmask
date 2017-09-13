%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% for DEM
% total number=50000.
% ele_strata= 300 metres.
% distance=450 metres.
% 
% for cos i
% total number=50000.
% ele_strata= 0.1
% distance=0. refer no distance rule.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function samples_ids=stratiedSampleHanlder(data_dem_clear,dem_b,dem_t,dim,total_sample,ele_strata,distance)
%             samp_dis= 15; % 450 m(15 30 m pixels)
            samp_dis= round(distance/30); % 450 m(15 30 m pixels)
            clear distance;
            % compute the number of available strata
            strata_avail=[];
            for i_dem=dem_b:ele_strata:dem_t
                dem_clear_index_tmp=data_dem_clear>=i_dem&data_dem_clear<i_dem+ele_strata;
                if sum(dem_clear_index_tmp)>0
    %                 num_strata=num_strata+1;
                    strata_avail=[strata_avail;1];
                else
                    strata_avail=[strata_avail;0];
                end
            end
            clear dem_clear_index_tmp;
            % equal samples in each stratum
            num_sam_each_strata=round(total_sample/sum(strata_avail));
            samples_ids=[];% to restore samples selected.
            % loop each strata and select samples
            loop_i=1;
            for i_dem=dem_b:ele_strata:dem_t
                if strata_avail(loop_i)
    %                 dem_clear_index_tmp=data_dem_clear>=i_dem&data_dem_clear<i_dem+ele_strata;
                    % find all clear-sky pixels in subgroup.
                    samples_ids_tmp=find(data_dem_clear>=i_dem&data_dem_clear<i_dem+ele_strata);
                    % randomly selection.
                    samples_ids_rand=samples_ids_tmp(randperm(numel(samples_ids_tmp))); 
                    clear samples_ids_tmp;
                    num_tmp=size(samples_ids_rand,1);
                    if samp_dis==0 % no distance rule
                        num_max_tmp=num_sam_each_strata;
                        if num_tmp>num_max_tmp
                            num_tmp=num_max_tmp;
                        end
                        samples_ids_rand_tmp=samples_ids_rand(1:num_tmp);
                        % store data
                        samples_ids=[samples_ids;samples_ids_rand_tmp];
                        clear samples_ids_rand samples_ids_rand_tmp;
                    else
                        num_max_tmp=num_sam_each_strata*samp_dis;
                        if num_tmp>num_max_tmp
                            num_tmp=num_max_tmp;
                        end
                        samples_ids_rand_tmp=samples_ids_rand(1:num_tmp);
                        clear samples_ids_rand;
                        samples_ids_rand=samples_ids_rand_tmp;
                        all_num_tmp=size(samples_ids_rand);
                        [i_tmp,j_tmp]=ind2sub(dim,samples_ids_rand);
                        clear samples_ids_rand_tmp;
                        ij_tmp=[i_tmp,j_tmp];
                        % removing the clear-sky pixels of which distance lt 15. 
                        idx_lt15 = rangesearch(ij_tmp,ij_tmp,samp_dis, 'distance','cityblock');
                        recorder_tmp=zeros(all_num_tmp,'uint8')+1;
                        for i_idx=1:all_num_tmp
                            if recorder_tmp(i_idx)>0 % when this label is available.
                                recorder_tmp(cell2mat(idx_lt15(i_idx)))=0;
                                recorder_tmp(i_idx)=1;% reback the current label as 1.
                            end 
                        end
                        idx_used=find(recorder_tmp==1);
                        clear recorder_tmp;
                        num_tmp=size(idx_used,1);
                        num_max_tmp=num_sam_each_strata;
                        if num_tmp>num_max_tmp
                            num_tmp=num_max_tmp;
                        end
                        idx_used=idx_used(1:num_tmp);
                        clear num_tmp num_max_tmp;
                        % store data
                        samples_ids=[samples_ids;samples_ids_rand(idx_used)];
                        clear samples_ids_rand idx_used;
                    end
                end
                loop_i=loop_i+1;
            end
        end
       