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
@property (weak, nonatomic) IBOutlet UIButton *fixedSpeedButton;
@property (weak, nonatomic) IBOutlet UIButton *segmentSpeedButton;
@property (weak, nonatomic) IBOutlet UIButton *clockwiseButton;
@property (weak, nonatomic) IBOutlet UIButton *counterClockwiseButton;


@end
@implementation ViewController
#pragma mark 下拉标签的实现
/**
旋转方向的默认设置,懒加载
*/



#pragma mark 旋转方向的设置
/**
旋转方向的默认设置,懒加载
*/
-(UIButton *)clockwiseButton{
     NSLog(@"速度模式按钮加载中");
    _clockwiseButton.selected=YES;
    return _clockwiseButton;
}

/**
单选实现
*/
- (IBAction)rotationMode:(UIButton *)button {
    if(button.tag==3){
        button.selected=YES;
        UIButton *but=(UIButton*)[self.view viewWithTag:4];
        but.selected=NO;
    }else if (button.tag==4){
        button.selected=YES;
        UIButton *but=(UIButton*)[self.view viewWithTag:3];
        but.selected=NO;
    }
}




#pragma mark 旋转速度模式的设置
/**
 单选按钮和状态的默认设置,懒加载
 */
-(UIButton *)fixedSpeedButton{
     NSLog(@"速度模式按钮加载中");
    _fixedSpeedButton.selected=YES;
    return _fixedSpeedButton;
}

/**
单选实现
*/
- (IBAction)speedMode:(UIButton *)button {
    if(button.tag==1){
        button.selected=YES;
        UIButton *but=(UIButton*)[self.view viewWithTag:2];
        but.selected=NO;
    }else if (button.tag==2){
        button.selected=YES;
        UIButton *but=(UIButton*)[self.view viewWithTag:1];
        but.selected=NO;
    }
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
    [self.view addSubview:self.fixedSpeedButton];
    [self.view addSubview:self.clockwiseButton];
//  [self.modeSwitchaddTarget:self action:@selector(modeSwitchChange:) forControlEvents:UIControlEventValueChanged];
}


@end
