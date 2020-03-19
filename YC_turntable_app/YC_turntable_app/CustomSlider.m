//
//  CustomSlider.m
//  YC_turntable_app
//
//  Created by Ben on 2020/3/19.
//  Copyright © 2020 Ben. All rights reserved.
//

#import "CustomSlider.h"

@implementation CustomSlider
    // 控制slider的宽和高，这个方法才是真正的改变slider滑道的高的
    - (CGRect)trackRectForBounds:(CGRect)bounds
    {
        NSLog(@"重写方法加载啦");
        return CGRectMake(8, 6, 285, 8);
    }

@end
