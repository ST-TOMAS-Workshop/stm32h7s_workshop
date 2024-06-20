----!
Presentation
----!

# Add code

1. Open STM32CubeIDE
2. Import Project to STM32CubeIDE or let STM32CubeMX to import the project for you.
3. You should have one main project and three sub projects in the workspace. 

4. Open Application project and the main.c
5. Add there the code for GPIO toggling

```c
	  HAL_GPIO_TogglePin(GPIOD, GPIO_PIN_13);
	  HAL_Delay(500);
```

into infinite loop:
```c
  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
	  HAL_GPIO_TogglePin(GPIOD, GPIO_PIN_13);
	  HAL_Delay(500);
  }
  /* USER CODE END 3 */
}
```

6. Open Bootloader project
7. Go to main.c
8. Go to main function 
9. Add Cache invalidation functions

```c
  /* USER CODE BEGIN 1 */

  SCB_InvalidateDCache();
  SCB_InvalidateICache();
  /* USER CODE END 1 */
```

# Compile

This is done because, after a reset, the cache may contain invalid data. The JumpToApplication function will clean the cache, and these invalid records could otherwise cause a hard fault.

10. Compile all projects.
11. Select Application project and run debug

![run debug](./img/24_03_11_425.gif)

12. Check that external loader is present in the debugger tab

13. Go to setup tab
14. Add Bootloader code that it will be loaded to and we will see the code
15. Clikc OK

![debug setup](./img/24_03_11_427.gif)

If you are using the application for debugging, you will encounter a HardFault exception immediately upon starting. This occurs because the debugger starts the application directly without resetting the device. To address this, you must manually click 'Reset' to physically reset the device, which allows it to jump to the bootloader, and then proceed to run the application.
