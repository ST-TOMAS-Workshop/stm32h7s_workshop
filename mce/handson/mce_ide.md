----!
Presentation
----!

# Bootloader change

**Bootloader**

1. Navigate to the Bootloader **main.c** file.
2. Include the encryption/decryption key.
   
```c-nc
/* USER CODE BEGIN PV */
const uint32_t key[4] =     { 0x12345678, 0x0, 0x0, 0x0 };
/* USER CODE END PV */
```

For copy:

```c
const uint32_t key[4] =     { 0x12345678, 0x0, 0x0, 0x0 };
```

# confgiure MCD

3. Configure MCE and enable it.
   
```c-nc
/* USER CODE BEGIN 2 */
  {
    MCE_AESConfigTypeDef  AESConfig;
    MCE_RegionConfigTypeDef pConfig;
    MCE_NoekeonConfigTypeDef pConfigNeo;
    AESConfig.Nonce[0]=0x0;
    AESConfig.Nonce[1]=0x0;
    AESConfig.Version=0x0;
    AESConfig.pKey=key;
    HAL_MCE_ConfigAESContext(&hmce1,&AESConfig,MCE_CONTEXT1);
    HAL_MCE_EnableAESContext(&hmce1,MCE_CONTEXT1);

    pConfig.ContextID=MCE_CONTEXT1;
    pConfig.StartAddress=0x90000000;
    pConfig.EndAddress=0x92000000;
    pConfig.Mode=MCE_STREAM_CIPHER;
    pConfig.AccessMode=MCE_REGION_READONLY;
    pConfig.PrivilegedAccess=MCE_REGION_PRIV;
    HAL_MCE_ConfigRegion(&hmce1,MCE_REGION1,&pConfig);
    HAL_MCE_SetRegionAESContext(&hmce1,MCE_CONTEXT1,MCE_REGION1);
    HAL_MCE_EnableRegion(&hmce1,MCE_REGION1);
  }
  /* USER CODE END 2 */
  ```

For copy:

```c
  {
    MCE_AESConfigTypeDef  AESConfig;
    MCE_RegionConfigTypeDef pConfig;
    MCE_NoekeonConfigTypeDef pConfigNeo;
    AESConfig.Nonce[0]=0x0;
    AESConfig.Nonce[1]=0x0;
    AESConfig.Version=0x0;
    AESConfig.pKey=key;
    HAL_MCE_ConfigAESContext(&hmce1,&AESConfig,MCE_CONTEXT1);
    HAL_MCE_EnableAESContext(&hmce1,MCE_CONTEXT1);

    pConfig.ContextID=MCE_CONTEXT1;
    pConfig.StartAddress=0x90000000;
    pConfig.EndAddress=0x92000000;
    pConfig.Mode=MCE_STREAM_CIPHER;
    pConfig.AccessMode=MCE_REGION_READONLY;
    pConfig.PrivilegedAccess=MCE_REGION_PRIV;
    HAL_MCE_ConfigRegion(&hmce1,MCE_REGION1,&pConfig);
    HAL_MCE_SetRegionAESContext(&hmce1,MCE_CONTEXT1,MCE_REGION1);
    HAL_MCE_EnableRegion(&hmce1,MCE_REGION1);
  }
  ```

# invalidate caches

4. Add cache invalidation to ensure their contents are valid.

```c-nc
  /* USER CODE BEGIN 1 */
  SCB_InvalidateDCache();
  SCB_InvalidateICache();
  /* USER CODE END 1 */
```
  for copy:

```c
  SCB_InvalidateDCache();
  SCB_InvalidateICache();
```

# External Memory Loader change

**External Memory Loader**

1. Go to ExtMemLoader to file **extmemloader_init.c** in **Core/Src** folder.
2. Include the encryption/decryption key.
   
```c-nc
/* USER CODE BEGIN PV */
const uint32_t key[4] =     { 0x12345678, 0x0, 0x0, 0x0 };
/* USER CODE END PV */
```

For copy:

```c
const uint32_t key[4] =     { 0x12345678, 0x0, 0x0, 0x0 };
```

# Configure MCE

3. Configure MCE and enable it.

```c-nc
/* USER CODE BEGIN 2 */
  {
    MCE_AESConfigTypeDef  AESConfig;
    MCE_RegionConfigTypeDef pConfig;
    MCE_NoekeonConfigTypeDef pConfigNeo;
    AESConfig.Nonce[0]=0x0;
    AESConfig.Nonce[1]=0x0;
    AESConfig.Version=0x0;
    AESConfig.pKey=key;
    HAL_MCE_ConfigAESContext(&hmce1,&AESConfig,MCE_CONTEXT1);
    HAL_MCE_EnableAESContext(&hmce1,MCE_CONTEXT1);

    pConfig.ContextID=MCE_CONTEXT1;
    pConfig.StartAddress=0x90000000;
    pConfig.EndAddress=0x92000000;
    pConfig.Mode=MCE_STREAM_CIPHER;
    pConfig.AccessMode=MCE_REGION_READWRITE;
    pConfig.PrivilegedAccess=MCE_REGION_PRIV;
    HAL_MCE_ConfigRegion(&hmce1,MCE_REGION1,&pConfig);
    HAL_MCE_SetRegionAESContext(&hmce1,MCE_CONTEXT1,MCE_REGION1);
    HAL_MCE_EnableRegion(&hmce1,MCE_REGION1);
  }
  /* USER CODE END 2 */
  ```

For copy:

```c
  {
    MCE_AESConfigTypeDef  AESConfig;
    MCE_RegionConfigTypeDef pConfig;
    MCE_NoekeonConfigTypeDef pConfigNeo;
    AESConfig.Nonce[0]=0x0;
    AESConfig.Nonce[1]=0x0;
    AESConfig.Version=0x0;
    AESConfig.pKey=key;
    HAL_MCE_ConfigAESContext(&hmce1,&AESConfig,MCE_CONTEXT1);
    HAL_MCE_EnableAESContext(&hmce1,MCE_CONTEXT1);

    pConfig.ContextID=MCE_CONTEXT1;
    pConfig.StartAddress=0x90000000;
    pConfig.EndAddress=0x92000000;
    pConfig.Mode=MCE_STREAM_CIPHER;
    pConfig.AccessMode=MCE_REGION_READWRITE;
    pConfig.PrivilegedAccess=MCE_REGION_PRIV;
    HAL_MCE_ConfigRegion(&hmce1,MCE_REGION1,&pConfig);
    HAL_MCE_SetRegionAESContext(&hmce1,MCE_CONTEXT1,MCE_REGION1);
    HAL_MCE_EnableRegion(&hmce1,MCE_REGION1);
  }
  ```

# Redefine memory_write

4. We will redefine `memory_write` in our **extmemloader_init.c**.

```c-nc
 MEM_STATUS memory_write(uint32_t Address, uint32_t Size, uint8_t* buffer){
   MEM_STATUS retr = MEM_OK; /* No error returned */

   if(Size>=MAX_PAGE_WRITE){
     /* memory mapped write for 256B*/
     if (EXTMEM_WriteInMappedMode(STM32EXTLOADER_DEVICE_MEMORY_ID, Address, buffer, Size) != EXTMEM_OK)
     {
       retr = MEM_FAIL;
     }
   }else{
     /* normal byte write*/
     if (EXTMEM_Write(STM32EXTLOADER_DEVICE_MEMORY_ID, Address & 0x0FFFFFFFUL, buffer, Size) != EXTMEM_OK)
     {
       retr = MEM_FAIL;
     }
   }

   return retr;
 }
/* USER CODE END 0 */
```

for copy:

```c
 MEM_STATUS memory_write(uint32_t Address, uint32_t Size, uint8_t* buffer){
   MEM_STATUS retr = MEM_OK; /* No error returned */

   if(Size>=MAX_PAGE_WRITE){
     /* memory mapped write for 256B*/
     if (EXTMEM_WriteInMappedMode(STM32EXTLOADER_DEVICE_MEMORY_ID, Address, buffer, Size) != EXTMEM_OK)
     {
       retr = MEM_FAIL;
     }
   }else{
     /* normal byte write*/
     if (EXTMEM_Write(STM32EXTLOADER_DEVICE_MEMORY_ID, Address & 0x0FFFFFFFUL, buffer, Size) != EXTMEM_OK)
     {
       retr = MEM_FAIL;
     }
   }

   return retr;
 }
```

# Redefine memory copy

We now need to update the memory write process to utilize High-Performance Direct Memory Access controller (HPDMA) rather than the standard byte write method. 
This can be achieved by overriding the weak `EXTMEM_MemCopy` function with our own implementation that incorporates HPDMA.

6. Add HPDMA configuration to **extmemloader_init.c** file.

```c-nc
/* USER CODE BEGIN 0 */
  void EXTMEM_MemCopy(uint32_t* destination_Address, const uint8_t* ptrData, uint32_t DataSize){
    if(DataSize<MAX_PAGE_WRITE){
      memset(&buffer[DataSize],0xff,MAX_PAGE_WRITE-DataSize);
    }
    memcpy(buffer,ptrData,DataSize);
    if(DataSize<MAX_PAGE_WRITE){
      DataSize=MAX_PAGE_WRITE;
    }
    DMA_HandleTypeDef handle_HPDMA1_Channel15;
    HAL_Delay(2);
    __HAL_RCC_HPDMA1_CLK_ENABLE();
    handle_HPDMA1_Channel15.Instance = HPDMA1_Channel15;
    handle_HPDMA1_Channel15.Init.Request = DMA_REQUEST_SW;
    handle_HPDMA1_Channel15.Init.BlkHWRequest = DMA_BREQ_SINGLE_BURST;
    handle_HPDMA1_Channel15.Init.Direction = DMA_MEMORY_TO_MEMORY;
    handle_HPDMA1_Channel15.Init.SrcInc = DMA_SINC_INCREMENTED;
    handle_HPDMA1_Channel15.Init.DestInc = DMA_DINC_INCREMENTED;
    handle_HPDMA1_Channel15.Init.SrcDataWidth = DMA_SRC_DATAWIDTH_BYTE;
    handle_HPDMA1_Channel15.Init.DestDataWidth = DMA_DEST_DATAWIDTH_BYTE;
    handle_HPDMA1_Channel15.Init.Priority = DMA_LOW_PRIORITY_LOW_WEIGHT;
    handle_HPDMA1_Channel15.Init.SrcBurstLength = 16;
    handle_HPDMA1_Channel15.Init.DestBurstLength = 16;
    handle_HPDMA1_Channel15.Init.TransferAllocatedPort = DMA_SRC_ALLOCATED_PORT0|DMA_DEST_ALLOCATED_PORT0;
    handle_HPDMA1_Channel15.Init.TransferEventMode = DMA_TCEM_BLOCK_TRANSFER;
    handle_HPDMA1_Channel15.Init.Mode = DMA_NORMAL;
    if (HAL_DMA_Init(&handle_HPDMA1_Channel15) != HAL_OK)
    {
      Error_Handler();
    }
    if (HAL_DMA_ConfigChannelAttributes(&handle_HPDMA1_Channel15, DMA_CHANNEL_PRIV) != HAL_OK)
    {
      Error_Handler();
    }
    HAL_DMA_Start(&handle_HPDMA1_Channel15,(uint32_t)buffer,destination_Address,DataSize);
    HAL_DMA_PollForTransfer(&handle_HPDMA1_Channel15,HAL_DMA_FULL_TRANSFER,0xFFFFFFFF);
    HAL_Delay(2);
  }
/* USER CODE END 0 */
```

for copy:

```c
  void EXTMEM_MemCopy(uint32_t* destination_Address, const uint8_t* ptrData, uint32_t DataSize){
    if(DataSize<MAX_PAGE_WRITE){
      memset(&buffer[DataSize],0xff,MAX_PAGE_WRITE-DataSize);
    }
    memcpy(buffer,ptrData,DataSize);
    if(DataSize<MAX_PAGE_WRITE){
      DataSize=MAX_PAGE_WRITE;
    }
    DMA_HandleTypeDef handle_HPDMA1_Channel15;
    HAL_Delay(2);
    __HAL_RCC_HPDMA1_CLK_ENABLE();
    handle_HPDMA1_Channel15.Instance = HPDMA1_Channel15;
    handle_HPDMA1_Channel15.Init.Request = DMA_REQUEST_SW;
    handle_HPDMA1_Channel15.Init.BlkHWRequest = DMA_BREQ_SINGLE_BURST;
    handle_HPDMA1_Channel15.Init.Direction = DMA_MEMORY_TO_MEMORY;
    handle_HPDMA1_Channel15.Init.SrcInc = DMA_SINC_INCREMENTED;
    handle_HPDMA1_Channel15.Init.DestInc = DMA_DINC_INCREMENTED;
    handle_HPDMA1_Channel15.Init.SrcDataWidth = DMA_SRC_DATAWIDTH_BYTE;
    handle_HPDMA1_Channel15.Init.DestDataWidth = DMA_DEST_DATAWIDTH_BYTE;
    handle_HPDMA1_Channel15.Init.Priority = DMA_LOW_PRIORITY_LOW_WEIGHT;
    handle_HPDMA1_Channel15.Init.SrcBurstLength = 16;
    handle_HPDMA1_Channel15.Init.DestBurstLength = 16;
    handle_HPDMA1_Channel15.Init.TransferAllocatedPort = DMA_SRC_ALLOCATED_PORT0|DMA_DEST_ALLOCATED_PORT0;
    handle_HPDMA1_Channel15.Init.TransferEventMode = DMA_TCEM_BLOCK_TRANSFER;
    handle_HPDMA1_Channel15.Init.Mode = DMA_NORMAL;
    if (HAL_DMA_Init(&handle_HPDMA1_Channel15) != HAL_OK)
    {
      Error_Handler();
    }
    if (HAL_DMA_ConfigChannelAttributes(&handle_HPDMA1_Channel15, DMA_CHANNEL_PRIV) != HAL_OK)
    {
      Error_Handler();
    }
    HAL_DMA_Start(&handle_HPDMA1_Channel15,(uint32_t)buffer,destination_Address,DataSize);
    HAL_DMA_PollForTransfer(&handle_HPDMA1_Channel15,HAL_DMA_FULL_TRANSFER,0xFFFFFFFF);
    HAL_Delay(2);
  }
```

# Add buffer

6. Add a temporary buffer to ensure that all DMA reads are properly aligned.


```c-nc
/* USER CODE BEGIN PV */
const uint32_t key[4] =     { 0x12345678, 0x0, 0x0, 0x0 };
#define MAX_PAGE_WRITE 0x100
uint32_t buffer[MAX_PAGE_WRITE]  __attribute__ ((aligned (1024))) ;
/* USER CODE END PV */
```

for copy:

```c
#define MAX_PAGE_WRITE 0x100
uint32_t buffer[MAX_PAGE_WRITE]  __attribute__ ((aligned (1024))) ;
```

To utilize EXTMEM_MemCopy, we also need to modify an additional function that determines the method of writing. This function is `memory_write` in `memory_wrapper.c` in **Middleware/ST/STM32ExtMem_Loader/core**.

# Include extmem_wrapper


7. Include the files for memory wrapper that we can override the functions

Add to includes :
```c-nc
/* USER CODE BEGIN Includes */
#include "memory_wrapper.h"
/* USER CODE END Includes */
```

For copy:

```c
#include "memory_wrapper.h"
```


# disable write access

8. Disable write access to the OSPI memory from the core by configuring the **Memory Protection Unit (MPU)**.
Insert the relevant code into the `extmemloader_Init` function found in **in extmemloader_init.c**.

```c-nc
  /* USER CODE BEGIN 1 */
  MPU_Region_InitTypeDef MPU_InitStruct = {0};
  /* Disables the MPU */
  HAL_MPU_Disable();

  /** Initializes and configures the Region and the memory to be protected
  */
  MPU_InitStruct.Enable = MPU_REGION_ENABLE;
  MPU_InitStruct.Number = MPU_REGION_NUMBER1;
  MPU_InitStruct.BaseAddress = 0x90000000;
  MPU_InitStruct.Size = MPU_REGION_SIZE_256MB;
  MPU_InitStruct.SubRegionDisable = 0x00;
  MPU_InitStruct.TypeExtField = MPU_TEX_LEVEL0;
  MPU_InitStruct.AccessPermission = MPU_REGION_PRIV_RO;
  MPU_InitStruct.DisableExec = MPU_INSTRUCTION_ACCESS_DISABLE;
  MPU_InitStruct.IsShareable = MPU_ACCESS_NOT_SHAREABLE;
  MPU_InitStruct.IsCacheable = MPU_ACCESS_NOT_CACHEABLE;
  MPU_InitStruct.IsBufferable = MPU_ACCESS_NOT_BUFFERABLE;

  HAL_MPU_ConfigRegion(&MPU_InitStruct);
  /* Enables the MPU */
  HAL_MPU_Enable(MPU_PRIVILEGED_DEFAULT);
  /* USER CODE END 1 */
```

for copy

```c
  MPU_Region_InitTypeDef MPU_InitStruct = {0};
  /* Disables the MPU */
  HAL_MPU_Disable();

  /** Initializes and configures the Region and the memory to be protected
  */
  MPU_InitStruct.Enable = MPU_REGION_ENABLE;
  MPU_InitStruct.Number = MPU_REGION_NUMBER1;
  MPU_InitStruct.BaseAddress = 0x90000000;
  MPU_InitStruct.Size = MPU_REGION_SIZE_256MB;
  MPU_InitStruct.SubRegionDisable = 0x00;
  MPU_InitStruct.TypeExtField = MPU_TEX_LEVEL0;
  MPU_InitStruct.AccessPermission = MPU_REGION_PRIV_RO;
  MPU_InitStruct.DisableExec = MPU_INSTRUCTION_ACCESS_DISABLE;
  MPU_InitStruct.IsShareable = MPU_ACCESS_NOT_SHAREABLE;
  MPU_InitStruct.IsCacheable = MPU_ACCESS_NOT_CACHEABLE;
  MPU_InitStruct.IsBufferable = MPU_ACCESS_NOT_BUFFERABLE;

  HAL_MPU_ConfigRegion(&MPU_InitStruct);
  /* Enables the MPU */
  HAL_MPU_Enable(MPU_PRIVILEGED_DEFAULT);
```

# disable caches

 9. Ensure that both Instruction Cache (ICache) and Data Cache (DCache) are disabled in the external memory loader, while maintaining the use of the Memory Protection Unit (MPU).
   
**Comment:**

```c-nc
  /* Enable I-Cache---------------------------------------------------------*/
  //SCB_EnableICache();

  /* Enable D-Cache---------------------------------------------------------*/
  //SCB_EnableDCache();

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* MPU Configuration--------------------------------------------------------*/
  //HAL_MPU_Disable();
```


Now we can **compile** the code and run it from the **Application**.


# What we created


* We used the MCE to decrypt data in bootloader
* We modifed the Bootloader to use MCE to encrypt the data
  * We used function to override write
  * Function to override data copy
  * HDMA was used to write the data
