%WLT Main%
%Project: WLT ----------------------------------%
%Startdate: 11.10.2023 -------------------------%
%Author: KollotzekS; SimmerG ----------------------------%
%-----------------------------------------------%




[logfile,images_path]=  WLT_01_path;
    %disp(images_path);
    %disp(logfile);
[nfiles,strnfiles]=     WLT_02_file_count(images_path);
    %disp(nfiles);
    %disp(strnfiles);
[answer]=               WLT_03_input(logfile,images_path,strnfiles);

% for i = 1:nfiles
%     WLT_04_image_process;
% end

