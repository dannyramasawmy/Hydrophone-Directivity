function [directivity] = RBUBSB(frequency_range, angle_range, element_radius, ...
        sound_speed, model_flag)
    %RBUBSB calculates rigid/soft/unbaffled models.
    %
    % DESCRIPTION:
    %     RBUBSB calculates the directional response of hydrophones
    %     using the piston in a rigid-/soft-/un- baffled model.
    %
    %     See reference [1] for more detail.
    %
    % USAGE:
    %     radius = RBUBSB(frequency_range, angle_range, element_area,... 
    %           sound_speed, model_flag)
    %
    % INPUTS:
    %     frequency_range - 1D vector of frequencies [Hz]
    %     angle_range     - 1D vector of angles [degrees]
    %     element_radius  - scalar value of radius [m]
    %     sound_speed     - scalar value sound_speed [m/s]
    %     model_flag      - string that is either:
    %                       'RB' - rigid baffle
    %                       'SB' - soft baffle
    %                       'UB' - unbaffled
    %
    % OPTIONAL INPUTS:
    %     No optional inputs.
    %
    % OUTPUTS:
    %     directivity   - 2D matrix of the complex directivity
    %
    % DEPENDENCIES:
    %	  No dependecies.
    %
    % ABOUT:
    %     author      - Danny Ramasawmy
    %     date        - 26th August 2020
    %     last update - 26th August 2020
    
    
    % range of angles in radians
    theta_range = angle_range * pi /180;
    
    % intitalise directivity
    directivity = zeros(length(frequency_range), length(theta_range));
    
    % loop and calculate
    for frequency_idx = 1:length(frequency_range)
        for theta_idx = 1:length(theta_range)
            
            % calculate wavenumber
            wavenumber = 2*pi/sound_speed * frequency_range(frequency_idx);
            ka = wavenumber * element_radius * sin(theta_range(theta_idx));
            
            % switch calculation depending on flag
            switch model_flag
                case 'RB'
                    % Rigid Baffle Piston
                    directivity(frequency_idx,theta_idx) = ...
                        2 * besselj(1, ka) ./ ka;
                case 'SB'
                    % Soft Baffle Piston
                    directivity(frequency_idx,theta_idx) = ...
                        (2 * besselj(1, ka) ./ ka) ...
                        * cos(theta_range(theta_idx));
                case 'UB'
                    % Un-Baffle Piston
                    directivity(frequency_idx,theta_idx) = ...
                        (2 * besselj(1, ka) ./ ka) ...
                        * ( (1 + cos(theta_range(theta_idx))) /2 );
            end
            
            % if the angle is zero == 1 in the limit
            if theta_range(theta_idx) == 0
                directivity(frequency_idx,theta_idx) = 1;
            end
        end
    end
      
end