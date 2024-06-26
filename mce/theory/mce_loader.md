# MCE and external loader

To write data into memory we cannot use caore because it guaranee the burst write. For this we need to use a DMA

![](./img/mce_write.json)

# ExtMem mamanger write


By default external memory manager is ising comands to write data and not memory more. We must change this. 

We can override

We can ovverride function `memory_write` and check if it is write to memory (write is equeal to **PAGE size**)

This will allow to enable memory mapped write to be used. 

But by default the function use only **memcpy** but we need to use **DMA**

So we can override also `EXTMEM_MemCopy` function and use DMA to copy data to memory. 

![](./img/mce_dma.json)


