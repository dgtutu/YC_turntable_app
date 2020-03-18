//
//  UIAlertController+TapGesAlertController.m
//  YC_turntable_app
//
//  Created by Ben on 2020/3/18.
//  Copyright © 2020 Ben. All rights reserved.
//

#import "UIAlertController+TapGesAlertController.h"



@implementation UIAlertController (TapGesAlertController)
- (void)tapGesAlert{
    NSLog(@"点击空白处");
    NSArray * arrayViews = [UIApplication sharedApplication].windows[0].subviews;
    //NSLog(@"%@",arrayViews);
    //NSArray * arrayViews = [UIApplication sharedApplication].keyWindow.subviews;
     UIView * backToMainView = [arrayViews.lastObject subviews][0];
        backToMainView.userInteractionEnabled = YES;
        UITapGestureRecognizer * backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap)];
        [backToMainView addGestureRecognizer:backTap];
    }

- (void)Tap {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
@end
