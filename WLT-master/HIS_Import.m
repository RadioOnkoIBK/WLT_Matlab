
function displayFilesInFolder(folder_path)
    % Get a list of all files in the folder
    file_list = dir(folder_path);

    % Iterate through the list of files
    for i = 1:length(file_list)
        if ~file_list(i).isdir
            % Display the file name
            disp(file_list(i).name);

            % Read and display the content of the file (if it's a text file)
            [~, ~, file_extension] = fileparts(file_list(i).name);
            if strcmpi(file_extension, '.txt')
                file_contents = fileread(fullfile(folder_path, file_list(i).name));
                disp(file_contents);
            else readHISfile(folder_path);
            end
        end
    end
end