//
//  BFNavigationController.m
//  OkayappsFrameworkDev
//
//  Created by lcy on 14/12/17.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFNavigationController.h"

@interface BFNavigationController ()

@end

@implementation BFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:YES];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)setNavigationBarBackgroundImage:(NSString *)name
{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:name] forBarPosition:(UIBarPositionTopAttached) barMetrics:(UIBarMetricsDefault)];
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {
        [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}

- (void)setNavigationBarBackgroundColor:(UIColor *)color
{
    [self.navigationBar setBackgroundImage:[self createImageWithColor:color] forBarPosition:(UIBarPositionTopAttached) barMetrics:(UIBarMetricsDefault)];
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {
        [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
