// 4.24.0 0x0d15951a
// Generated by imageconverter. Please, do not edit!

#include <images/BitmapDatabase.hpp>
#include <touchgfx/Bitmap.hpp>

extern const unsigned char image_alternate_theme_images_backgrounds_800x480_puzzle[]; // BITMAP_ALTERNATE_THEME_IMAGES_BACKGROUNDS_800X480_PUZZLE_ID = 0, Size: 800x480 pixels
extern const unsigned char image_alternate_theme_images_logos_touchgfx_gradient_smooth[]; // BITMAP_ALTERNATE_THEME_IMAGES_LOGOS_TOUCHGFX_GRADIENT_SMOOTH_ID = 1, Size: 152x152 pixels
extern const unsigned char image_alternate_theme_images_widgets_togglebutton_medium_round_text_off_normal[]; // BITMAP_ALTERNATE_THEME_IMAGES_WIDGETS_TOGGLEBUTTON_MEDIUM_ROUND_TEXT_OFF_NORMAL_ID = 2, Size: 138x50 pixels
extern const unsigned char image_alternate_theme_images_widgets_togglebutton_medium_round_text_on_dark[]; // BITMAP_ALTERNATE_THEME_IMAGES_WIDGETS_TOGGLEBUTTON_MEDIUM_ROUND_TEXT_ON_DARK_ID = 3, Size: 138x50 pixels

const touchgfx::Bitmap::BitmapData bitmap_database[] = {
    { image_alternate_theme_images_backgrounds_800x480_puzzle, 0, 800, 480, 0, 0, 800, ((uint8_t)touchgfx::Bitmap::RGB565) >> 3, 480, ((uint8_t)touchgfx::Bitmap::RGB565) & 0x7 },
    { image_alternate_theme_images_logos_touchgfx_gradient_smooth, 0, 152, 152, 76, 51, 14, ((uint8_t)touchgfx::Bitmap::ARGB8888) >> 3, 47, ((uint8_t)touchgfx::Bitmap::ARGB8888) & 0x7 },
    { image_alternate_theme_images_widgets_togglebutton_medium_round_text_off_normal, 0, 138, 50, 17, 10, 43, ((uint8_t)touchgfx::Bitmap::ARGB8888) >> 3, 30, ((uint8_t)touchgfx::Bitmap::ARGB8888) & 0x7 },
    { image_alternate_theme_images_widgets_togglebutton_medium_round_text_on_dark, 0, 138, 50, 78, 10, 43, ((uint8_t)touchgfx::Bitmap::ARGB8888) >> 3, 30, ((uint8_t)touchgfx::Bitmap::ARGB8888) & 0x7 }
};

namespace BitmapDatabase
{
const touchgfx::Bitmap::BitmapData* getInstance()
{
    return bitmap_database;
}

uint16_t getInstanceSize()
{
    return (uint16_t)(sizeof(bitmap_database) / sizeof(touchgfx::Bitmap::BitmapData));
}
} // namespace BitmapDatabase
