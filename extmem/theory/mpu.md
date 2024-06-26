# Why MPU configuration

The M7 core is capable to speculativly read data. Even from emories which are no there.

![img](./img/Slide23.svg)

So by default we disable access to all external memories. 
Then we enable acces only to memories which are really there and will be used. 

![img](./img/mpu.json)