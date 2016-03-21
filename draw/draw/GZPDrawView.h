//
//  GZPDrawView.h
//  YunYi
//
//  Created by liuyang on 15/8/6.
//  Copyright (c) 2015年 北京日立北工大信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol drawDelegate<NSObject>
- (void)startDraw;
@end
@interface GZPDrawView : UIView

@property (nonatomic,weak)id<drawDelegate>delegate;
@property (nonatomic,assign)BOOL hhhidden;
-(void)addPA:(CGPoint)nPoint;
-(void)addLA;
-(void)revocation;
-(void)refrom;
-(void)clear;
-(void)setLineColor:(NSInteger)color;//绘画颜色
-(void)setlineWidth:(NSInteger)width;//绘画宽度

@end
