%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Welcome to use the 1.0 version of MFmask!
% It is capable of detecting cloud, cloud shadow, snow for Landsat 4, 5, 7, and 8
% If you have any question please do not hesitate
% to contact Shi Qiu and Prof. Binbin He at School of Resources and Enviroment,
% University of Electronic Science and Technology of China
% email: qsly09@hotmail.com
%
% Inputs:

% Each foler only put one image and includes the following fiels.
%
% 1. The original Landat TIF images. 
%
% 2. Its corresponding Digital Elevation Moedl (DEM) data. 
%
% 3. Its corresponding slope and aspect data.
% 
% The name of the above DEM, slope, and aspect file need to 
% end with '_dem','_slope', and  '_aspect', respectively. 
%
% For example, 
% xxx_dem,
% xxx_slope,
% xxx_aspect
%
%
%
% Outputs:

% clear land = 0
% clear water = 1
% cloud shadow = 2
% snow = 3
% cloud = 4
% outside = 255
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function autoMFmask(cldpix,sdpix,snpix,cldprob)
    fprintf('MFmask 1.0 version start.\n');
    tic
    norMTL=dir('L*MTL.txt');
    existMTL=size(norMTL);

    if existMTL(1)==0
        fprintf('No L*MTL.txt header in the current folder!\n');
        return;
    end
    % open and read hdr file

    fullfile_path=[pwd,'\'];
    fid_in=fopen([fullfile_path,norMTL.name],'r');
    geo_char=fscanf(fid_in,'%c',inf);
    fclose(fid_in);
    geo_char=geo_char';
    geo_str=strread(geo_char,'%s');
    % Identify Landsat Number (Lnum = 4, 5, 7, or 8)
    LID=char(geo_str(strmatch('SPACECRAFT_ID',geo_str)+2));
    num_Lst=str2double(LID(end-1));
    fprintf('Cloud, cloud shadow, and snow detection for Landsat %d imagery.\n',num_Lst); 
    DATEID=char(geo_str(strmatch('ACQUISITION_DATE',geo_str)+2));
    if isempty(DATEID)
        DATEID=char(geo_str(strmatch('DATE_ACQUIRED',geo_str)+2));
    end
    num_date=datenum(DATEID,'yyyy-mm-dd');
    num_date_gap=datenum('2003-05-31','yyyy-mm-dd');
    gap_off=0;
    clear fid_in geo_char geo_str LID DATEID;
    if exist('cldpix','var')==1&&exist('sdpix','var')==1&&exist('snpix','var')==1
        cldpix = str2double(cldpix); % to make stand alone work for inputs
        sdpix = str2double(sdpix);
        snpix = str2double(snpix);
        fprintf('Cloud/cloud shadow/snow dilated by %d/%d/%d pixels.\n',cldpix,sdpix,snpix);

    else
        % default buffering pixels for cloud, cloud shadow, and snow
        cldpix = 0;
        sdpix = 3;
        snpix = 0;
        fprintf('Cloud/cloud shadow/snow dilated by %d/%d/%d pixels (default).\n',cldpix,sdpix,snpix);
    end
    if exist('cldprob','var')
        cldprob = str2double(cldprob); % to make stand alone work for inputs
        fprintf('Cloud probability threshold of %.2f%%.\n',cldprob);
    else
        % default cloud probability threshold for cloud detection
        if num_Lst < 8
             cldprob = 22.5; % the default probability threshold may change for Landsat 4-7
        elseif num_Lst == 8
            cldprob = 22.5; % the default probability threshold may change for Landsat 8
        else
            fprintf('Images are not from Landsat 4~8.\n');
            return;
        end
        fprintf('Cloud probability threshold of %.2f%% (default).\n',cldprob);
    end
    % gaps may have impact on the matching cloud and cloud shadow.
    % but, this version of MFmask has hanlded this bug.
    if (num_Lst==7)&&(num_date>=num_date_gap)
        gap_off=1;
    end
    
    num_near=14;   % the number of nearboring cloud objects for the estimated cloud base height.
    clr_pct = MFmask(fullfile_path,norMTL.name,cldpix,sdpix,snpix,cldprob,num_Lst,num_near,gap_off); % newest version 1.1
    time=toc;
    time=time/60;
    fprintf('The runtime is %.2f minutes.\n',time);
end