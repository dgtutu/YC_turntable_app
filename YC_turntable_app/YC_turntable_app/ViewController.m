//
//  ViewController.m
//  YC_turntable_app
//
//  Created by Ben on 2020/3/14.
//  Copyright © 2020 Ben. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//无限模式开关
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;

//旋转速度模式的旋转
@property (weak, nonatomic) IBOutlet UIButton *speedModeButton1;
@property (weak, nonatomic) IBOutlet UIButton *speedModeButton2;
@end


@implementation ViewController
#pragma mark radio单选按钮和状态的设置
/**
 单选按钮和状态的设置,懒加载
 */

-(UIButton*)speedModeButton1{
     NSLog(@"速度模式按钮加载中");
    //UIButton *_speedModeButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    [_speedModeButton1 setTitle:@"傻逼" forState:UIControlStateNormal];
    [_speedModeButton1 setTitle:@"智障" forState:UIControlStateHighlighted];
    //test git
    return _speedModeButton1;
}

-(UIButton*)speedModeButton2{
    return _speedModeButton2;
}



#pragma mark 模式开关切换
/**
 * 开关切换事件监听回调方法
 */
//- (void) modeSwitchChange:(UISwitch*)sw {
//    if(sw.on == YES) {
//        NSLog(@"开关切换为开");
//    } else if(sw.on == NO) {
//        NSLog(@"开关切换为关");
//    }
//}


/**
 * 无限模式开关懒加载
 */
- (UISwitch *)modeSwitch {
    NSLog(@"模式切换按钮加载中");
    [_modeSwitch setOnTintColor: [UIColor blueColor]];
    [_modeSwitch setTintColor:[UIColor grayColor]];
    _modeSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    //设置开关大小
    return _modeSwitch;
}

- (IBAction)modeSwitchChange:(UISwitch *)sw {
    if(sw.on == YES) {
        NSLog(@"开关切换为开");
    } else if(sw.on == NO) {
        NSLog(@"开关切换为关");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"0000");
    [self.view addSubview:self.modeSwitch];
    [self.view addSubview:self.speedModeButton1];
//  [self.modeSwitchaddTarget:self action:@selector(modeSwitchChange:) forControlEvents:UIControlEventValueChanged];
}


@end
