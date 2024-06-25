/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : STM32TouchController.cpp
  ******************************************************************************
  * This file was created by TouchGFX Generator 4.22.1. This file is only
  * generated once! Delete this file from your project and re-generate code
  * using STM32CubeMX or change this file manually to update it.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2023 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* USER CODE BEGIN STM32TouchController */
#include <touchgfx/hal/HAL.hpp>
#include <touchgfx/hal/Types.hpp>
#include <STM32TouchController.hpp>
#include "main.h"

volatile bool doSampleTouch = false;

extern "C" I2C_HandleTypeDef hi2c1;

using namespace touchgfx;
extern "C"
{
    void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
    {
        if (GPIO_Pin == TP_IRQ_Pin)
        {
            /* Communication with TS is done via I2C.
            Often the sw requires ISRs (interrupt service routines) to be quick while communication
            with I2C can be considered relatively long (depending on SW requirements).
            Considering that the TS feature don't need immediate reaction,
            it is suggested to use polling mode instead of EXTI mode,
            in order to avoid blocking I2C communication on interrupt service routines */

            /* Here an example of implementation is proposed which is a mix between pooling and exit mode:
            On ISR a flag is set (exti5_received), the main loop polls on the flag rather then polling the TS;
            Mcu communicates with TS only when the flag has been set by ISR. This is just an example:
            the users should choose they strategy depending on their application needs.*/

            doSampleTouch = true;
            return;
        }
    }
}

void STM32TouchController::init()
{
    // No init needed
}

bool STM32TouchController::sampleTouch(int32_t& x, int32_t& y)
{
    uint8_t touches = 0;
    uint8_t buf[6];
    const uint16_t STATUS_REG = 0x814E;
    const uint16_t TOUCH_POS_REG = 0x8150;
    uint8_t ZERO = 0;

    NVIC_DisableIRQ(TP_IRQ_EXTI_IRQn);
    if (doSampleTouch)
    {
        HAL_I2C_Mem_Read(&hi2c1, 0xBA, STATUS_REG, 2, buf, 1, HAL_MAX_DELAY);
        touches = (0x0F & buf[0]);

        HAL_I2C_Mem_Write(&hi2c1, 0xBA, STATUS_REG, 2, &ZERO, 1, HAL_MAX_DELAY);

        doSampleTouch = false;

        if (touches > 0)
        {
            HAL_I2C_Mem_Read(&hi2c1, 0xBA, TOUCH_POS_REG, 2, buf, 4, HAL_MAX_DELAY);
            x = buf[0] + (buf[1] << 8);
            y = buf[2] + (buf[3] << 8);
        }
    }
    NVIC_EnableIRQ(TP_IRQ_EXTI_IRQn);

    return (touches > 0);
}
/* USER CODE END STM32TouchController */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
