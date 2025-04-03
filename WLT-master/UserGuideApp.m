classdef UserGuideApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure      matlab.ui.Figure
        UserButton    matlab.ui.control.Button
        WLTButton     matlab.ui.control.Button
        StepText      matlab.ui.control.TextArea
        NextButton    matlab.ui.control.Button
        CloseButton   matlab.ui.control.Button
        MatlabTestButton matlab.ui.control.Button
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = UserGuideApp

            % Create UIFigure and components
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 500 400];
            app.UIFigure.Name = 'User Guide';

            app.UserButton = uibutton(app.UIFigure, 'push');
            app.UserButton.ButtonPushedFcn = createCallbackFcn(app, @UserButtonPushed, true);
            app.UserButton.Position = [50 300 150 22];
            app.UserButton.Text = 'Start User Management';

             % Create MatlabTestButton
            app.MatlabTestButton = uibutton(app.UIFigure, 'push');
            app.MatlabTestButton.ButtonPushedFcn = createCallbackFcn(app, @MatlabTestButtonPushed, true);
            app.MatlabTestButton.Position = [300 350 150 22]; % Adjust position as needed
            app.MatlabTestButton.Text = 'Open Test Image';

            app.WLTButton = uibutton(app.UIFigure, 'push');
            app.WLTButton.ButtonPushedFcn = createCallbackFcn(app, @WLTButtonPushed, true);
            app.WLTButton.Position = [300 300 150 22];
            app.WLTButton.Text = 'Start WLT';

            app.StepText = uitextarea(app.UIFigure);
            app.StepText.Editable = 'off';
            app.StepText.Position = [50 80 400 200];

            app.NextButton = uibutton(app.UIFigure, 'push');
            app.NextButton.ButtonPushedFcn = createCallbackFcn(app, @NextButtonPushed, true);
            app.NextButton.Position = [200 30 100 22];
            app.NextButton.Text = 'Next';

            app.CloseButton = uibutton(app.UIFigure, 'push');
            app.CloseButton.ButtonPushedFcn = createCallbackFcn(app, @CloseButtonPushed, true);
            app.CloseButton.Position = [400 20 70 22];
            app.CloseButton.Text = 'Close';
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: UserButton
        function UserButtonPushed(app, ~)
            UserManagementApp; % Open the UserManagementApp
        end

        % Callback function for MatlabTestButton
        function MatlabTestButtonPushed(app, ~)
            matlabtest(); % Call the matlabtest function
        end

        % Button pushed function: WLTButton
        function WLTButtonPushed(app, ~)
            % Implement the functionality for the "Start WLT" button
            disp('WLT App is starting...');
            % Add your code for starting the WLT app here
        end

        % Button pushed function: NextButton
        function NextButtonPushed(app, ~)
            % Implement the step-by-step process
            steps = {'Step 1: Click "Add" to add a new user.', 'Step 2: Enter the username and password.', 'Step 3: Click "Delete" to delete a user.', 'Step 4: Click "Display" to see the current users.', 'Step 5: Click "Export" to save the user list.', 'Step 6: Click "Import" to load a user list.'};
            persistent stepIndex;
            if isempty(stepIndex)
                stepIndex = 1;
            else
                stepIndex = stepIndex + 1;
                if stepIndex > length(steps)
                    stepIndex = 1; % Restart the steps if all are completed
                end
            end
            app.StepText.Value = steps{stepIndex};
        end

        % Button pushed function: CloseButton
        function CloseButtonPushed(app, ~)
            delete(app.UIFigure); % Close the app
        end
    end
end