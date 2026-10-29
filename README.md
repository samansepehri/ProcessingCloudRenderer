# ProcessingCloudRenderer
It's an experimental journey to build a light cloud renderer in [Processing.cpp](https://processing-cpp.github.io). 

## Iteration 0
<img width="716" height="472" alt="Screenshot 2026-10-20 at 2 44 31 PM" src="https://github.com/user-attachments/assets/9f6cfa96-5174-49af-81c4-3e0f818b3adf" />

A helloWorld-style cpp file to get some circles on screen to resemble a cloud.
- Writing to pixels based on circle SDFs
- A blue background for the sky

## Iteration 1
<img width="716" height="473" alt="Screenshot 2026-10-28 at 10 36 06 PM" src="https://github.com/user-attachments/assets/76ca57b1-50bf-4490-985e-e78e54e9d1b2" />

The cloud is getting some noise treatments!
- Using the noise() method to add high/low frequencies on top of the cloud SDFs
- The sky has a vertical gradient now
- Started MathHelpers to include operations like Saturate
- Circle SDF returns a real float instead of binary to get a smooth border
- The cloud volume is using a normalized circle SDF to make a union of the shapes using max()
