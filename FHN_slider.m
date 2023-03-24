
%%%%%%%%%%%%%%%%%%%%%%%%%
%% USER SET PARAMETERS %%
%%%%%%%%%%%%%%%%%%%%%%%%%

% Givens
a = 1.25;
b = 25;

% Graphical
v_min = -2;
v_max = 2;
n_min = -2;
n_max = 2;
q_density = 30; % n of quivers

% Initial Point
v0 = -1;
n0 = -2;

% Slider
slider_min = 0.25;
slider_max = 0.75;
slider_init = 0.54; % initial value



%%%%%%%%%%%%%%%%%%%%%
%% DONT EDIT BELOW %%
%%%%%%%%%%%%%%%%%%%%%

% create the slider
slider = uicontrol('style', 'slider',...
    'min', slider_min, 'max', slider_max, 'value', slider_init,...
    'position', [100 20 400 20],...
    'callback', @slider_callback);

% create the initial plot
I = slider_init;

% define the x and y ranges for the plot
v_range = linspace(v_min, v_max, q_density); % x
n_range = linspace(n_min, n_max, q_density); % y

% create a grid of x and y values
[v, n] = meshgrid(v_range, n_range);

% compute the derivatives x' and y'
vdot = v-v.^3/3-n+I;
ndot = (a*v-n)/b;

% create the quiver plot
q = quiver(v, n, vdot, ndot);
% set the axis limits and labels
xlim([v_min v_max]);
ylim([n_min n_max]);

% Create additional pieces of plot
% Grab the IVP solution
[t, numsol] = ode45(@(t,y) fitzhugh_nagumo(t,y,I), [0 500], [v0; n0]);

% null clines
hold on
fplot(@(x) a*x, ...
    'LineStyle', '--');
fplot(@(x) x - x^3/3+I, ...
    'LineStyle', '--');
plot(numsol(:,1), numsol(:,2))
hold off

%f1=figure;
%f1=plot(t,numsol(:,1));

% define the slider callback function
function slider_callback(hObject, ~)
% get the slider value
    I = get(hObject, 'value');
    
    a = 1.25;
    b = 25;
    
    % Graphical
    v_min = -2;
    v_max = 2;
    n_min = -2;
    n_max = 2;
    q_density = 30; % n of quivers
    
    % Initial Point
    v0 = -1;
    n0 = -2;

    % define the x and y ranges for the plot
    v_range = linspace(v_min, v_max, q_density); % x
    n_range = linspace(n_min, n_max, q_density); % y
    
    % create a grid of x and y values
    [v, n] = meshgrid(v_range, n_range);
    
    % compute the derivatives x' and y'
    vdot = v-v.^3/3-n+I;
    ndot = (a*v-n)/b;
    
    % create the quiver plot
    q = quiver(v, n, vdot, ndot);
    % set the axis limits and labels
    xlim([v_min v_max]);
    ylim([n_min n_max]);
    
    % Create additional pieces of plot
    % Grab the IVP solution
    [t, numsol] = ode45(@(t,y) fitzhugh_nagumo(t,y,I), [0 500], [v0; n0]);
    
    % null clines
    hold on
    fplot(@(x) a*x, ...
        'LineStyle', '--');
    fplot(@(x) x - x^3/3+I, ...
        'LineStyle', '--');
    plot(numsol(:,1), numsol(:,2))
    hold off
    
    %f1=plot(t,numsol(:,1));

end
