function matlabtest()
    % Path to the image file
    imageFile = 'C:/Users/q236sk/MatLab/01_WLT/test.png';

    % Check if the file exists
    if exist(imageFile, 'file')
        % Display the image
        imshow(imageFile);
    else
        % Display an error message if the file does not exist
        error('Image file does not exist.');
    end
end
