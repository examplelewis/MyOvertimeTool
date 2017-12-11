//
//  BFImageUtils.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/11.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFImageUtils.h"
#import "XworksCore.h"

UIImage* BFImageByApplyingAlpha(UIImage *image, CGFloat alpha) {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

UIImage* BFImageWithColor(UIColor *color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

BF_FIX_CATEGORY_BUG(BFImageUtils)
@implementation UIImage (BFImageUtils)

- (UIImage *)bf_subimageIAtRect:(CGRect)targetRect
{
    targetRect.origin.x*=self.scale;
    targetRect.origin.y*=self.scale;
    targetRect.size.width*=self.scale;
    targetRect.size.height*=self.scale;
    
    if (targetRect.origin.x<0) {
        targetRect.origin.x = 0;
    }
    if (targetRect.origin.y<0) {
        targetRect.origin.y = 0;
    }
    
    //宽度高度过界就删去
    CGFloat cgWidth = CGImageGetWidth(self.CGImage);
    CGFloat cgHeight = CGImageGetHeight(self.CGImage);
    if (CGRectGetMaxX(targetRect)>cgWidth) {
        targetRect.size.width = cgWidth-targetRect.origin.x;
    }
    if (CGRectGetMaxY(targetRect)>cgHeight) {
        targetRect.size.height = cgHeight-targetRect.origin.y;
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, targetRect);
    UIImage *resultImage=[UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    //修正回原scale和方向
    resultImage = [UIImage imageWithCGImage:resultImage.CGImage scale:self.scale orientation:self.imageOrientation];
    
    return resultImage;
}

@end

@implementation UIImage (BFBlur)

- (UIImage *)bf_blurImage
{
    return [self bf_blurImageWithBlur:1.f];
}
- (UIImage *)bf_blurImageWithBlur:(CGFloat)blur
{
    return [self bf_blurImageWithBlur:blur withTintColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4]];
}
- (UIImage *)bf_blurImageWithBlur:(CGFloat)blur withTintColor:(UIColor *)tintColor
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    /*void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
     vImage_Buffer outBuffer2;
     outBuffer2.data = pixelBuffer2;
     outBuffer2.width = CGImageGetWidth(img);
     outBuffer2.height = CGImageGetHeight(img);
     outBuffer2.rowBytes = CGImageGetBytesPerRow(img);*/
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend)
    ?: vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend)
    ?: vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGRect imageRect = {CGPointZero, self.size};
    
    // Add in color tint.
    if (tintColor) {
        CGRect armRect = CGRectMake(imageRect.origin.x*self.scale, imageRect.origin.y*self.scale, imageRect.size.width*self.scale, imageRect.size.height*self.scale);
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, tintColor.CGColor);
        CGContextFillRect(ctx, armRect);
        CGContextRestoreGState(ctx);
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    //free(pixelBuffer2);
    
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}


@end