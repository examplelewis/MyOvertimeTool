//
//  BFImageUtils.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/11.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

#if defined __cplusplus
extern "C" {
#endif
    /**
     * 对指定的图片应用透明度值
     */
    UIImage* BFImageByApplyingAlpha(UIImage *image, CGFloat alpha);
    
    /**
     * 生产指定颜色的图片，大小为(1px * 1px)
     */
    UIImage* BFImageWithColor(UIColor *color);
    
#if defined __cplusplus
};
#endif

@interface UIImage (BFImageUtils)

/**
 * 获取图片部分子图片，以像素矩形定位该子图片
 */

- (UIImage *)bf_subimageIAtRect:(CGRect)rect;

@end

@interface UIImage  (BFBlur)

/**
 * 毛玻璃效果
 */

/* blur the current image with a box blur algoritm */

- (UIImage*)bf_blurImage;

/* blur the current image with a box blur algoritm */

- (UIImage*)bf_blurImageWithBlur:(CGFloat)blur;

/* blur the current image with a box blur algoritm and tint with a color */

- (UIImage*)bf_blurImageWithBlur:(CGFloat)blur withTintColor:(UIColor*)tintColor;

@end

