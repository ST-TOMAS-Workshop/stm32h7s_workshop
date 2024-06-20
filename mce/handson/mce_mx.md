----!
Presentation
----!

# MCE1

1. Select `MCE1` for **Bootloader** and **ExtMem Loader**.
2. In `Mode` ensure the **Activated** checkbox is checked.

![alt text](img/24_06_06_481.png)


# HPDMA (High-Performance Direct Memory Access)

For encryption to work the memory must be in memory-mapped mode. But we need to guarantee the correct acccesses which will be only write. For this reason the DMA must be used for write data to OSPI. 
To ensure successful encryption, the memory must be operated in memory-mapped mode. Additionally, it is essential to ensure that access is restricted to write-only operations. Therefore, the Direct Memory Access (DMA) should be utilized to write data to the Octal SPI (OSPI).

1. Select **HPDMA1**.
2. Set `Channel15`  to **Standard request mode**.

![hdma](img/24_06_06_482.png)

3. Go to the `SECURITY` tab.
4. Set `Enable Channel as Priviledged` to **PRIVILEDGED**.

![security](img/24_06_06_484.png)

5. Navigate to the `CH15` tab.
6. Set `Source Address Increment After Transfer` to **ENABLE**.
7. Set `Source Burst Length` to **16** (needed by MCE!).
8. Set `Destination Address Increment After Transfer` to **ENABLE**.
9. Set `Destination Burst Length` to **16** (needed by MCE!).

![hdma config](img/24_06_06_486.png)

Now we can **generate code**.