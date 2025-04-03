%Path selection for Log-File and ImageStack root%
%Project: WLT ----------------------------------%
%Startdate: 19.09.2023 -------------------------%
%Author: KollotzekS ----------------------------%
%-----------------------------------------------%


function [logfile,images_path] = WLT_01_path()

[logfile,images_path] = uigetfile('*');

if isequal(logfile,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(images_path,logfile)]);
   %disp(images_path);
   %disp(logfile);
   
end
end

