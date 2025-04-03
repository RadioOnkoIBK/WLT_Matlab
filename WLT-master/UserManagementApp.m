classdef UserManagementApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure        matlab.ui.Figure
        AddButton       matlab.ui.control.Button
        DeleteButton    matlab.ui.control.Button
        DisplayButton   matlab.ui.control.Button
        UserList        matlab.ui.control.ListBox
        ExportButton    matlab.ui.control.Button
        ImportButton    matlab.ui.control.Button
    end

    % Properties for user and password lists
    properties (Access = public)
        userList = {}; % Cell array to store the list of users
        passwordList = {}; % Cell array to store the list of passwords
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UserList.Items = {};
        end

        % Button pushed function: AddButton
        function AddButtonPushed(app, event)
            newUser = inputdlg('Enter the username:', 'Add User', [1 40]);
            if ~isempty(newUser)
                newPassword = inputdlg('Enter the password:', 'Add Password', [1 40]);
                if ~isempty(newPassword)
                    app.userList{end + 1} = newUser{1};
                    app.passwordList{end + 1} = newPassword{1};
                    app.UserList.Items{end + 1} = newUser{1};
                end
            end
        end

        % Button pushed function: DeleteButton
        function DeleteButtonPushed(app, event)
            selectedUser = app.UserList.Value;
            if ~isempty(selectedUser)
                idx = find(strcmp(app.userList, selectedUser));
                app.userList(idx) = [];
                app.passwordList(idx) = [];
                app.UserList.Items(ismember(app.UserList.Items, selectedUser)) = [];
            end
        end

        % Button pushed function: DisplayButton
        function DisplayButtonPushed(app, event)
            disp('Current users:');
            disp(app.userList);
        end

        % Button pushed function: ExportButton
        function ExportButtonPushed(app, event)
            fileID = fopen('user_list.txt','w');
            for i = 1:length(app.userList)
                fprintf(fileID,'%s:%s\n', app.userList{i}, app.passwordList{i});
            end
            fclose(fileID);
            disp('User list exported successfully.');
        end

        % Button pushed function: ImportButton
        function ImportButtonPushed(app, event)
            fileID = fopen('user_list.txt','r');
            data = textscan(fileID, '%s', 'Delimiter', '\n');
            fclose(fileID);
            userData = data{1};
            for i = 1:length(userData)
                parts = strsplit(userData{i}, ':');
                app.userList{end + 1} = parts{1};
                app.passwordList{end + 1} = parts{2};
                app.UserList.Items{end + 1} = parts{1};
            end
            disp('User list imported successfully.');
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = UserManagementApp

            % Create UIFigure and components
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 318 285];
            app.UIFigure.Name = 'User Management';

            app.AddButton = uibutton(app.UIFigure, 'push');
            app.AddButton.ButtonPushedFcn = createCallbackFcn(app, @AddButtonPushed, true);
            app.AddButton.Position = [38 223 100 22];
            app.AddButton.Text = 'Add';

            app.DeleteButton = uibutton(app.UIFigure, 'push');
            app.DeleteButton.ButtonPushedFcn = createCallbackFcn(app, @DeleteButtonPushed, true);
            app.DeleteButton.Position = [155 223 100 22];
            app.DeleteButton.Text = 'Delete';

            app.DisplayButton = uibutton(app.UIFigure, 'push');
            app.DisplayButton.ButtonPushedFcn = createCallbackFcn(app, @DisplayButtonPushed, true);
            app.DisplayButton.Position = [38 180 217 22];
            app.DisplayButton.Text = 'Display';

            app.UserList = uilistbox(app.UIFigure);
            app.UserList.Position = [38 22 217 148];

            app.ExportButton = uibutton(app.UIFigure, 'push');
            app.ExportButton.ButtonPushedFcn = createCallbackFcn(app, @ExportButtonPushed, true);
            app.ExportButton.Position = [38 257 100 22];
            app.ExportButton.Text = 'Export';

            app.ImportButton = uibutton(app.UIFigure, 'push');
            app.ImportButton.ButtonPushedFcn = createCallbackFcn(app, @ImportButtonPushed, true);
            app.ImportButton.Position = [155 257 100 22];
            app.ImportButton.Text = 'Import';
        end
    end
end