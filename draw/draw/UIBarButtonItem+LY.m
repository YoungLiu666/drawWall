//
//  UIBarButtonItem+LY.m
//  SinaBlog
//
//  Created by liuyang on 15/7/10.
//  Copyright (c) 2015年 YoungLiu. All rights reserved.
//

#import "UIBarButtonItem+LY.h"
#import "UIImage+LY.h"
@implementation UIBarButtonItem (LY)

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target highIcon:(NSString *)highIcon action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    button.bounds = (CGRect){CGPointZero,button.currentBackgroundImage.size.width/2.6,button.currentBackgroundImage.size.height/2.6};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
