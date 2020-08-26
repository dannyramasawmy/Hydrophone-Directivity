
frequency_range = linspace(0.1,50,100) * 1e6;
angle_range = linspace(-70,70,151);
element_radius = 100e-6;

sound_speed = 1500;

[directivity] = rigidBaffle(frequency_range, angle_range, element_radius, ...
    sound_speed);

[directivity] = softBaffle(frequency_range, angle_range, element_radius, ...
    sound_speed);


[directivity] = unbaffled(frequency_range, angle_range, element_radius, ...
    sound_speed);