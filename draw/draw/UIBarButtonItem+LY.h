//
//  UIBarButtonItem+LY.h
//  SinaBlog
//
//  Created by liuyang on 15/7/10.
//  Copyright (c) 2015年 YoungLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LY)
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target highIcon:(NSString *)highIcon action:(SEL)action;

@end
