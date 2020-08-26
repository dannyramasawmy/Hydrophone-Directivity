function [response] = rigidPistonFiniteCore(frequency_range, angle_range,...
        fibre_radius, core_radius, sound_speed, normal_flag)
    %rigidPistonFiniteCore calculates rigid piston models with a finite core.
    %
    % DESCRIPTION:
    %     rigidPistonFiniteCore calculates the directional response of
    %     hydrophones using the rigid piston approximation.
    %
    %     See reference [2] for more detail, especially to understand the
    %     equations implemented below.
    %
    % USAGE:
    %     radius = rigidPistonFiniteCore(frequency_range, angle_range,...
    %           fibre_radius, core_radius, sound_speed, normal_flag)
    % INPUTS:
    %     frequency_range - 1D vector of frequencies [Hz]
    %     angle_range     - 1D vector of angles [degrees]
    %     fibre_radius    - scalar value of fibre radius [m]
    %     core_radius     - scalar value of the inner core radius [m]
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
    
        
    % calculate the frequency response
    if normal_flag == true
        
        % function handle for b term (see [2])
        b = @(r, theta) (sqrt((r.^2 .* cos(theta).^2) ...
            +(fibre_radius.^2 - r.^2)) - (r.*cos(theta)));
      
        % intialise
        response = zeros(length(frequency_range), 1);
        
        for frequency_idx = 1:length(frequency_range)
            % get frequency

            omega = 2*pi * frequency_range(frequency_idx);
            
            % integrand
            fun = @(r, theta) (r.*exp( -1i .* omega .* b(r, theta) ./ sound_speed ));
            
            % limits
            r_min = 0;
            r_max = core_radius;
            theta_min = 0;
            theta_max = 2*pi;
            % integral
            q = integral2(fun, r_min, r_max, theta_min, theta_max);
            
            % frequency response
            response(frequency_idx) = 2 - (1/(pi*core_radius^2))*q;
        end
        
        % exit function (do not calculate directivity)
        return
    end
    
    % =====================================================================
    %   DIRECTIONAL RESPONSE
    % =====================================================================
    % initalise
    response = zeros(length(frequency_range), length(angle_range));
    
    % warning as this calculation can be slow
    warning('The finite core directivity model can take a few minutes to run.')
    
    for angle_idx = 1:length(angle_range)
        for frequency_idx = 1:length(frequency_range)
            
            % get frequency
            omega = 2*pi * frequency_range(frequency_idx);
            
            % incident wave angle
            vartheta = angle_range(angle_idx) * pi/180;
            
            % wavenumber
            k = omega / sound_speed;
            
            % first integral
            amin = -core_radius;
            amax = +core_radius;
            fun1 = @(x) (sqrt(core_radius.^2 - x.^2) ...
                .* exp(-1i.*k.*x.*sin(vartheta)));
            first_term = integral(fun1, amin, amax) * 2/(pi*core_radius.^2);
            
            % second integral function handles
            st = @(r,rp,phi,phip) (sqrt(r.^2 + rp.^2 - 2.*r.*rp.*cos(phip-phi)));
            fun2 =@(r,phi,rp,phip) ((exp(-1i.*k.*rp.*cos(phip).*sin(vartheta)) ...
                .* exp(-1i.*k.*st(r,rp,phi,phip)) .*r.*rp)...
                ./(2.*pi.*st(r,rp,phi,phip)));
            
            % limits
            rmin = 0;
            rmax = core_radius;
            rpmin = 0;
            rpmax = fibre_radius;
            phimin = 0;
            phimax = 2*pi;
            phipmin = 0;
            phipmax = 2*pi;
            
            % second (quadruple) integral
            q = integral2(@(r,phi)arrayfun(...
                @(r,phi)integral2(...
                @(rp,phip)fun2(r,phi,rp,phip),rpmin,rpmax,phipmin,phipmax),r,phi)...
                ,rmin,rmax,phimin,phimax);
            second_term = (1i.*k*cos(vartheta))./(pi*core_radius^2) .*q;
            
            % get directivity
            response(frequency_idx, angle_idx) = first_term + second_term;
        end        
    end
    
end