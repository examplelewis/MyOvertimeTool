//
//  BFBaseViewController.m
//  OkayappsFrameworkDev
//
//  Created by lcy on 14/12/17.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFBaseViewController ()


@end

@implementation BFBaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // iOS7和iOS8的适配
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)dealloc {

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

- (void)addLeftBarButtonItemWithTitle:(NSString*)title textColor:(UIColor*)color fontSize:(CGFloat)fontSize frame:(CGRect)frame action:(SEL)action
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = frame;
    [leftButton setTitle:title forState:(UIControlStateNormal)];
    [leftButton setTitleColor:color forState:(UIControlStateNormal)];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    NSMutableArray *leftBarButtonItems = [self.navigationItem.leftBarButtonItems mutableCopy];
    if (!leftBarButtonItems) {
        leftBarButtonItems = [NSMutableArray array];
        [leftBarButtonItems addObject:[self fixBarButtonItem4iOS7]];
    }
    [leftBarButtonItems addObject:leftBarButton];
    self.navigationItem.leftBarButtonItems = leftBarButtonItems;
}

- (void)addLeftBarButtonItemWithImage:(NSString*)imageName frame:(CGRect)frame action:(SEL)action
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = frame;
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    NSMutableArray *leftBarButtonItems = [self.navigationItem.leftBarButtonItems mutableCopy];
    if (!leftBarButtonItems) {
        leftBarButtonItems = [NSMutableArray array];
        [leftBarButtonItems addObject:[self fixBarButtonItem4iOS7]];
    }
    [leftBarButtonItems addObject:leftBarButton];
    self.navigationItem.leftBarButtonItems = leftBarButtonItems;
}

- (void)addRightBarButtonItemWithTitle:(NSString*)title textColor:(UIColor*)color fontSize:(CGFloat)fontSize frame:(CGRect)frame action:(SEL)action
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = frame;
    [rightButton setTitle:title forState:(UIControlStateNormal)];
    [rightButton setTitleColor:color forState:(UIControlStateNormal)];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    NSMutableArray *rightBarButtonItems = [self.navigationItem.rightBarButtonItems mutableCopy];
    if (!rightBarButtonItems) {
        rightBarButtonItems = [NSMutableArray array];
        [rightBarButtonItems addObject:[self fixBarButtonItem4iOS7]];
    }
    [rightBarButtonItems addObject:rightBarButton];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
}

- (void)addRightBarButtonItemWithImage:(NSString*)imageName frame:(CGRect)frame action:(SEL)action
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = frame;
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [rightButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    NSMutableArray *rightBarButtonItems = [self.navigationItem.rightBarButtonItems mutableCopy];
    if (!rightBarButtonItems) {
        rightBarButtonItems = [NSMutableArray array];
        [rightBarButtonItems addObject:[self fixBarButtonItem4iOS7]];
    }
    [rightBarButtonItems addObject:rightBarButton];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
}

/**
 * 修正iOS7的边距
 */
- (UIBarButtonItem *)fixBarButtonItem4iOS7
{
    UIBarButtonItem *fixSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixSpacer.width = -10;
    return fixSpacer;
}

@end
