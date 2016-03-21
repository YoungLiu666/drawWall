//
//  GZPDrawController.h
//  YunYi
//
//  Created by liuyang on 15/8/5.
//  Copyright (c) 2015年 北京日立北工大信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface GZPDrawController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *ColorButton;//选中颜色按钮

- (IBAction)clear:(id)sender;//清除按钮方法
- (IBAction)changeColors:(id)sender;//改变颜色方法
- (IBAction)saveScreen:(id)sender;//橡皮按钮方法
- (IBAction)changeWidth:(id)sender;
- (IBAction)colorSet:(id)sender;
-(IBAction)widthSet:(id)sender;
//- (IBAction)remove:(id)sender;
//- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *drawBrushBtn;//选中画笔
@property (weak, nonatomic) IBOutlet UIButton *drawEraserBtn;//选中橡皮

@property (weak, nonatomic) IBOutlet UIView *drawFootView;//画板底部view
@property (weak, nonatomic) IBOutlet UIView *selectColorView;
@property (weak, nonatomic) IBOutlet UIButton *porBtn;
@property (weak, nonatomic) IBOutlet UIButton *yellowBtn;
@property (weak, nonatomic) IBOutlet UIButton *blueBtn;
@property (weak, nonatomic) IBOutlet UIButton *sblueBtn;
@property (weak, nonatomic) IBOutlet UIButton *greenBtn;
@property (weak, nonatomic) IBOutlet UIButton *orBtn;
@property (weak, nonatomic) IBOutlet UIButton *poBtn;



+(id)drawController;
@end
