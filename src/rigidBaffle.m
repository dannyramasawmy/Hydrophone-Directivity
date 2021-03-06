function [directivity] = rigidBaffle(frequency_range, angle_range, element_radius, sound_speed)
    %rigidBaffle calculates rigid baffled models.
    %
    % DESCRIPTION:
    %     rigidBaffle calculates the directional response of hydrophones
    %     using the piston in a rigid-baffled model.
    %
    %     See reference [1] for more detail.
    %
    % USAGE:
    %     directivity = rigidBaffle(frequency_range, angle_range, element_area, sound_speed)
    %
    % INPUTS:
    %     frequency_range - 1D vector of frequencies [Hz]
    %     angle_range     - 1D vector of angles [degrees]
    %     element_radius  - scalar value of radius [m]
    %     sound_speed     - scalar value sound_speed [m/s]
    %
    % OPTIONAL INPUTS:
    %     No optional inputs.
    %
    % OUTPUTS:
    %     directivity   - 2D matrix of the complex directivity, 
    %                       FREQUENCY X ANGLE
    %
    % DEPENDENCIES:
    %	  RBUBSB function.
    %
    % ABOUT:
    %     author      - Danny Ramasawmy
    %     date        - 26th August 2020
    %     last update - 26th August 2020
    
    % calculate the directivity
    directivity = RBUBSB(frequency_range, angle_range, element_radius, ...
        sound_speed, 'RB');
    
end