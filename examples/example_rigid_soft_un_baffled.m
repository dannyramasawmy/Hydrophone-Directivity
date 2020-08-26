%example_rigid_soft_un_baffled
%
% DESCRIPTION:
%     This example uses the functions for the rigid-/soft-/un- baffled
%     models. These are standard models for hydrophone directivity, see [1]
%     for more details and examples.
%
%     [1] Wear, Keith A., and Samuel M. Howard. "Directivity and
%     Frequency-Dependent Effective Sensitive Element Size of a
%     Reflectance-Based Fiber-Optic Hydrophone: Predictions From
%     Theoretical Models Compared With Measurements." IEEE transactions on
%     ultrasonics, ferroelectrics, and frequency control (2018).
%
% ABOUT:
%     author      - Danny Ramasawmy date        - 26th August 2020 last
%     update - 26th August 2020

clear all
close all
addpath(genpath('../'))

% =========================================================================
%   DEFINE SIMULATION PARAMETERS
% =========================================================================

% frequency
frequency_range = linspace(0.1,50,100) * 1e6;
% angles
angle_range = linspace(-70,70,151);
% sensor (effective) element radius
element_radius = 100e-6;
% speed of sound of the fluid
sound_speed = 1480;

% =========================================================================
%   PLOT DIRECTIVITY MAP
% =========================================================================

% use the rigid baffle model
[directivity_RB] = rigidBaffle(frequency_range, angle_range, ...
    element_radius, sound_speed);

% use the soft baffle model
[directivity_SB] = softBaffle(frequency_range, angle_range, ...
    element_radius, sound_speed);

% use the unbaffled model
[directivity_UB] = unbaffled(frequency_range, angle_range, ...
    element_radius, sound_speed);

% =========================================================================
%   PLOT DIRECTIVITY MAP
% =========================================================================

% plot directivity
figure(1);
subplot(1,3,1)
imagesc(angle_range, frequency_range/1e6, (abs(directivity_RB)))
% labels
xlabel('Angle')
ylabel('Frequency [MHz]')
axis xy square
title('Rigid-Baffle')

subplot(1,3,2)
imagesc(angle_range, frequency_range/1e6, (abs(directivity_SB)))
% labels
xlabel('Angle')
ylabel('Frequency [MHz]')
axis xy square
title('Soft-Baffle')

subplot(1,3,3)
imagesc(angle_range, frequency_range/1e6, (abs(directivity_UB)))
% labels
xlabel('Angle')
ylabel('Frequency [MHz]')
axis xy square
title('Unbaffled')

% =========================================================================
%   PLOT DIRECTIVITY PROFILES
% =========================================================================

% plot profiles
figure(2)

counter = 0;
for idx = 1:10:length(frequency_range)
    % plot counter
    counter = counter + 1;
    % 10 plot
    subplot(2, 5, counter)
    
    hold on
    plot(angle_range, abs(directivity_RB(idx,:)), 'r' )
    plot(angle_range, abs(directivity_SB(idx,:)), 'g--' )
    plot(angle_range, abs(directivity_UB(idx,:)), 'm-.' )
    hold off
    
    %labels
    if idx == 1
        legend('RB','SB', 'UB')
    end
    
    xlabel('Angle [\circ]')
    ylabel('Magnitude')
    title([num2str(round(frequency_range(idx)/1e6)), ' [MHz]'])
    axis square
    xlim([-70 70])
    ylim([0 1])
end

