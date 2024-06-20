----!
Presentation
----!

# STM32H7R/S bootflash MCU + OSPI + MCE example

We will utilize an existing OSPI example for the STM32H7R/S series, which can be found under
[this link](https://github.com/ST-TOMAS-Examples-ExtMem)


In this example, the Memory Cipher Engine (MCE) will be employed to protect our code and data through the on-the-fly encryption/decryption. 
The Memory Cipher Engine (MCE) will encrypt the data within the external memory loader, while decryption will be carried out in the bootloader or the application itself.
