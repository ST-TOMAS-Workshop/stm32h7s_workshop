# OSPI Low voltage setup

The OSPI on nucleo isrunning at 1.8V. In normal situation it will have limited speed on STM32.
However we can enable a HSLV(high speed low voltage) feature.

Where to enable HSLV:
- option bytes (Cube Programmer)
- SBS periphery

# HSLV - High speed low voltage

The xSPI1/2 have independent power domains. They can from from 1.8V to 3.3V. 
However to 2.6V they can run at 200MHz. But below the speed is reduced. 
To solve this issue a HSLV feature can be enabled to allow the pins run max speed. 

This must be done in:
- SBS periphery
- And in Option bytes

Both must be applied to have HSLV functional.


> [!CAUTION]
> If HSLV is used and power of xSPI is >2.6V it will damage the device


![](../theory/img/Slide29.svg)
![](../theory/img/Slide30.svg)
![](../theory/img/Slide31.svg)
![](../theory/img/Slide32.svg)
![](../theory/img/Slide33.svg)


# STM32CubeProgrammer

1. Click to `Connect`
2. Select `Option bytes`
3. Select `User configuration 1`
4. Enable `XSPI2_HSLV`

![cube programmer](./img/24_03_11_433.gif)

# [CubeMX part](extmem_mx.md)