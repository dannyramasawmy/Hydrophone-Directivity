function [response] = rigidPistonPointCore(frequency_range, angle_range,...
        fibre_radius, sound_speed, normal_flag)
    %rigidPistonPointCore calculates rigid piston models with a point core.
    %
    % DESCRIPTION:
    %     rigidPistonPointCore calculates the directional response of
    %     hydrophones using the rigid piston approximation. This is faster
    %     than rigidPistonFiniteCore and is appropriate for small fibre
    %     cores.
    %
    %     See reference [2] for more detail.
    %
    % USAGE:
    %     response = rigidPistonPointCore(frequency_range, angle_range,...
    %           fibre_radius, sound_speed, normal_flag)
    % INPUTS:
    %     frequency_range - 1D vector of frequencies [Hz]
    %     angle_range     - 1D vector of angles [degrees]
    %     fibre_radius    - scalar value of fibre radius [m]
    %     sound_speed     - scalar value sound_speed [m/s]
    %     normal_flag     - boolean if true then just calculates the
    %                       frequency response (fast), false = directivity
    %
    % OPTIONAL INPUTS:
    %     No optional inputs.
    %
    % OUTPUTS:
    %     response   - 2D matrix of the complex directivity,
    %                       FREQUENCY X ANGLE if normal_flag == false
    %                       FREQUENCY X 1 if normal_flag == true
    %
    % DEPENDENCIES:
    %	  integral2 MATLAB function.
    %
    % ABOUT:
    %     author      - Danny Ramasawmy
    %     date        - 26th August 2020
    %     last update - 26th August 2020
    
    % =====================================================================
    %   FREQUENCY RESPONSE
    % =====================================================================
    if normal_flag == true
        
        % initialize
        response = zeros(length(frequency_range), 1);
        
        for frequency_idx = 1:length(frequency_range)
            % get circular frequency
            omega = 2*pi * frequency_range(frequency_idx);
            
            % frequency response
            response(frequency_idx) = ...
                2 - exp((-1i * omega * fibre_radius) / sound_speed);
        end
        
        % exit function (do not calculate directivity)
        return
    end

    % =====================================================================
    %   DIRECTIONAL RESPONSE
    % =====================================================================
    % initialize
    response = zeros(length(frequency_range), length(angle_range));
    
    for angle_idx = 1:length(angle_range)
        for frequency_idx = 1:length(frequency_range)
            
            % get frequency
            omega = 2*pi * frequency_range(frequency_idx);
            
            % incident wave angle
            vartheta = angle_range(angle_idx) * pi/180;
            
            % wavenumber
            k = omega / sound_speed;
            
            % top and bottom of integrand
            bottom  = @(phi) (1 + cos(phi) .* sin(vartheta));
            top     = @(phi) (1 - exp(-1i .* k .* fibre_radius .* (bottom(phi))));
            % integrand
            int_fun = @(phi) (top(phi) ./ bottom(phi));
            
            % limits
            phi_min = 0;
            phi_max = 2*pi;
            q = integral(int_fun, phi_min, phi_max);
            
            % get directivity
            response(frequency_idx, angle_idx) = ...
                (1 + ((cos(vartheta) / (2*pi)) * q));
        end
    end
     
end