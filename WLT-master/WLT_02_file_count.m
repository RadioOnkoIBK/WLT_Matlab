%IVIEWs Counter%
%Project: WLT ----------------------------------%
%Startdate: 19.09.2023 -------------------------%
%Author: KollotzekS ----------------------------%
%-----------------------------------------------%

function [nfiles, strnfiles] = WLT_02_file_count(path)
a = dir(path);

% disp(a);
% 
% disp(length(a));
% 
% disp(sum([a.isdir]));

nfiles = length(a) - sum([a.isdir])-1;
strnfiles = num2str(nfiles);

%disp(nfiles);
%disp(strnfiles);
end