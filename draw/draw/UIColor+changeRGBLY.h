//
//  UIColor+changeRGBLY.h
//  YunYi
//
//  Created by liuyang on 15/8/19.
//  Copyright (c) 2015年 北京日立北工大信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (changeRGBLY)
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
