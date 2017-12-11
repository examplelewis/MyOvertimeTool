//
//  BFColorUtils.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/12.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// BFCommonColors
// 常用颜色
#define BFCOLOR_TRANSPARENT [UIColor colorWithHexString:@"00000000"]
#define BFCOLOR_BODY_TEXT_1 [UIColor colorWithHexString:@"de000000"]
#define BFCOLOR_BODY_TEXT_2 [UIColor colorWithHexString:@"8a000000"]
#define BFCOLOR_BODY_TEXT_3 [UIColor colorWithHexString:@"60000000"]
#define BFCOLOR_BODY_TEXT_DISABLED [UIColor colorWithHexString:@"44000000"]
#define BFCOLOR_BODY_TEXT_1_INVERSE [UIColor colorWithHexString:@"deffffff"]
#define BFCOLOR_BODY_TEXT_2_INVERSE [UIColor colorWithHexString:@"8affffff"]
// red
#define BFCOLOR_RED_50 [UIColor colorWithHexString:@"fffde0dc"]
#define BFCOLOR_RED_100 [UIColor colorWithHexString:@"fff9bdbb"]
#define BFCOLOR_RED_200 [UIColor colorWithHexString:@"fff69988"]
#define BFCOLOR_RED_300 [UIColor colorWithHexString:@"fff36c60"]
#define BFCOLOR_RED_400 [UIColor colorWithHexString:@"ffe84e40"]
#define BFCOLOR_RED_500 [UIColor colorWithHexString:@"ffe51c23"]
#define BFCOLOR_RED_600 [UIColor colorWithHexString:@"ffdd191d"]
#define BFCOLOR_RED_700 [UIColor colorWithHexString:@"ffd01716"]
#define BFCOLOR_RED_800 [UIColor colorWithHexString:@"ffc41411"]
#define BFCOLOR_RED_900 [UIColor colorWithHexString:@"ffb0120a"]
#define BFCOLOR_RED_A100 [UIColor colorWithHexString:@"ffff7997"]
#define BFCOLOR_RED_A200 [UIColor colorWithHexString:@"ffff5177"]
#define BFCOLOR_RED_A400 [UIColor colorWithHexString:@"ffff2d6f"]
#define BFCOLOR_RED_A900 [UIColor colorWithHexString:@"ffe00032"]
// pink
#define BFCOLOR_PINK_50 [UIColor colorWithHexString:@"fffce4ec"]
#define BFCOLOR_PINK_100 [UIColor colorWithHexString:@"fff8bbd0"]
#define BFCOLOR_PINK_200 [UIColor colorWithHexString:@"fff48fb1"]
#define BFCOLOR_PINK_300 [UIColor colorWithHexString:@"fff06292"]
#define BFCOLOR_PINK_400 [UIColor colorWithHexString:@"ffec407a"]
#define BFCOLOR_PINK_500 [UIColor colorWithHexString:@"ffe91e63"]
#define BFCOLOR_PINK_600 [UIColor colorWithHexString:@"ffd81b60"]
#define BFCOLOR_PINK_700 [UIColor colorWithHexString:@"ffc2185b"]
#define BFCOLOR_PINK_800 [UIColor colorWithHexString:@"ffad1457"]
#define BFCOLOR_PINK_900 [UIColor colorWithHexString:@"ff880e4f"]
#define BFCOLOR_PINK_A100 [UIColor colorWithHexString:@"ffff80ab"]
#define BFCOLOR_PINK_A200 [UIColor colorWithHexString:@"ffff4081"]
#define BFCOLOR_PINK_A400 [UIColor colorWithHexString:@"fff50057"]
#define BFCOLOR_PINK_A900 [UIColor colorWithHexString:@"ffc51162"]
// purple
#define BFCOLOR_PURPLE_50 [UIColor colorWithHexString:@"fff3e5f5"]
#define BFCOLOR_PURPLE_100 [UIColor colorWithHexString:@"ffe1bee7"]
#define BFCOLOR_PURPLE_200 [UIColor colorWithHexString:@"ffce93d8"]
#define BFCOLOR_PURPLE_300 [UIColor colorWithHexString:@"ffba68c8"]
#define BFCOLOR_PURPLE_400 [UIColor colorWithHexString:@"ffab47bc"]
#define BFCOLOR_PURPLE_500 [UIColor colorWithHexString:@"ff9c27b0"]
#define BFCOLOR_PURPLE_600 [UIColor colorWithHexString:@"ff8e24aa"]
#define BFCOLOR_PURPLE_700 [UIColor colorWithHexString:@"ff7b1fa2"]
#define BFCOLOR_PURPLE_800 [UIColor colorWithHexString:@"ff6a1b9a"]
#define BFCOLOR_PURPLE_900 [UIColor colorWithHexString:@"ff4a148c"]
#define BFCOLOR_PURPLE_A100 [UIColor colorWithHexString:@"ffea80fc"]
#define BFCOLOR_PURPLE_A200 [UIColor colorWithHexString:@"ffe040fb"]
#define BFCOLOR_PURPLE_A400 [UIColor colorWithHexString:@"ffd500f9"]
#define BFCOLOR_PURPLE_A900 [UIColor colorWithHexString:@"ffaa00ff"]
// Deep Purple 深紫色
#define BFCOLOR_DEEP_PURPLR_50 [UIColor colorWithHexString:@"ffede7f6"]
#define BFCOLOR_DEEP_PURPLR_100 [UIColor colorWithHexString:@"ffd1c4e9"]
#define BFCOLOR_DEEP_PURPLR_200 [UIColor colorWithHexString:@"ffb39ddb"]
#define BFCOLOR_DEEP_PURPLR_300 [UIColor colorWithHexString:@"ff9575cd"]
#define BFCOLOR_DEEP_PURPLR_400 [UIColor colorWithHexString:@"ff7e57c2"]
#define BFCOLOR_DEEP_PURPLR_500 [UIColor colorWithHexString:@"ff673ab7"]
#define BFCOLOR_DEEP_PURPLR_600 [UIColor colorWithHexString:@"ff5e35b1"]
#define BFCOLOR_DEEP_PURPLR_700 [UIColor colorWithHexString:@"ff512da8"]
#define BFCOLOR_DEEP_PURPLR_800 [UIColor colorWithHexString:@"ff4527a0"]
#define BFCOLOR_DEEP_PURPLR_900 [UIColor colorWithHexString:@"ff311b92"]
#define BFCOLOR_DEEP_PURPLR_A100 [UIColor colorWithHexString:@"ffb388ff"]
#define BFCOLOR_DEEP_PURPLR_A200 [UIColor colorWithHexString:@"ff7c4dff"]
#define BFCOLOR_DEEP_PURPLR_A400 [UIColor colorWithHexString:@"ff651fff"]
#define BFCOLOR_DEEP_PURPLR_A900 [UIColor colorWithHexString:@"ff6200ea"]
// Indigo 靛蓝色
#define BFCOLOR_INDIGO_50 [UIColor colorWithHexString:@"ffe8eaf6"]
#define BFCOLOR_INDIGO_100 [UIColor colorWithHexString:@"ffc5cae9"]
#define BFCOLOR_INDIGO_200 [UIColor colorWithHexString:@"ff9fa8da"]
#define BFCOLOR_INDIGO_300 [UIColor colorWithHexString:@"ff7986cb"]
#define BFCOLOR_INDIGO_400 [UIColor colorWithHexString:@"ff5c6bc0"]
#define BFCOLOR_INDIGO_500 [UIColor colorWithHexString:@"ff3f51b5"]
#define BFCOLOR_INDIGO_600 [UIColor colorWithHexString:@"ff3949ab"]
#define BFCOLOR_INDIGO_700 [UIColor colorWithHexString:@"ff303f9f"]
#define BFCOLOR_INDIGO_800 [UIColor colorWithHexString:@"ff283593"]
#define BFCOLOR_INDIGO_900 [UIColor colorWithHexString:@"ff1a237e"]
#define BFCOLOR_INDIGO_A100 [UIColor colorWithHexString:@"ff8c9eff"]
#define BFCOLOR_INDIGO_A200 [UIColor colorWithHexString:@"ff536dfe"]
#define BFCOLOR_INDIGO_A400 [UIColor colorWithHexString:@"ff3d5afe"]
#define BFCOLOR_INDIGO_A900 [UIColor colorWithHexString:@"ff304ffe"]
// BLUE 蓝色
#define BFCOLOR_BLUE_50 [UIColor colorWithHexString:@"ffe7e9fd"]
#define BFCOLOR_BLUE_100 [UIColor colorWithHexString:@"ffd0d9ff"]
#define BFCOLOR_BLUE_200 [UIColor colorWithHexString:@"ffafbfff"]
#define BFCOLOR_BLUE_300 [UIColor colorWithHexString:@"ff91a7ff"]
#define BFCOLOR_BLUE_400 [UIColor colorWithHexString:@"ff738ffe"]
#define BFCOLOR_BLUE_500 [UIColor colorWithHexString:@"ff5677fc"]
#define BFCOLOR_BLUE_600 [UIColor colorWithHexString:@"ff4e6cef"]
#define BFCOLOR_BLUE_700 [UIColor colorWithHexString:@"ff455ede"]
#define BFCOLOR_BLUE_800 [UIColor colorWithHexString:@"ff3b50ce"]
#define BFCOLOR_BLUE_900 [UIColor colorWithHexString:@"ff2a36b1"]
#define BFCOLOR_BLUE_A100 [UIColor colorWithHexString:@"ffa6baff"]
#define BFCOLOR_BLUE_A200 [UIColor colorWithHexString:@"ff6889ff"]
#define BFCOLOR_BLUE_A400 [UIColor colorWithHexString:@"ff4d73ff"]
#define BFCOLOR_BLUE_A900 [UIColor colorWithHexString:@"ff4d69ff"]
// LIGHT BLUE 浅蓝色
#define BFCOLOR_LIGHT_BLUE_50 [UIColor colorWithHexString:@"ffe1f5fe"]
#define BFCOLOR_LIGHT_BLUE_100 [UIColor colorWithHexString:@"ffb3e5fc"]
#define BFCOLOR_LIGHT_BLUE_200 [UIColor colorWithHexString:@"ff81d4fa"]
#define BFCOLOR_LIGHT_BLUE_300 [UIColor colorWithHexString:@"ff4fc3f7"]
#define BFCOLOR_LIGHT_BLUE_400 [UIColor colorWithHexString:@"ff29b6f6"]
#define BFCOLOR_LIGHT_BLUE_500 [UIColor colorWithHexString:@"ff03a9f4"]
#define BFCOLOR_LIGHT_BLUE_600 [UIColor colorWithHexString:@"ff039be5"]
#define BFCOLOR_LIGHT_BLUE_700 [UIColor colorWithHexString:@"ff0288d1"]
#define BFCOLOR_LIGHT_BLUE_800 [UIColor colorWithHexString:@"ff0277bd"]
#define BFCOLOR_LIGHT_BLUE_900 [UIColor colorWithHexString:@"ff01579b"]
#define BFCOLOR_LIGHT_BLUE_A100 [UIColor colorWithHexString:@"ff80d8ff"]
#define BFCOLOR_LIGHT_BLUE_A200 [UIColor colorWithHexString:@"ff40c4ff"]
#define BFCOLOR_LIGHT_BLUE_A400 [UIColor colorWithHexString:@"ff00b0ff"]
#define BFCOLOR_LIGHT_BLUE_A900 [UIColor colorWithHexString:@"ff0091ea"]
// CYAN 青色
#define BFCOLOR_CYAN_50 [UIColor colorWithHexString:@"ffe0f7fa"]
#define BFCOLOR_CYAN_100 [UIColor colorWithHexString:@"ffb2ebf2"]
#define BFCOLOR_CYAN_200 [UIColor colorWithHexString:@"ff80deea"]
#define BFCOLOR_CYAN_300 [UIColor colorWithHexString:@"ff4dd0e1"]
#define BFCOLOR_CYAN_400 [UIColor colorWithHexString:@"ff26c6da"]
#define BFCOLOR_CYAN_500 [UIColor colorWithHexString:@"ff00bcd4"]
#define BFCOLOR_CYAN_600 [UIColor colorWithHexString:@"ff00acc1"]
#define BFCOLOR_CYAN_700 [UIColor colorWithHexString:@"ff0097a7"]
#define BFCOLOR_CYAN_800 [UIColor colorWithHexString:@"ff00838f"]
#define BFCOLOR_CYAN_900 [UIColor colorWithHexString:@"ff006064"]
#define BFCOLOR_CYAN_A100 [UIColor colorWithHexString:@"ff84ffff"]
#define BFCOLOR_CYAN_A200 [UIColor colorWithHexString:@"ff18ffff"]
#define BFCOLOR_CYAN_A400 [UIColor colorWithHexString:@"ff00e5ff"]
#define BFCOLOR_CYAN_A900 [UIColor colorWithHexString:@"ff00b8d4"]
// TEAL 蓝绿色
#define BFCOLOR_TEAL_50 [UIColor colorWithHexString:@"ffe0f2f1"]
#define BFCOLOR_TEAL_100 [UIColor colorWithHexString:@"ffb2dfdb"]
#define BFCOLOR_TEAL_200 [UIColor colorWithHexString:@"ff80cbc4"]
#define BFCOLOR_TEAL_300 [UIColor colorWithHexString:@"ff4db6ac"]
#define BFCOLOR_TEAL_400 [UIColor colorWithHexString:@"ff26a69a"]
#define BFCOLOR_TEAL_500 [UIColor colorWithHexString:@"ff009688"]
#define BFCOLOR_TEAL_600 [UIColor colorWithHexString:@"ff00897b"]
#define BFCOLOR_TEAL_700 [UIColor colorWithHexString:@"ff00796b"]
#define BFCOLOR_TEAL_800 [UIColor colorWithHexString:@"ff00695c"]
#define BFCOLOR_TEAL_900 [UIColor colorWithHexString:@"ff004d40"]
#define BFCOLOR_TEAL_A100 [UIColor colorWithHexString:@"ffa7ffeb"]
#define BFCOLOR_TEAL_A200 [UIColor colorWithHexString:@"ff64ffda"]
#define BFCOLOR_TEAL_A400 [UIColor colorWithHexString:@"ff1de9b6"]
#define BFCOLOR_TEAL_A900 [UIColor colorWithHexString:@"ff00bfa5"]
// GREEN 绿色
#define BFCOLOR_GREEN_50 [UIColor colorWithHexString:@"ffd0f8ce"]
#define BFCOLOR_GREEN_100 [UIColor colorWithHexString:@"ffa3e9a4"]
#define BFCOLOR_GREEN_200 [UIColor colorWithHexString:@"ff72d572"]
#define BFCOLOR_GREEN_300 [UIColor colorWithHexString:@"ff42bd41"]
#define BFCOLOR_GREEN_400 [UIColor colorWithHexString:@"ff2baf2b"]
#define BFCOLOR_GREEN_500 [UIColor colorWithHexString:@"ff259b24"]
#define BFCOLOR_GREEN_600 [UIColor colorWithHexString:@"ff0a8f08"]
#define BFCOLOR_GREEN_700 [UIColor colorWithHexString:@"ff0a7e07"]
#define BFCOLOR_GREEN_800 [UIColor colorWithHexString:@"ff056f00"]
#define BFCOLOR_GREEN_900 [UIColor colorWithHexString:@"ff0d5302"]
#define BFCOLOR_GREEN_A100 [UIColor colorWithHexString:@"ffa2f78d"]
#define BFCOLOR_GREEN_A200 [UIColor colorWithHexString:@"ff5af158"]
#define BFCOLOR_GREEN_A400 [UIColor colorWithHexString:@"ff14e715"]
#define BFCOLOR_GREEN_A900 [UIColor colorWithHexString:@"ff12c700"]
// LIGHT GREEN 浅绿色
#define BFCOLOR_LIGHT_GREEN_50 [UIColor colorWithHexString:@"fff1f8e9"]
#define BFCOLOR_LIGHT_GREEN_100 [UIColor colorWithHexString:@"ffdcedc8"]
#define BFCOLOR_LIGHT_GREEN_200 [UIColor colorWithHexString:@"ffc5e1a5"]
#define BFCOLOR_LIGHT_GREEN_300 [UIColor colorWithHexString:@"ffaed581"]
#define BFCOLOR_LIGHT_GREEN_400 [UIColor colorWithHexString:@"ff9ccc65"]
#define BFCOLOR_LIGHT_GREEN_500 [UIColor colorWithHexString:@"ff8bc34a"]
#define BFCOLOR_LIGHT_GREEN_600 [UIColor colorWithHexString:@"ff7cb342"]
#define BFCOLOR_LIGHT_GREEN_700 [UIColor colorWithHexString:@"ff689f38"]
#define BFCOLOR_LIGHT_GREEN_800 [UIColor colorWithHexString:@"ff558b2f"]
#define BFCOLOR_LIGHT_GREEN_900 [UIColor colorWithHexString:@"ff33691e"]
#define BFCOLOR_LIGHT_GREEN_A100 [UIColor colorWithHexString:@"ffccff90"]
#define BFCOLOR_LIGHT_GREEN_A200 [UIColor colorWithHexString:@"ffb2ff59"]
#define BFCOLOR_LIGHT_GREEN_A400 [UIColor colorWithHexString:@"ff76ff03"]
#define BFCOLOR_LIGHT_GREEN_A900 [UIColor colorWithHexString:@"ff64dd17"]
// LIME 青橙绿色
#define BFCOLOR_LIME_50 [UIColor colorWithHexString:@"fff9fbe7"]
#define BFCOLOR_LIME_100 [UIColor colorWithHexString:@"fff0f4c3"]
#define BFCOLOR_LIME_200 [UIColor colorWithHexString:@"ffe6ee9c"]
#define BFCOLOR_LIME_300 [UIColor colorWithHexString:@"ffdce775"]
#define BFCOLOR_LIME_400 [UIColor colorWithHexString:@"ffd4e157"]
#define BFCOLOR_LIME_500 [UIColor colorWithHexString:@"ffcddc39"]
#define BFCOLOR_LIME_600 [UIColor colorWithHexString:@"ffc0ca33"]
#define BFCOLOR_LIME_700 [UIColor colorWithHexString:@"ffafb42b"]
#define BFCOLOR_LIME_800 [UIColor colorWithHexString:@"ff9e9d24"]
#define BFCOLOR_LIME_900 [UIColor colorWithHexString:@"ff827717"]
#define BFCOLOR_LIME_A100 [UIColor colorWithHexString:@"fff4ff81"]
#define BFCOLOR_LIME_A200 [UIColor colorWithHexString:@"ffeeff41"]
#define BFCOLOR_LIME_A400 [UIColor colorWithHexString:@"ffc6ff00"]
#define BFCOLOR_LIME_A900 [UIColor colorWithHexString:@"ffaeea00"]
// YELLOW 黄色
#define BFCOLOR_YELLOW_50 [UIColor colorWithHexString:@"fffffde7"]
#define BFCOLOR_YELLOW_100 [UIColor colorWithHexString:@"fffff9c4"]
#define BFCOLOR_YELLOW_200 [UIColor colorWithHexString:@"fffff59d"]
#define BFCOLOR_YELLOW_300 [UIColor colorWithHexString:@"fffff176"]
#define BFCOLOR_YELLOW_400 [UIColor colorWithHexString:@"ffffee58"]
#define BFCOLOR_YELLOW_500 [UIColor colorWithHexString:@"ffffeb3b"]
#define BFCOLOR_YELLOW_600 [UIColor colorWithHexString:@"fffdd835"]
#define BFCOLOR_YELLOW_700 [UIColor colorWithHexString:@"fffbc02d"]
#define BFCOLOR_YELLOW_800 [UIColor colorWithHexString:@"fff9a825"]
#define BFCOLOR_YELLOW_900 [UIColor colorWithHexString:@"fff57f17"]
#define BFCOLOR_YELLOW_A100 [UIColor colorWithHexString:@"ffffff8d"]
#define BFCOLOR_YELLOW_A200 [UIColor colorWithHexString:@"ffffff00"]
#define BFCOLOR_YELLOW_A400 [UIColor colorWithHexString:@"ffffea00"]
#define BFCOLOR_YELLOW_A900 [UIColor colorWithHexString:@"ffffd600"]
// AMBER 琥珀色
#define BFCOLOR_AMBER_50 [UIColor colorWithHexString:@"fffff8e1"]
#define BFCOLOR_AMBER_100 [UIColor colorWithHexString:@"ffffecb3"]
#define BFCOLOR_AMBER_200 [UIColor colorWithHexString:@"ffffe082"]
#define BFCOLOR_AMBER_300 [UIColor colorWithHexString:@"ffffd54f"]
#define BFCOLOR_AMBER_400 [UIColor colorWithHexString:@"ffffca28"]
#define BFCOLOR_AMBER_500 [UIColor colorWithHexString:@"ffffc107"]
#define BFCOLOR_AMBER_600 [UIColor colorWithHexString:@"ffffb300"]
#define BFCOLOR_AMBER_700 [UIColor colorWithHexString:@"ffffa000"]
#define BFCOLOR_AMBER_800 [UIColor colorWithHexString:@"ffff8f00"]
#define BFCOLOR_AMBER_900 [UIColor colorWithHexString:@"ffff6f00"]
#define BFCOLOR_AMBER_A100 [UIColor colorWithHexString:@"ffffe57f"]
#define BFCOLOR_AMBER_A200 [UIColor colorWithHexString:@"ffffd740"]
#define BFCOLOR_AMBER_A400 [UIColor colorWithHexString:@"ffffc400"]
#define BFCOLOR_AMBER_A900 [UIColor colorWithHexString:@"ffffab00"]
// ORANGE 橙色
#define BFCOLOR_ORANGE_50 [UIColor colorWithHexString:@"fffff3e0"]
#define BFCOLOR_ORANGE_100 [UIColor colorWithHexString:@"ffffe0b2"]
#define BFCOLOR_ORANGE_200 [UIColor colorWithHexString:@"ffffcc80"]
#define BFCOLOR_ORANGE_300 [UIColor colorWithHexString:@"ffffb74d"]
#define BFCOLOR_ORANGE_400 [UIColor colorWithHexString:@"ffffa726"]
#define BFCOLOR_ORANGE_500 [UIColor colorWithHexString:@"ffff9800"]
#define BFCOLOR_ORANGE_600 [UIColor colorWithHexString:@"fffb8c00"]
#define BFCOLOR_ORANGE_700 [UIColor colorWithHexString:@"fff57c00"]
#define BFCOLOR_ORANGE_800 [UIColor colorWithHexString:@"ffef6c00"]
#define BFCOLOR_ORANGE_900 [UIColor colorWithHexString:@"ffe65100"]
#define BFCOLOR_ORANGE_A100 [UIColor colorWithHexString:@"ffffd180"]
#define BFCOLOR_ORANGE_A200 [UIColor colorWithHexString:@"ffffab40"]
#define BFCOLOR_ORANGE_A400 [UIColor colorWithHexString:@"ffff9100"]
#define BFCOLOR_ORANGE_A900 [UIColor colorWithHexString:@"ffff6d00"]
// Deep ORANGE 深橙色
#define BFCOLOR_DEEP_ORANGE_50 [UIColor colorWithHexString:@"fffbe9e7"]
#define BFCOLOR_DEEP_ORANGE_100 [UIColor colorWithHexString:@"ffffccbc"]
#define BFCOLOR_DEEP_ORANGE_200 [UIColor colorWithHexString:@"ffffab91"]
#define BFCOLOR_DEEP_ORANGE_300 [UIColor colorWithHexString:@"ffff8a65"]
#define BFCOLOR_DEEP_ORANGE_400 [UIColor colorWithHexString:@"ffff7043"]
#define BFCOLOR_DEEP_ORANGE_500 [UIColor colorWithHexString:@"ffff5722"]
#define BFCOLOR_DEEP_ORANGE_600 [UIColor colorWithHexString:@"fff4511e"]
#define BFCOLOR_DEEP_ORANGE_700 [UIColor colorWithHexString:@"ffe64a19"]
#define BFCOLOR_DEEP_ORANGE_800 [UIColor colorWithHexString:@"ffd84315"]
#define BFCOLOR_DEEP_ORANGE_900 [UIColor colorWithHexString:@"ffbf360c"]
#define BFCOLOR_DEEP_ORANGE_A100 [UIColor colorWithHexString:@"ffff9e80"]
#define BFCOLOR_DEEP_ORANGE_A200 [UIColor colorWithHexString:@"ffff6e40"]
#define BFCOLOR_DEEP_ORANGE_A400 [UIColor colorWithHexString:@"ffff3d00"]
#define BFCOLOR_DEEP_ORANGE_A900 [UIColor colorWithHexString:@"ffdd2c00"]
// BROWN 棕色
#define BFCOLOR_BROWN_50 [UIColor colorWithHexString:@"ffefebe9"]
#define BFCOLOR_BROWN_100 [UIColor colorWithHexString:@"ffd7ccc8"]
#define BFCOLOR_BROWN_200 [UIColor colorWithHexString:@"ffbcaaa4"]
#define BFCOLOR_BROWN_300 [UIColor colorWithHexString:@"ffa1887f"]
#define BFCOLOR_BROWN_400 [UIColor colorWithHexString:@"ff8d6e63"]
#define BFCOLOR_BROWN_500 [UIColor colorWithHexString:@"ff795548"]
#define BFCOLOR_BROWN_600 [UIColor colorWithHexString:@"ff6d4c41"]
#define BFCOLOR_BROWN_700 [UIColor colorWithHexString:@"ff5d4037"]
#define BFCOLOR_BROWN_800 [UIColor colorWithHexString:@"ff4e342e"]
#define BFCOLOR_BROWN_900 [UIColor colorWithHexString:@"ff3e2723"]
// GREY 灰色
#define BFCOLOR_GREY_50 [UIColor colorWithHexString:@"fffafafa"]
#define BFCOLOR_GREY_100 [UIColor colorWithHexString:@"fff5f5f5"]
#define BFCOLOR_GREY_200 [UIColor colorWithHexString:@"ffeeeeee"]
#define BFCOLOR_GREY_300 [UIColor colorWithHexString:@"ffe0e0e0"]
#define BFCOLOR_GREY_400 [UIColor colorWithHexString:@"ffbdbdbd"]
#define BFCOLOR_GREY_500 [UIColor colorWithHexString:@"ff9e9e9e"]
#define BFCOLOR_GREY_600 [UIColor colorWithHexString:@"ff757575"]
#define BFCOLOR_GREY_700 [UIColor colorWithHexString:@"ff616161"]
#define BFCOLOR_GREY_800 [UIColor colorWithHexString:@"ff424242"]
#define BFCOLOR_GREY_900 [UIColor colorWithHexString:@"ff212121"]
#define BFCOLOR_GREY_1000_BLACK [UIColor colorWithHexString:@"ff000000"]
#define BFCOLOR_GREY_1000_WHITE [UIColor colorWithHexString:@"ffffffff"]
// BLUE GREY 蓝灰色
#define BFCOLOR_BLUE_GREY_50 [UIColor colorWithHexString:@"ffeceff1"]
#define BFCOLOR_BLUE_GREY_100 [UIColor colorWithHexString:@"ffcfd8dc"]
#define BFCOLOR_BLUE_GREY_200 [UIColor colorWithHexString:@"ffb0bec5"]
#define BFCOLOR_BLUE_GREY_300 [UIColor colorWithHexString:@"ff90a4ae"]
#define BFCOLOR_BLUE_GREY_400 [UIColor colorWithHexString:@"ff78909c"]
#define BFCOLOR_BLUE_GREY_500 [UIColor colorWithHexString:@"ff607d8b"]
#define BFCOLOR_BLUE_GREY_600 [UIColor colorWithHexString:@"ff546e7a"]
#define BFCOLOR_BLUE_GREY_700 [UIColor colorWithHexString:@"ff455a64"]
#define BFCOLOR_BLUE_GREY_800 [UIColor colorWithHexString:@"ff37474f"]
#define BFCOLOR_BLUE_GREY_900 [UIColor colorWithHexString:@"ff263238"]

//  UIColor扩展
//
//  Created by lcy on 14/12/12.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

@interface UIColor (BFCategory)

/**
 * Creates a new UIColor instance using a hex input and alpha value.
 
 * e.g., UIColor *blue; [UIColor colorWithHex:0x00FF00 andAlpha:0.5f]
 *
 * @param {UInt32} Hex
 * @param {CGFloat} Alpha
 *
 * @return {UIColor}
 */
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

/**
 * Creates a new UIColor instance using a hex input.
 
 * e.g., UIColor *green; [UIColor colorWithHex:0x00FF00]
 *
 * @param {UInt32} Hex
 *
 * @return {UIColor}
 */
+ (UIColor *)colorWithHex:(UInt32)hex;

/**
 * Creates a new UIColor instance using a hex string input.
 
 * e.g., UIColor *gray; [UIColor colorWithHexString:@"#CCC"]
 *
 * @param {NSString} Hex string (ie: @"ff", @"#fff", @"ff0000", or @"ccff00ff")(AARRGGBB)
 *
 * @return {UIColor}
 */
+ (UIColor *)colorWithHexString:(id)input;

/**
 * Returns the hex value of the receiver. Alpha value is not included.
 *
 * @return {UInt32}
 */
- (UInt32)hexValue;

/**
 *  是否为浅色
 */
- (BOOL)isLight;

@end
