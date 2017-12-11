//
//  BFViewUtils.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/11.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFViewUtils.h"
#import "XworksCore.h"

BF_FIX_CATEGORY_BUG(BFViewUtils)

@implementation UIView (BFHierarchy)

// 一些特定的系统实现类
Class BF_UIAlertSheetTextFieldClass;
Class BF_UIAlertSheetTextFieldClass_iOS8;

Class BF_UITableViewCellScrollViewClass;
Class BF_UITableViewWrapperViewClass;

Class BF_UISearchBarTextFieldClass;

+(void)initialize
{
    [super initialize];
    
    BF_UIAlertSheetTextFieldClass          = NSClassFromString(@"UIAlertSheetTextField");
    BF_UIAlertSheetTextFieldClass_iOS8     = NSClassFromString(@"_UIAlertControllerTextField");
    
    BF_UITableViewCellScrollViewClass      = NSClassFromString(@"UITableViewCellScrollView");
    BF_UITableViewWrapperViewClass         = NSClassFromString(@"UITableViewWrapperView");
    
    BF_UISearchBarTextFieldClass           = NSClassFromString(@"UISearchBarTextField");
}


+ (void)detactView:(UIView *)view {
    NSMutableString *str = [[NSMutableString alloc] initWithString:@""];
    [UIView detactSubview:view layer:0 buffer:str];
    BFLog(@"%@.herarchy=%@", view, str);
}

+ (void)detactSubview:(UIView *)view layer:(int)layer buffer:(NSMutableString*)buffer {
    NSMutableString *s = [[NSMutableString alloc] init];
    for (int i=0; i<layer; i++) {
        [s appendString:@"\t"];
    }
    NSString *sName = NSStringFromClass([view class]);
    [buffer appendFormat:@"%@%@ %@\n",s,sName, NSStringFromCGRect(view.frame)];
    if (view.subviews.count>0) {
        [buffer appendFormat:@"%@{\n",s];
        layer++;
        for(UIView *subView in view.subviews){
            [self detactSubview:subView layer:layer buffer:buffer];
        }
        [buffer appendFormat:@"%@}\n",s];
    }
}


- (UIViewController *)viewController {
    UIResponder *nextResponder =  self;
    
    do {
        nextResponder = [nextResponder nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController*)nextResponder;
        
    } while (nextResponder != nil);
    
    return nil;
}

- (UIScrollView*)superScrollView
{
    UIView *superview = self.superview;
    
    while (superview) {
        //UITableViewWrapperView
        if ([superview isKindOfClass:[UIScrollView class]]
                && ([superview isKindOfClass:BF_UITableViewCellScrollViewClass] == NO)
                && ([superview isKindOfClass:BF_UITableViewWrapperViewClass] == NO)) {
            return (UIScrollView*)superview;
        } else {
            superview = superview.superview;
        }
    }
    
    return nil;
}

- (UITableView*)superTableView
{
    UIView *superview = self.superview;
    
    while (superview) {
        if ([superview isKindOfClass:[UITableView class]]) {
            return (UITableView*)superview;
        } else {
            superview = superview.superview;
        }
    }
    
    return nil;
}

/**
 * @abstract 返回view上层的UITableViewCell
 */
- (UITableViewCell *)superTableViewCell {
    UIView *superview = self.superview;
    
    while (superview) {
        if ([superview isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell*)superview;
        } else {
            superview = superview.superview;
        }
    }
    return nil;
}

-(BOOL)isSearchBarTextField
{
    return ([self isKindOfClass:BF_UISearchBarTextFieldClass] || [self isKindOfClass:[UISearchBar class]]);
}

-(BOOL)isAlertViewTextField
{
    return ([self isKindOfClass:BF_UIAlertSheetTextFieldClass] || [self isKindOfClass:BF_UIAlertSheetTextFieldClass_iOS8]);
}

@end

@implementation UIView (BFRoundCornor)

- (void)roundCornorWithRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)borderWith {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = borderWith;
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
}

@end

@implementation UIView (BFAccess)

#pragma mark Frame

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)newOrigin
{
    CGRect newFrame = self.frame;
    newFrame.origin = newOrigin;
    self.frame = newFrame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)newSize
{
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    self.frame = newFrame;
}


#pragma mark Frame Origin

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)newX
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = newX;
    self.frame = newFrame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = newY;
    self.frame = newFrame;
}


#pragma mark Frame Size

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newHeight
{
    CGRect newFrame = self.frame;
    newFrame.size.height = newHeight;
    self.frame = newFrame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newWidth
{
    CGRect newFrame = self.frame;
    newFrame.size.width = newWidth;
    self.frame = newFrame;
}


#pragma mark Frame Borders

- (CGFloat)left
{
    return self.x;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    self.x = right - self.width;
}

- (CGFloat)top
{
    return self.y;
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    self.y = bottom - self.height;
}


#pragma mark Center Point

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)newCenterX
{
    self.center = CGPointMake(newCenterX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)newCenterY
{
    self.center = CGPointMake(self.center.x, newCenterY);
}


#pragma mark Middle Point

- (CGPoint)middlePoint
{
    return CGPointMake(self.middleX, self.middleY);
}

- (CGFloat)middleX
{
    return self.width / 2;
}

- (CGFloat)middleY
{
    return self.height / 2;
}

@end


@implementation UIScrollView (BFAccess)

#pragma mark Content Offset

- (CGFloat)contentOffsetX
{
    return self.contentOffset.x;
}

- (CGFloat)contentOffsetY
{
    return self.contentOffset.y;
}

- (void)setContentOffsetX:(CGFloat)newContentOffsetX
{
    self.contentOffset = CGPointMake(newContentOffsetX, self.contentOffsetY);
}

- (void)setContentOffsetY:(CGFloat)newContentOffsetY
{
    self.contentOffset = CGPointMake(self.contentOffsetX, newContentOffsetY);
}


#pragma mark Content Size

- (CGFloat)contentSizeWidth
{
    return self.contentSize.width;
}

- (CGFloat)contentSizeHeight
{
    return self.contentSize.height;
}

- (void)setContentSizeWidth:(CGFloat)newContentSizeWidth
{
    self.contentSize = CGSizeMake(newContentSizeWidth, self.contentSizeHeight);
}

- (void)setContentSizeHeight:(CGFloat)newContentSizeHeight
{
    self.contentSize = CGSizeMake(self.contentSizeWidth, newContentSizeHeight);
}


#pragma mark Content Inset

- (CGFloat)contentInsetTop
{
    return self.contentInset.top;
}

- (CGFloat)contentInsetRight
{
    return self.contentInset.right;
}

- (CGFloat)contentInsetBottom
{
    return self.contentInset.bottom;
}

- (CGFloat)contentInsetLeft
{
    return self.contentInset.left;
}

- (void)setContentInsetTop:(CGFloat)newContentInsetTop
{
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.top = newContentInsetTop;
    self.contentInset = newContentInset;
}

- (void)setContentInsetRight:(CGFloat)newContentInsetRight
{
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.right = newContentInsetRight;
    self.contentInset = newContentInset;
}

- (void)setContentInsetBottom:(CGFloat)newContentInsetBottom
{
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.bottom = newContentInsetBottom;
    self.contentInset = newContentInset;
}

- (void)setContentInsetLeft:(CGFloat)newContentInsetLeft
{
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.left = newContentInsetLeft;
    self.contentInset = newContentInset;
}

@end