//
//  DrawColorPoint.m
//  YC_turntable_app
//
//  Created by Ben on 2020/3/23.
//  Copyright © 2020 Ben. All rights reserved.
//

#import "DrawColorPoint.h"

@implementation DrawColorPoint


-(void) setArr:(NSArray *)arr{
    
    _arr=arr;
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
    [self drawColor];
}

-(void)drawColor{
    
    NSMutableArray *naM=self.arr[0];
    NSMutableArray *ncM=self.arr[1];
    for (int i=0; i<[naM count]; i++) {
        
        NSNumber *Na=[naM objectAtIndex:i];
        double da=Na.doubleValue/360*269;
        UIColor *color=[ncM objectAtIndex:i];
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(da, 5, 6, 6)];
        [color set];
        [path fill];
        
       // [path setLineWidth:5];
        [path stroke];
    }
   
    
}

@end
