//
//  GZPDrawController.m
//  YunYi
//
//  Created by liuyang on 15/8/5.
//  Copyright (c) 2015年 北京日立北工大信息系统有限公司. All rights reserved.
//

#import "GZPDrawController.h"
#import "GZPDrawView.h"
#import "UIColor+changeRGBLY.h"
#import "UIBarButtonItem+LY.h"

@interface GZPDrawController ()<drawDelegate>

@property (weak, nonatomic) IBOutlet UIButton *widthBtnOne;//线宽按钮
@property (weak, nonatomic) IBOutlet UIButton *widthBtnTwo;
@property (weak, nonatomic) IBOutlet UIButton *widthBtnThree;
@property (weak, nonatomic) IBOutlet UIButton *widthBtnFoure;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;//垃圾桶

@property (weak, nonatomic) IBOutlet UIButton *eraserBtn;//橡皮初始
@property (weak, nonatomic) IBOutlet UIButton *paintBrushBtn;//绘画笔初始



@property (strong,nonatomic)  GZPDrawView * drawView;//绘画板视图
@property (assign,nonatomic)  BOOL buttonHidden;
@property (assign,nonatomic)  BOOL widthHidden;
@property (nonatomic,strong)  NSMutableArray *colors; //保存线条颜色
@property(nonatomic,weak)UINavigationBar * navigationBar;

@property(nonatomic,weak)UIImageView * imageView1;//线宽按钮里面的图片视图
@property(nonatomic,weak)UIImageView * imageView2;
@property(nonatomic,weak)UIImageView * imageView3;
@property(nonatomic,weak)UIImageView * imageView4;

@end

@implementation GZPDrawController
{
    int  _indexBtn;
    int _indexWidth;
}
+(id)drawController
{
    NSArray * objs = [[NSBundle mainBundle]loadNibNamed:@"GZPDrawController" owner:nil options:nil];
    return [objs lastObject];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _indexBtn = 16;
    _indexWidth = 1;
    //1.设置导航栏内容
    [self setupNavBar];
    
    self.view.backgroundColor = [UIColor yellowColor];
    _colors=[[NSMutableArray alloc]initWithObjects:[UIColor blackColor],[UIColor redColor],[UIColor colorWithHexString:@"#ea77f4"],[UIColor colorWithHexString:@"#f7f88d"],[UIColor colorWithHexString:@"#000cff"],[UIColor colorWithHexString:@"#00eaff"],[UIColor colorWithHexString:@"#30d71e"],[UIColor colorWithHexString:@"#ff7d2f"],[UIColor colorWithHexString:@"#8400ff"],[UIColor whiteColor],[UIColor whiteColor],nil];
    CGRect viewFrame=self.view.frame;
    self.buttonHidden=NO;
    self.widthHidden=NO;
    self.drawView=[[GZPDrawView alloc]initWithFrame:viewFrame];
    self.drawView.delegate = self;
    [self.drawView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview: self.drawView];
    [self.view sendSubviewToBack:self.drawView];
    
    [self.porBtn setBackgroundColor:[UIColor colorWithHexString:@"#ea77f4"]];
    [self.yellowBtn setBackgroundColor:[UIColor colorWithHexString:@"#f7f88d"]];
    [self.blueBtn setBackgroundColor:[UIColor colorWithHexString:@"#000cff"]];
    [self.sblueBtn setBackgroundColor:[UIColor colorWithHexString:@"#00eaff"]];
    [self.greenBtn setBackgroundColor:[UIColor colorWithHexString:@"#30d71e"]];
    [self.orBtn setBackgroundColor:[UIColor colorWithHexString:@"#ff7d2f"]];
    [self.poBtn setBackgroundColor:[UIColor colorWithHexString:@"#8400ff"]];
    
    
    //创建所有按钮的样式
    [self createAllButton];
}

-(void)setupNavBar
{
    UINavigationBar * navigationBar = [[UINavigationBar alloc]init];
    navigationBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"main_bg_top"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar = navigationBar;
    
    [self.view addSubview:navigationBar];
    //左边按钮
   // self.navigationItem.leftBarButtonItem = [UIBarButtonItem  itemWithIcon:@"all_ico_back" target:self highIcon:@"all_ico_back1" action:@selector(backClick)];
    //右边按钮po
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"main_ico_search" target:self highIcon:@"main_ico_search1" action:@selector(search)];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:23];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = @"绘图板";  //设置标题
    self.navigationItem.titleView = titleLabel;
}

-(void)createAllButton
{
    [self.clearBtn setBackgroundImage:[UIImage imageNamed:@"draw_ico_delete1"] forState:UIControlStateNormal];
    [self.clearBtn setBackgroundImage:[UIImage imageNamed:@"draw_ico_delete"] forState:UIControlStateHighlighted];
    
    self.widthBtnOne.selected = YES;
    self.widthBtnTwo.selected = YES;
    self.widthBtnThree.selected = YES;
    self.widthBtnFoure.selected = YES;

    UIImageView * imageView1 = [[UIImageView alloc]init];
    [self.widthBtnOne addSubview:imageView1];
    imageView1.image = [UIImage imageNamed:@"draw_ico_brush1"];
    imageView1.frame = CGRectMake(10, 10, 5, 5);
    self.imageView1 = imageView1;
    
    UIImageView * imageView2 = [[UIImageView alloc]init];
    [self.widthBtnTwo addSubview:imageView2];
    imageView2.image = [UIImage imageNamed:@"draw_ico_brush2-2"];
    imageView2.frame = CGRectMake(9, 9, 7, 7);
    self.imageView2 = imageView2;
    
    UIImageView * imageView3 = [[UIImageView alloc]init];
    [self.widthBtnThree addSubview:imageView3];
    imageView3.image = [UIImage imageNamed:@"draw_ico_brush3"];
    imageView3.frame = CGRectMake(8, 8, 9, 9);
    self.imageView3 = imageView3;
    
    UIImageView * imageView4 = [[UIImageView alloc]init];
    [self.widthBtnFoure addSubview:imageView4];
    imageView4.image = [UIImage imageNamed:@"draw_ico_brush4"];
    imageView4.frame = CGRectMake(7, 7, 11, 11);
    self.imageView4 = imageView4;
    
    [self.paintBrushBtn setBackgroundImage:[UIImage imageNamed:@"draw_img_pen"] forState:UIControlStateNormal];
    [self.paintBrushBtn setBackgroundImage:[UIImage imageNamed:@"draw_img_pen1"] forState:UIControlStateSelected];
    
    [self.drawBrushBtn setBackgroundImage:[UIImage imageNamed:@"draw_img_pen2"] forState:UIControlStateNormal];
    [self.drawBrushBtn setBackgroundImage:[UIImage imageNamed:@"draw_img_pen2-1"] forState:UIControlStateSelected];
    
    [self.eraserBtn setBackgroundImage:[UIImage imageNamed:@"draw_img_rubber"] forState:UIControlStateNormal];
    [self.eraserBtn setBackgroundImage:[UIImage imageNamed:@"draw_img_rubber1"] forState:UIControlStateSelected];
    
    [self.drawEraserBtn setBackgroundImage:[UIImage imageNamed:@"draw_img_rubber2"] forState:UIControlStateNormal];
    [self.drawEraserBtn setBackgroundImage:[UIImage imageNamed:@"draw_img_rubber2-1"] forState:UIControlStateSelected];
 
}

//清除所有绘制的东西
- (IBAction)clear:(UIButton *)button {
    [self.drawView clear];
   // [self colorSet:button];
}

//改变颜色
- (IBAction)changeColors:(UIButton *)button {
    if (self.buttonHidden==NO) {
        for (int i=1; i<12; i++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
//            button.hidden=NO;
//            self.buttonHidden=NO;
        }
   }
}

//橡皮橡皮
- (IBAction)saveScreen:(UIButton *)button {
    if (self.buttonHidden==NO) {
        for (int i=12; i<16; i++) {
            _drawView.hhhidden = YES;
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            button.hidden=YES;
            self.buttonHidden=YES;
            self.selectColorView.hidden = YES;
            self.drawFootView.hidden = YES;
            self.drawBrushBtn.hidden = YES;
            self.eraserBtn.selected = YES;
        }
        [self colorSet:button];
        [self changeColors:button];
        [self widthSet:button];
    }else{
        for (int i=1; i<18; i++) {
            self.drawView.hhhidden = NO;
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            button.hidden=NO;
            self.buttonHidden=NO;
            self.drawFootView.hidden = NO;
            self.selectColorView.hidden = NO;
            self.drawBrushBtn.hidden = NO;
            self.drawEraserBtn.selected = YES;
        }
    }
//    UIGraphicsBeginImageContext(self.view.bounds.size);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
//    for (int i=1;i<18;i++) {
//        if ((i>=1&&i<=6)||(i>=13&&i<=16)) {
//            continue;
//        }
//        UIView *view=[self.view viewWithTag:i];
//        view.hidden=NO;
//    }
//    //截屏成功
//    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Save OK" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
//    [alertView show];
}

//改变宽度按钮
- (IBAction)changeWidth:(id)sender {
    if (self.buttonHidden==NO) {
        _drawView.hhhidden = YES;
        for (int i=1; i<18; i++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            button.hidden=YES;
            self.buttonHidden=YES;
            self.selectColorView.hidden = YES;
            self.drawFootView.hidden = YES;
            self.drawEraserBtn.hidden = YES;
        }
    }else{
        for (int i=1; i<18; i++) {
            _drawView.hhhidden = NO;
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            button.hidden=NO;
            self.buttonHidden=NO;
            self.drawFootView.hidden = NO;
            self.selectColorView.hidden = NO;
            self.drawEraserBtn.hidden = NO;
        }
        
    }

}

//点击各种颜色按钮后给线的颜色赋值，给颜色按钮改变颜色
- (IBAction)colorSet:(UIButton *)button{
    //UIButton *button=(UIButton *)sender;
    if (_indexBtn == 16) {
        _indexBtn = 1;
    }
    if (button.tag == 11) {
        [self.drawView setLineColor:button.tag-1];
    }else if (button.tag == 17)
    {
    self.drawEraserBtn.selected = NO;
        self.eraserBtn.selected = NO;
     [self.drawView setLineColor:_indexBtn-1];
//    self.ColorButton.tag = 16;
    }
    else {
    self.drawEraserBtn.selected = NO;
        self.eraserBtn.selected = NO;
    _indexBtn = (int)button.tag;
    [self.drawView setLineColor:button.tag-1];
    self.ColorButton.backgroundColor=[_colors objectAtIndex:button.tag-1];
    }
}

//点击各种颜色后通过setlineWidth方法给线宽数组赋值
-(IBAction)widthSet:(id)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag == 11) {
    [self.drawView setlineWidth:4];
    }
    if (button.selected == YES && button.tag == 12) {
        _indexWidth = 0;
        [self.drawView setlineWidth:button.tag-12];
        self.imageView1.image = [UIImage imageNamed:@"draw_ico_brush1-2"];
        self.imageView2.image = [UIImage imageNamed:@"draw_ico_brush2"];
        self.widthBtnTwo.selected = YES;
        self.imageView3.image = [UIImage imageNamed:@"draw_ico_brush3"];
        self.widthBtnThree.selected = YES;
        self.imageView4.image = [UIImage imageNamed:@"draw_ico_brush4"];
        self.widthBtnFoure.selected = YES;
        
         button.selected = NO;
    }else if(button.selected == NO && button.tag == 12){
        self.imageView1.image = [UIImage imageNamed:@"draw_ico_brush1"];
        button.selected = YES;
    }
    
    if (button.selected == YES && button.tag == 13) {
        _indexWidth = 1;
        [self.drawView setlineWidth:button.tag-12];
        self.imageView2.image = [UIImage imageNamed:@"draw_ico_brush2-2"];
        self.imageView1.image = [UIImage imageNamed:@"draw_ico_brush1"];
        self.widthBtnOne.selected = YES;
        self.imageView3.image = [UIImage imageNamed:@"draw_ico_brush3"];
        self.widthBtnThree.selected = YES;
        self.imageView4.image = [UIImage imageNamed:@"draw_ico_brush4"];
        self.widthBtnFoure.selected = YES;
        
        button.selected = NO;
    }else if(button.selected == NO && button.tag == 13){
        self.imageView2.image = [UIImage imageNamed:@"draw_ico_brush2"];
        button.selected = YES;
    }
    if (button.selected == YES && button.tag == 14) {
        _indexWidth = 2;
        [self.drawView setlineWidth:button.tag-12];
        self.imageView3.image = [UIImage imageNamed:@"draw_ico_brush3-2"];
        self.imageView1.image = [UIImage imageNamed:@"draw_ico_brush1"];
        self.widthBtnOne.selected = YES;
        self.imageView2.image = [UIImage imageNamed:@"draw_ico_brush2"];
        self.widthBtnTwo.selected = YES;
        self.imageView4.image = [UIImage imageNamed:@"draw_ico_brush4"];
        self.widthBtnFoure.selected = YES;
        
        button.selected = NO;
    }else if(button.selected == NO && button.tag == 14){
        self.imageView3.image = [UIImage imageNamed:@"draw_ico_brush3"];
        button.selected = YES;
    }
    if (button.selected == YES && button.tag == 15) {
        _indexWidth = 3;
        [self.drawView setlineWidth:button.tag-12];
        self.imageView4.image = [UIImage imageNamed:@"draw_ico_brush4-2"];
        self.imageView1.image = [UIImage imageNamed:@"draw_ico_brush1"];
        self.widthBtnOne.selected = YES;
        self.imageView2.image = [UIImage imageNamed:@"draw_ico_brush2"];
        self.widthBtnTwo.selected = YES;
        self.imageView3.image = [UIImage imageNamed:@"draw_ico_brush3"];
        self.widthBtnThree.selected = YES;
        
        button.selected = NO;
    }else if(button.selected == NO && button.tag == 15){
        self.imageView4.image = [UIImage imageNamed:@"draw_ico_brush4"];
        button.selected = YES;
    }

//    if (self.widthBtnOne.selected == YES && self.widthBtnTwo.selected == YES && self.widthBtnThree.selected == YES && self.widthBtnFoure.selected == YES) {
//        [self.drawView setlineWidth:0];
//    }
    if (button.tag == 17 ) {
        [self.drawView setlineWidth:_indexWidth];
    }
    
}

////移除上一个绘图
//- (IBAction)remove:(id)sender {
//  [self.drawView revocation];
//}
//
////返回上一笔绘图
//- (IBAction)back:(id)sender {
//  [self.drawView refrom];
//}

//-(void)backClick
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

//导航条右侧查询按钮功能，保存图片到相册内并直接查询类似图片
-(void)search
{
    for (int i=1;i<19;i++) {
        UIView *view=[self.view viewWithTag:i];
        if (i>=1&&i<=18) {
            if (view.hidden==YES) {
                continue;
            }
        }
        view.hidden=YES;
        if(i>=1&&i<=18){
            self.buttonHidden=YES;
        }
//        if(i>=1&&i<=18){
//            self.widthHidden=YES;
//        }
    }
    self.selectColorView.hidden = YES;
    self.drawFootView.hidden = YES;
    self.drawBrushBtn.hidden = YES;
    self.drawEraserBtn.hidden = YES;
    self.navigationBar.hidden = YES;
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    for (int i=1;i<19;i++) {
        if (i>=1&&i<=18) {
            continue;
        }
        UIView *view=[self.view viewWithTag:i];
        view.hidden=NO;
    }
    self.navigationBar.hidden = NO;
    self.clearBtn.hidden = NO;
    if (self.eraserBtn.selected == YES) {
        self.drawEraserBtn.hidden = NO;
    }else{
    self.drawBrushBtn.hidden = NO;
    }
}

//Drawview代理方法，当触摸移动滑板时调用，为了隐藏画笔或橡皮以为的所有控件
-(void)startDraw
{
    if (self.drawEraserBtn.selected == YES) {
        [self saveScreen:self.eraserBtn];
    }else{
        [self changeWidth:nil];
    }
}

@end
