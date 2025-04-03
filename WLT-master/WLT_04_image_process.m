%Image processing%
%Project: WLT ----------------------------------%
%Startdate: 11.10.2023 -------------------------%
%Author: KollotzekS ----------------------------%
%-----------------------------------------------%


%hier Angabe vom Auswerte-Ordner
folderName = 'D:\WLT-Messungen his\WLTLinac0_2023-05-08\';
iViewName = 'WLT_L0_';
Linac = "L0 VHD";
iViewDatum = "2023-05-08";
iViewZeit = "13h40";
%ExcelFile='H:\Matlab\04 WinstonLutz\WL-Test LinacX Vorlage.xlsx';
ExcelFile = 'N:\Qualitaetssicherung\22 Konstanzprüfung\Linac 0\QK\L0 QKM202302 20230621 Gregor\WL-Test 20Felder Vorlage.xlsx';

function [answer]=WLT_04_image_process(logfile,images_path,strnfiles)

img_Name = strcat(folderName,iViewName,num2str(i));
     img=readHISfile(img_Name); %for .his-Files
%    img_Name = strcat(folderName,'L4_WLT_',num2str(i));
%    img = imread(img_Name); %for files ohne Endung
    %Import und Umwandlung in Grauwert-Bilder
    img = img(:,:,1); %holt sich die Werte aus dem roten Kanal
    img = im2double(img); %ändert alle Werte auf ein double zwischen 0 und 1
    img = uint8(255*mat2gray(img)); %passt alle Pixel auf Grauwerte zwischen 0 und 255 an
    img = img((Peripherie+1):Rows-Peripherie,(Peripherie+1):Columns-Peripherie); %Peripherie rausschneiden wegen ggf Artefakten
    imgSize = size(img); %Check um zu wissen, ob die Peripherie richtig abgezogen wurde
    %Filter der Daten um Rauschen zu reduzieren
    img = wiener2(img,H);
    %Bearbeitung mit struct el, abgestimmt auf 8 mm Kugel und 10er-Feld
    sed = strel("disk",50); %über live sripts hier besten Wert finden
    ses = strel("square",600); %über live scripts hier besten Wert finden
    
    img_top_ball = imtophat(img,sed); %morphologisches opening mit sed um Kreis zu erhalten
    img_bot_field = imbothat(img,ses); %morphologisches closing mit ses um Feld zu erhalten
    
    %Binarizing der Images
    threshlevel_ball = graythresh(img_top_ball); %Feststellen welcher Level nach Otsu
    ball_bw = imbinarize(img_top_ball,threshlevel_ball);
    ball_bw = imclearborder(ball_bw); %nur die WL-Kugel - Kugelzentrum
    threshlevel_field = graythresh(img_bot_field);
    field_bw = imbinarize(img_bot_field,threshlevel_field);
    field_bw = imclearborder(field_bw,8); %nur das Feld drumherum -StrISO
    %montage({img, img_top_ball, ball_bw,img_bot_field,field_bw})
    
    %Eigenschaften der BW-Bilder
    stats_ball = regionprops(ball_bw);
    stats_field = regionprops(field_bw);
    %Kugelmittelpunkt auf iView-Zentrum normiert
    center_ball = stats_ball.Centroid;
    iViewBBC2d(:,i)=(center_ball-GlobalCenterPoint)*pixelSize;
    iViewBBC2d(2,i)=(-1)*iViewBBC2d(2,i); %weil Matlab links oben zum zählen beginnt
    %Feldmittelpunkt, also Zentralstrahl
    center_field = stats_field.Centroid;
    iViewCAX2d(:,i)=(center_field-GlobalCenterPoint)*pixelSize;
    iViewCAX2d(2,i)=(-1)*iViewCAX2d(2,i); %weil Matlab links oben zum zählen beginnt
    
    %Prüfparameter Kugel-Radius und Feldbreite
    ball_Area = stats_ball.Area;
    field_Area = stats_field.Area;
    ball_Radius(i) = sqrt(ball_Area/pi)*pixelSize;
    field_Width(i) = sqrt(field_Area)*pixelSize;
    %Darstellung Img + Centers
%     Img_title = strcat("L2 WL-Test ",num2str(i));
%     SaveName = strcat(folderName,"L2A_WLT_iV_",num2str(i));
%     if exist(SaveName, 'file')
%         %do nothing
%     else
%     imshow(img)
%     title(Img_title);
%     hold on
%     plot(center_field(1), center_field(2),'Color','magenta','Marker','+','MarkerSize',3)
%     plot(center_ball(1), center_ball(2),'Color','blue','Marker','o','MarkerSize',3)
%     hold off
%     saveas(gcf,SaveName,'pdf');
%     close
%     end
end