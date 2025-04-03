files = dir(fullfile(images_path, '*.'));
files=files(~ismember({files.name},{'.','..'}));
disp(files);
for i=1:length(files)
     img=readHISfile(images_path); 
end