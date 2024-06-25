/*
******************************************************************************
**
** @file        : LinkerScript.ld
**
** @author      : STM32CubeIDE
**
**  Abstract    : Linker script for STM32H7Sxx Device
**                      128KBytes FLASH
**                      456KBytes RAM
**
**                Set heap size, stack size and stack location according
**                to application requirements.
**
**                Set memory bank area and size if external memory is used
**
**  Target      : STMicroelectronics STM32
**
**  Distribution: The file is distributed as is, without any warranty
**                of any kind.
**
******************************************************************************
** @attention
**
** Copyright (c) 2024 STMicroelectronics.
** All rights reserved.
**
** This software is licensed under terms that can be found in the LICENSE file
** in the root directory of this software component.
** If no LICENSE file comes with this software, it is provided AS-IS.
**
******************************************************************************
*/

/* Entry Point */
ENTRY(Reset_Handler)

/* Highest address of the user mode stack */
_estack = ORIGIN(DTCM) + LENGTH(DTCM); /* end of "DTCM" Ram type memory */

_Min_Heap_Size = 0x1000; /* required amount of heap */
_Min_Stack_Size = 0x1000; /* required amount of stack */

/* Memories definition */
MEMORY
{
  RAM       (rw)  : ORIGIN = 0x24000000, LENGTH = 0x0006e000
  RAM_CMD   (rw)  : ORIGIN = 0x2406e000, LENGTH = 0x00004000

  ITCM      (rw)  : ORIGIN = 0x00000000, LENGTH = 0x00010000
  DTCM      (rw)  : ORIGIN = 0x20000000, LENGTH = 0x00003000
  DTCM_RTOS (rw)  : ORIGIN = 0x20003000, LENGTH = 0x0000D000
  SRAMAHB   (rw)  : ORIGIN = 0x30000000, LENGTH = 0x00008000
  BKPSRAM   (rw)  : ORIGIN = 0x38800000, LENGTH = 0x00001000

  FLASH     (xr)  : ORIGIN = 0x70000000, LENGTH = 0x00200000
  FLASH_GFX (r)   : ORIGIN = 0x70200000, LENGTH = 0x07e00000
  EXTRAM    (rw)  : ORIGIN = 0x90000000, LENGTH = 0x02000000
}


/* Sections */
SECTIONS
{
  /* The startup code into "FLASH" FLASH type memory */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector)) /* Startup code */
    . = ALIGN(4);
  } >FLASH

  /* The program code and other data into "FLASH" FLASH type memory */
  .text :
  {
    . = ALIGN(4);
    *(.text)           /* .text sections (code) */
    *(.text*)          /* .text* sections (code) */
    *(.glue_7)         /* glue arm to thumb code */
    *(.glue_7t)        /* glue thumb to arm code */
    *(.eh_frame)

    KEEP (*(.init))
    KEEP (*(.fini))

    . = ALIGN(4);
    _etext = .;        /* define a global symbols at end of code */
  } >FLASH

  /* Constant data into "FLASH" FLASH type memory */
  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)         /* .rodata sections (constants, strings, etc.) */
    *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
    . = ALIGN(4);
  } >FLASH

  .ARM.extab : /* The READONLY keyword is only supported in GCC11 and later, remove it if using GCC10 or earlier. */
  {
    . = ALIGN(4);
    *(.ARM.extab* .gnu.linkonce.armextab.*)
    . = ALIGN(4);
  } >FLASH
  .ARM : /* The READONLY keyword is only supported in GCC11 and later, remove it if using GCC10 or earlier. */
  {
    . = ALIGN(4);
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
    . = ALIGN(4);
  } >FLASH

  .preinit_array : /* The READONLY keyword is only supported in GCC11 and later, remove it if using GCC10 or earlier. */
  {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array*))
    PROVIDE_HIDDEN (__preinit_array_end = .);
    . = ALIGN(4);
  } >FLASH

  .init_array : /* The READONLY keyword is only supported in GCC11 and later, remove it if using GCC10 or earlier. */
  {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array*))
    PROVIDE_HIDDEN (__init_array_end = .);
    . = ALIGN(4);
  } >FLASH

  .fini_array : /* The READONLY keyword is only supported in GCC11 and later, remove it if using GCC10 or earlier. */
  {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array*))
    PROVIDE_HIDDEN (__fini_array_end = .);
    . = ALIGN(4);
  } >FLASH

  /* Used by the startup to initialize data */
  _sidata = LOADADDR(.data);

  FreeRtosHeapSection :
  {
    *(.bss.ucHeap)
    . = ALIGN(0x8);
  } >DTCM_RTOS

  /* Initialized data sections into "RAM" Ram type memory */
  .data :
  {
    . = ALIGN(4);
    _sdata = .;        /* create a global symbol at data start */
    *(.data)           /* .data sections */
    *(.data*)          /* .data* sections */
    *(.RamFunc)        /* .RamFunc sections */
    *(.RamFunc*)       /* .RamFunc* sections */

    . = ALIGN(4);
    _edata = .;        /* define a global symbol at data end */

  } >RAM AT> FLASH

  /* Uninitialized data section into "RAM" Ram type memory */
  . = ALIGN(4);
  .bss :
  {
    /* This is used by the startup in order to initialize the .bss section */
    _sbss = .;         /* define a global symbol at bss start */
    __bss_start__ = _sbss;
    *(.bss)
    *(.bss*)
    *(COMMON)

    . = ALIGN(4);
    _ebss = .;         /* define a global symbol at bss end */
    __bss_end__ = _ebss;
  } >RAM

  /* User_heap_stack section, used to check that there is enough "RAM" Ram  type memory left */
  ._user_heap_stack :
  {
    . = ALIGN(8);
    PROVIDE ( end = . );
    PROVIDE ( _end = . );
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(8);
  } >DTCM

  /* Remove information from the compiler libraries */
  /DISCARD/ :
  {
    libc.a ( * )
    libm.a ( * )
    libgcc.a ( * )
  }

  .ARM.attributes 0 : { *(.ARM.attributes) }
  
  BufferSection (NOLOAD) :
  {
    *(TouchGFX_Framebuffer TouchGFX_Framebuffer.*)
    *(.gnu.linkonce.r.*)
    . = ALIGN(0x8);

    *(Nemagfx_Stencil_Buffer Nemagfx_Stencil_Buffer.*)
    *(.gnu.linkonce.r.*)
    . = ALIGN(0x8);
  } >EXTRAM
  
  UncachedSection (NOLOAD) :
  {
    *(Nemagfx_Memory_Pool_Buffer Nemagfx_Memory_Pool_Buffer.*)
    *(.gnu.linkonce.r.*)
    . = ALIGN(0x8);
  } >RAM_CMD
  
    FontFlashSection :
  {
    *(FontFlashSection FontFlashSection.*)
    *(.gnu.linkonce.r.*)
    . = ALIGN(0x4);
  } >FLASH_GFX

  TextFlashSection :
  {
    *(TextFlashSection TextFlashSection.*)
    *(.gnu.linkonce.r.*)
    . = ALIGN(0x4);
  } >FLASH_GFX

  ExtFlashSection :
  {
    *(ExtFlashSection ExtFlashSection.*)
    *(.gnu.linkonce.r.*)
    . = ALIGN(0x4);
  } >FLASH_GFX
}
