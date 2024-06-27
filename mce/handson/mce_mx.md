----!
Presentation
----!

# MCE1

1. Select `MCE1` for **Bootloader** and **ExtMem Loader**.
2. In `Mode` ensure the **Activated** checkbox is checked.

![alt text](./img/24_06_06_481.png)


# HPDMA (High-Performance Direct Memory Access)

For encryption to work the memory must be in memory-mapped mode. But we need to guarantee the correct acccesses which will be only write. For this reason the DMA must be used for write data to OSPI. 
To ensure successful encryption, the memory must be operated in memory-mapped mode. Additionally, it is essential to ensure that access is restricted to write-only operations. Therefore, the Direct Memory Access (DMA) should be utilized to write data to the Octal SPI (OSPI).

1. Select **HPDMA1**.
2. Set `Channel15`  to **Standard request mode**.

Now we can **generate code**.