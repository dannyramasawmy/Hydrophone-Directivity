%example_rigid_piston
%
% DESCRIPTION:
%     This example uses the rigid piston functions for modelling the
%     frequency response and directivity of fibre-optic hydrophones. The
%     functions are an implementation of [2] and reproduce some of the
%     figures for validation.
%
%     [2] Kr�cker, Jochen F., et al. 'Rigid piston approximation for
%     computing the transfer function and angular response of a fiber-optic
%     hydrophone.' The Journal of the Acoustical Society of America (2000).
%
% ABOUT:
%     author      - Danny Ramasawmy
%     date        - 26th August 2020
%     last update - 26th August 2020

clear all
close all
addpath(genpath('../'))

% =========================================================================
%   DEFINE SIMULATION AND FIBRE PARAMETERS
% =========================================================================

% frequencies
frequency_range = linspace(0.1e6, 30e6, 100); % 0 to 30 MHz
% angles
angle_range =  [0, 20, 40, 60, 80];
% fibre radius
fibre_radius = 62.5e-6; %  62.5 microns
% core radius
core_radius = 25e-6; % 25 thicker core, 2.5 small core almost point-like
% sound speed of fluid medium
sound_speed = 1480;


% =========================================================================
%   FREQUENCY RESPONSE
% =========================================================================
% set normal flag to be true for a frequency response curve
normal_flag = true;

% rigid piston approximation with a point-like core
[frequency_response_point] = rigidPistonPointCore(frequency_range, ...
    angle_range, fibre_radius, sound_speed, normal_flag);

% rigid piston approximation with a finite core
[frequency_response_finite] = rigidPistonFiniteCore(frequency_range, ...
    angle_range, fibre_radius, core_radius, sound_speed, normal_flag);

% =========================================================================
%   PLOT FREQUENCY RESPONSE (KRUCKER: FIGURE 4)
% =========================================================================

% plot figure
h1 = figure(1);
subplot(1,2,1)
hold on
plot(frequency_range/1e6, abs(frequency_response_point), 'k')
plot(frequency_range/1e6, abs(frequency_response_finite), 'k--')
hold off
%labels
xlabel('Frequency {MHz}')
ylabel('Magnitude')
legend('Point core','Finite core')
ylim([0 3])

subplot(1,2,2)
hold on
plot(frequency_range/1e6, angle(frequency_response_point), 'k')
plot(frequency_range/1e6, angle(frequency_response_finite), 'k--')
hold off
%labels
xlabel('Frequency {MHz}')
ylabel('Phase')
legend('Point core','Finite core')
ylim([-1 1])

% set
set(h1, 'Position', [238.6000 342 809.4000 420])
try
    % not available in all versions of matlab
    sgtitle('Frequency Response')
catch
end
% =========================================================================
%   DIRECTIONAL RESPONSE POINT CORE (KRUCKER: FIGURE 6)
% =========================================================================
% set normal flag to be false for a frequency response curve
normal_flag = false;

% rigid piston approximation with a point-like core
[directivity_point] = rigidPistonPointCore(frequency_range, ...
    angle_range, fibre_radius, sound_speed, normal_flag);

% plotting
plot_colors = 'rymbkg';
for angle_idx = 1:length(angle_range)
    h2 = figure(2);
    
    subplot(1,2,1)
    hold on
    plot(frequency_range/1e6, ...
        abs(directivity_point(:, angle_idx)), ...
        plot_colors(angle_idx), ...
        'DisplayName',[num2str(angle_range(angle_idx)),'^\circ'])
    %labels
    xlabel('Frequency [MHz]')
    ylabel('Magnitude')
    hold off
    ylim([0 3])
    legend
    
    subplot(1,2,2)
    hold on
    plot(frequency_range/1e6, ...
        angle(directivity_point(:, angle_idx)), ...
        plot_colors(angle_idx), ...
        'DisplayName',[num2str(angle_range(angle_idx)),'^\circ'])
    %labels
    xlabel('Frequency [MHz]')
    ylabel('Phase')
    ylim([-1 1])
    legend
    hold off
    drawnow;
end

% set
set(h2, 'Position', [238.6000 342 809.4000 420])
try
    % not available in all versions of matlab
    sgtitle('Fibre Directivity Point-Like Core')
catch
end
% =========================================================================
%   DIRECTIONAL RESPONSE FINITE CORE (KRUCKER: FIGURE 7)
% =========================================================================
% I believe there is an incorrect curve in Figure 7b in the paper, the
% normal incidence curve should match that of the dashed line in Figure 4b.

% rigid piston approximation with a finite core
[directivity_finite] = rigidPistonFiniteCore(frequency_range, ...
    angle_range, fibre_radius, core_radius, sound_speed, normal_flag);

% plotting
plot_colors = 'rymbkg';
for angle_idx = 1:length(angle_range)
    h3 = figure(3);
    
    subplot(1,2,1)
    hold on
    plot(frequency_range/1e6, ...
        abs(directivity_finite(:, angle_idx)), ...
        plot_colors(angle_idx), ...
        'DisplayName',[num2str(angle_range(angle_idx)),'^\circ'])
    %labels
    xlabel('Frequency [MHz]')
    ylabel('Magnitude')
    hold off
    ylim([0 3])
    legend;
    
    subplot(1,2,2)
    hold on
    plot(frequency_range/1e6, ...
        angle(directivity_finite(:, angle_idx)), ...
        plot_colors(angle_idx), ...
        'DisplayName',[num2str(angle_range(angle_idx)),'^\circ'])
    %labels
    xlabel('Frequency [MHz]')
    ylabel('Phase')
    ylim([-1 1])
    legend;
    hold off
    drawnow;
end

% set
set(h3, 'Position', [238.6000 342 809.4000 420])
try
    % not available in all versions of MATLAB
    sgtitle('Fibre Directivity Finite Core')
catch
end