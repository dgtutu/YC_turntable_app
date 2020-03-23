 //
//  DrawView.m
//  YC_turntable_app
//
//  Created by Ben on 2020/3/19.
//  Copyright © 2020 Ben. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

-(void) setArr:(NSArray *)arr{
    _arr=arr;
//    [self drawRect:self.bounds];
    [self setNeedsDisplay];
}
//-(void)setSAngelValue:(CGFloat)SAngelValue{
//    _SAngelValue =SAngelValue;
//    [self drawRect:self.bounds];
//}
//
//-(void)setSSpeedValue:(CGFloat)SSpeedValue{
//    _SSpeedValue=SSpeedValue;
//    [self drawRect:self.bounds];
//}


/**
专门用来绘图:*/
- (void)drawRect:(CGRect)rect {
    [self drawMainLine];
    [self drawFoldLine];
}

-(void)drawFoldLine{
   
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSMutableArray *naM=self.arr[0];
    NSMutableArray *nsM=self.arr[1];
    NSNumber *Na=[naM objectAtIndex:0];
    double da=Na.doubleValue/360*269;
    NSNumber *Ns=[nsM objectAtIndex:0];
    double ds=Ns.doubleValue/2*-1+65;
    float tempA=da;
    float tempS=ds;
    
    for (int i=0; i<[nsM count]; i++) {
        
        NSNumber *Na=[naM objectAtIndex:i];
        double da=Na.doubleValue/360*269;
        NSNumber *Ns=[nsM objectAtIndex:i];
        double ds=Ns.doubleValue/2*-1+65;
        
        NSString *string =[NSString stringWithFormat:@"%.0f", Ns.doubleValue];
        [path moveToPoint:CGPointMake(tempA,tempS)];
        [path addLineToPoint:CGPointMake(da,ds)];
        [string drawInRect:CGRectMake(da,ds-16,300, 30) withFont:[UIFont systemFontOfSize:13]
         ];
        
        tempA=da;
        tempS=ds;
        NSLog(@"当前循环为第%d次,nsm大小为%ld,temp的速度为:%f,temp的角度为:%f",i,[nsM count],ds,da);
    }
    [[UIColor colorWithRed:48/255.0 green:49/255.0 blue:50/255.0 alpha:255/255.0] set];
    [path setLineWidth:2];
   
    [path stroke];
}

-(void)drawMainLine{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0,15)];
    [path addLineToPoint:CGPointMake(269,15)];
    [path moveToPoint:CGPointMake(0,40)];
    [path addLineToPoint:CGPointMake(269,40)];
    [[UIColor colorWithRed:48/255.0 green:49/255.0 blue:50/255.0 alpha:255/255.0] set];
    [path setLineWidth:2];
    [path stroke];
    

    
    
    
    
//    //1获取上下文
//       CGContextRef ctx= UIGraphicsGetCurrentContext();
//       //2绘制路径
//       UIBezierPath *path = [UIBezierPath bezierPath];
//
//       //3设置起点
//       [path moveToPoint:CGPointMake(0,15)];
//       //4添加一根线到终点
//       [path addLineToPoint:CGPointMake(269,15)];
//       //----------画第二根线-------------\\
//           //设置起点
//        [path moveToPoint:CGPointMake(0,40)];
//           //添加一根线到终点
//        [path addLineToPoint:CGPointMake(269,40)];
       
       //-------------------------------//
    
        //----------画曲线-------------\\
             //设置起点
       //   [path moveToPoint:CGPointMake(0,40)];
             //添加一根线到终点
     //     [path addQuadCurveToPoint:<#(CGPoint)#> controlPoint:<#(CGPoint)#>];
         
         //-------------------------------//
    
    
//
//
//       //上下文的状态
//       //设置线宽
//       CGContextSetLineWidth(ctx, 2);
//       //设线的链接样式
//       CGContextSetLineJoin(ctx,kCGLineJoinRound);
//       //设置线的顶端的圆角
//       CGContextSetLineCap(ctx,kCGLineCapRound);
//       //设置颜色
//        //[[UIColor colorWithRed:48/255.0 green:49/255.0 blue:50/255.0 alpha:255/255.0]setStroke];
//       [[UIColor colorWithRed:48/255.0 green:49/255.0 blue:50/255.0 alpha:255/255.0]set];
//       //5将绘制的路径添加到上下文
//       //UIBezierPath:UIKIt CGpathRef:CoreGraphics
//       CGContextAddPath(ctx, path.CGPath);
//       //6把上下文的内容显示到View 渲染到view 的layer (stroke fill)
//       CGContextStrokePath(ctx);
    
}





@end
