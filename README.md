# Hydrophone-Directivity
This small toolbox contains simple functions for modelling hydrophone directivity and could be used to estimate the effective element area. These are the rigid-baffle (RB), unbaffled (UB), soft-baffled (SB) and rigid-piston (RP) models [1,2]. Please read references [1] and [2] for more detailed information about their use cases and limitations.

## Contact
- **Author** - Danny Ramasawmy
- **Email**  - rmapdrr@ucl.ac.uk

## Installation
- Requires MATLAB 2016a+ (Not tested on previous versions but should work correctly.)
- Add a path to the folder to the working directory:
```
addpath(genpath(<path to the toolbox>))
``` 
- Try the example scripts in the examples folder and edit for your own cases

## Main Functions
A quick list of the main functions, see the examples for more details:
```matlab
% rigid baffle model 
rigidBaffle(...)
% soft baffle model 
softBaffle(...)
% unbaffled model
unbaffled(...)
% rigid piston with a point core
rigidPistonPointCore(...)
% rigid piston with a finite core
rigidPistonFiniteCore(...)
```

## Tree
Tree compiled on 26 August 2020:
```bash
.
├── examples
│   ├── example_rigid_piston.m
│   └── example_rigid_soft_un_baffled.m
├── README.md
└── src
    ├── RBUBSB.m
    ├── rigidBaffle.m
    ├── rigidPistonFiniteCore.m
    ├── rigidPistonPointCore.m
    ├── softBaffle.m
    └── unbaffled.m
```


## References
- [1] **Wear, Keith A., and Samuel M. Howard.** "Directivity and Frequency-Dependent Effective Sensitive Element Size of a Reflectance-Based Fiber-Optic Hydrophone: Predictions From Theoretical Models Compared With Measurements." *IEEE transactions on ultrasonics, ferroelectrics, and frequency control* (2018).
- [2] **Krücker, Jochen F., et al.** "Rigid piston approximation for computing the transfer function and angular response of a fiber-optic hydrophone." *The Journal of the Acoustical Society of America* (2000).