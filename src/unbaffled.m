function [directivity] = unbaffled(frequency_range, angle_range, element_radius, sound_speed)
    %unbaffled calculates soft baffled models.
    %
    % DESCRIPTION:
    %     unbaffled calculates the directional response of hydrophones
    %     using the piston in a unbaffled model.
    %
    %     See reference [1] for more detail.
    %
    % USAGE:
    %     radius = unbaffled(frequency_range, angle_range, element_area, sound_speed)
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
        sound_speed, 'UB');
    
end