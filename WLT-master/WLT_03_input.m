%Input dialog%
%Project: WLT ----------------------------------%
%Startdate: 19.09.2023 -------------------------%
%Author: KollotzekS ----------------------------%
%-----------------------------------------------%

function [answer]=WLT_03_input(logfile,images_path,strnfiles)

dateasstring=datestr(datetime('now'));
prompt = {'Choose Log File:','Path','Datum','Number of IViews'};
dlgtitle = 'Input';
dim = [1,100];
definput = {logfile,images_path,dateasstring,strnfiles};
answer = inputdlg(prompt,dlgtitle,dim,definput)
end