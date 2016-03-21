//
//  GZPDrawView.m
//  YunYi
//
//  Created by liuyang on 15/8/6.
//  Copyright (c) 2015年 北京日立北工大信息系统有限公司. All rights reserved.
//

#import "GZPDrawView.h"
#import "GZPDrawController.h"
#import "UIColor+changeRGBLY.h"
@implementation GZPDrawView
{
    //保存线条颜色
    NSMutableArray * _colorArray;
    //保存被移除的线条颜色
    NSMutableArray * _deleColorArray;
    //每次触摸结束前经过的点，形成线的点数组
    NSMutableArray * _pointArray;
    //每次触摸结束后的线数组
    NSMutableArray * _lineArray;
    //删除的线的数组，方便重做时取出来
    NSMutableArray * _deleArray;
    //删除线条时删除的线条宽度储存的数组
    NSMutableArray * _deleWidthArray;
    //正常存储的线条宽度的数组
    NSMutableArray * _WidthArray;
    //确定颜色的值，将颜色计数的值存到数组里默认为0，即为绿色
    NSInteger _colorCount;
    //确定宽度的值，将宽度计数的值存到数组里默认为0，即为2
    NSInteger _widthCount;
    //保存颜色的数组
    NSMutableArray * _colors;
}
//线条宽度的数组
static float lineWidthArray[5]={3.0,6.0,9.0,12.0,12.0};

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化颜色数组，将用到的颜色存储到数组里
        _colors=[[NSMutableArray alloc]initWithObjects:[UIColor blackColor],[UIColor redColor],[UIColor colorWithHexString:@"#ea77f4"],[UIColor colorWithHexString:@"#f7f88d"],[UIColor colorWithHexString:@"#000cff"],[UIColor colorWithHexString:@"#00eaff"],[UIColor colorWithHexString:@"#30d71e"],[UIColor colorWithHexString:@"#ff7d2f"],[UIColor colorWithHexString:@"#8400ff"],[UIColor whiteColor],[UIColor whiteColor],nil];
        _WidthArray=[[NSMutableArray alloc]init];
        _deleWidthArray=[[NSMutableArray alloc]init];
        _pointArray=[[NSMutableArray alloc]init];
        _lineArray=[[NSMutableArray alloc]init];
        _deleArray=[[NSMutableArray alloc]init];
        _colorArray=[[NSMutableArray alloc]init];
        _deleColorArray=[[NSMutableArray alloc]init];
        //颜色和宽度默认都取当前数组第0位为默认值
        _colorCount=0;
        _widthCount=1;
        // Initialization code
    }
    return self;
}

//给界面按钮操作时获取tag值作为width的计数。来确定宽度，颜色同理
-(void)setlineWidth:(NSInteger)width{
    _widthCount=width;
}
-(void)setLineColor:(NSInteger)color{
    _colorCount=color;
}

//uiview默认的drawRect方法，覆盖重写，可在界面上重绘，并将AViewController.xib的文件设置为自定义的MyView
- (void)drawRect:(CGRect)rect
{
    //获取当前上下文，
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 10.0f);
    //线条拐角样式，设置为平滑
    CGContextSetLineJoin(context,kCGLineJoinRound);
    //线条开始样式，设置为平滑
    CGContextSetLineCap(context,kCGLineJoinRound);
    //查看lineArray数组里是否有线条，有就将之前画的重绘，没有只画当前线条
    if ([_lineArray count]>0) {
        for (int i=0; i<[_lineArray count]; i++) {
            NSArray * array=[NSArray
                             arrayWithArray:[_lineArray objectAtIndex:i]];
            if ([array count]>0)
            {
                CGContextBeginPath(context);
                CGPoint myStartPoint=CGPointFromString([array objectAtIndex:0]);
                CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
                
                for (int j=0; j<[array count]-1; j++)
                {
                    CGPoint myEndPoint=CGPointFromString([array objectAtIndex:j+1]);
                    //--------------------------------------------------------
                    CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
                }
                //获取colorArray数组里的要绘制线条的颜色
                NSNumber *num=[_colorArray objectAtIndex:i];
                int count=[num intValue];
                UIColor *lineColor=[_colors objectAtIndex:count];
                //获取WidthArray数组里的要绘制线条的宽度
                NSNumber *wid=[_WidthArray objectAtIndex:i];
                int widthc=[wid intValue];
                float width=lineWidthArray[widthc];
                //设置线条的颜色，要取uicolor的CGColor
                CGContextSetStrokeColorWithColor(context,[lineColor CGColor]);
                //-------------------------------------------------------
                //设置线条宽度
                CGContextSetLineWidth(context, width);
                //保存自己画的
                CGContextStrokePath(context);
            }
        }
    }
    //画当前的线
    if ([_pointArray count]>0)
    {
        CGContextBeginPath(context);
        CGPoint myStartPoint=CGPointFromString([_pointArray objectAtIndex:0]);
        CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
        
        for (int j=0; j<[_pointArray count]-1; j++)
        {
            CGPoint myEndPoint=CGPointFromString([_pointArray objectAtIndex:j+1]);
            //--------------------------------------------------------
            CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
        }
        UIColor *lineColor=[_colors objectAtIndex:_colorCount];
        float width=lineWidthArray[_widthCount];
        CGContextSetStrokeColorWithColor(context,[lineColor CGColor]);
        //-------------------------------------------------------
        CGContextSetLineWidth(context, width);
        CGContextStrokePath(context);
    }
    
}

//在touch结束前将获取到的点，放到pointArray里
-(void)addPA:(CGPoint)nPoint{
    NSString *sPoint=NSStringFromCGPoint(nPoint);
    [_pointArray addObject:sPoint];
}
//在touchend时，将已经绘制的线条的颜色，宽度，线条线路保存到数组里
-(void)addLA{
    NSNumber *wid=[[NSNumber alloc]initWithInt:_widthCount];
    NSNumber *num=[[NSNumber alloc]initWithInt:_colorCount];
    [_colorArray addObject:num];
    [_WidthArray addObject:wid];
    NSArray *array=[NSArray arrayWithArray:_pointArray];
    [_lineArray addObject:array];
    _pointArray=[[NSMutableArray alloc]init];
}

#pragma mark -
//手指开始触屏开始
static CGPoint MyBeganpoint;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}
//手指移动时候发出
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_hhhidden) {
        if ([self.delegate respondsToSelector:@selector(startDraw)]) {
            [self.delegate startDraw];
        }
    }
//    GZPDrawController * drawController = [[GZPDrawController alloc]init];
//    drawController.drawFootView.hidden = YES;
//    drawController.drawEraserBtn.hidden = YES;
    
    UITouch* touch=[touches anyObject];
    MyBeganpoint=[touch locationInView:self];
    NSString *sPoint=NSStringFromCGPoint(MyBeganpoint);
    [_pointArray addObject:sPoint];
    [self setNeedsDisplay];
}
//当手指离开屏幕时候
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self addLA];

    NSLog(@"touches end");
}
//电话呼入等事件取消时候发出
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches Canelled");
}
//撤销，将当前最后一条信息移动到删除数组里，方便恢复时调用
-(void)revocation{
    if ([_lineArray count]) {
        [_deleArray addObject:[_lineArray lastObject]];
        [_lineArray removeLastObject];
    }
    if ([_colorArray count]) {
        [_deleColorArray addObject:[_colorArray lastObject]];
        [_colorArray removeLastObject];
    }
    if ([_WidthArray count]) {
        [_deleWidthArray addObject:[_WidthArray lastObject]];
        [_WidthArray removeLastObject];
    }
    //界面重绘方法
    [self setNeedsDisplay];
}
//将删除线条数组里的信息，移动到当前数组，在主界面重绘
-(void)refrom{
    if ([_deleArray count]) {
        [_lineArray addObject:[_deleArray lastObject]];
        [_deleArray removeLastObject];
    }
    if ([_deleColorArray count]) {
        [_colorArray addObject:[_deleColorArray lastObject]];
        [_deleColorArray removeLastObject];
    }
    if ([_deleWidthArray count]) {
        [_WidthArray addObject:[_deleWidthArray lastObject]];
        [_deleWidthArray removeLastObject];
    }
    [self setNeedsDisplay];
    
}
-(void)clear{
    //移除所有信息并重绘
    [_deleArray removeAllObjects];
    [_deleColorArray removeAllObjects];
   // _colorCount=0;
    [_colorArray removeAllObjects];
    [_lineArray removeAllObjects];
    [_pointArray removeAllObjects];
    [_deleWidthArray removeAllObjects];
//    _widthCount=0;
    [_WidthArray removeAllObjects];
    [self setNeedsDisplay];
}

@end
