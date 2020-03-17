//
//  ViewController.m
//  YC_turntable_app
//
//  Created by Ben on 2020/3/14.
//  Copyright © 2020 Ben. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

#pragma mark Scroll view的属性
@property (assign,nonatomic) int pointNumber;
@property (assign,nonatomic) int pointPlace;
@property (weak, nonatomic) IBOutlet UIScrollView *pointScroll;

#pragma mark picker的属性
//旋转角度&时间的picker
@property (weak, nonatomic) IBOutlet UIPickerView *rotationAnglePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *rotationTimePicker;
//picker存放的数据
@property (strong,nonatomic) NSArray *rotationAngleData;
@property (strong,nonatomic) NSArray *rotationTimeData;

#pragma mark 开关的属性
//无限模式开关
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;

#pragma mark 按钮和滑条
//旋转速度模式的旋转
@property (weak, nonatomic) IBOutlet UIButton *fixedSpeedButton;
@property (weak, nonatomic) IBOutlet UIButton *segmentSpeedButton;
@property (weak, nonatomic) IBOutlet UIButton *clockwiseButton;
@property (weak, nonatomic) IBOutlet UIButton *counterClockwiseButton;
@property (weak, nonatomic) IBOutlet UISlider *fixSpeedSlider;
@property (weak, nonatomic) IBOutlet UISlider *segmentSpeedSlider;
@property (weak,nonatomic) NSString *speedValuel;
@property (weak, nonatomic) IBOutlet UILabel *speedValueLebel;
@end
@implementation ViewController
#pragma mark 弹窗

- (IBAction)editPointWindow:(UIButton *)btn {
    
}

#pragma mark 增加滚动界面的速度点
- (IBAction)addSpeedPoint:(UIButton *)btn {
    NSLog(@"cnmmmmm");
    UILabel *label=[UILabel new];
    NSLog(@"%d",self.pointNumber);
    label.text=[NSString stringWithFormat:@"%d",self.pointNumber++];
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentCenter;
    
    label.frame=CGRectMake(self.pointPlace, 0, 40, 40);
    self.pointPlace=self.pointPlace+50;
    self.pointScroll.contentSize=CGSizeMake(self.pointPlace, 0);
    label.layer.cornerRadius=20.0;
    CGFloat rc =arc4random()%255/255.0;
    CGFloat gc =arc4random()%255/255.0;
    CGFloat bc =arc4random()%255/255.0;
    while( rc==gc && rc==bc && gc==bc){
        rc =arc4random()%255/255.0;
        gc =arc4random()%255/255.0;
        bc =arc4random()%255/255.0;
    }
    label.layer.backgroundColor=
    [UIColor colorWithRed:rc
                    green:gc
                     blue:bc
                    alpha:1].CGColor;
    
    [self.pointScroll addSubview:label];
        
        
}

#pragma mark scrollView
-(UIScrollView *)pointScroll{
//    UIView *redView =[[UIView alloc]init];
//    redView.backgroundColor=[UIColor redColor];
//    redView.frame =CGRectMake(0, 0, 50, 50);
//    [_pointScroll addSubview:redView];
    _pointScroll.contentSize=CGSizeMake(self.pointPlace, 0);//这个滚动的长度需要动态生成
    _pointScroll.clipsToBounds=YES;//默认是yes,超出边框的会被裁减
  
    return _pointScroll;
}



#pragma mark 旋转角度&时间的picker实现

//时间数据和角度数据
-(NSArray *)rotationAngleData{
//    NSMutableArray *arrM = [NSMutableArray array];
//    for (int i=1; i<=3; i++) {
//        NSNumber *nn=[NSNumber numberWithInt:i*10];
//        [arrM addObject:nn];
//    }
//   // NSLog(@"%@",arrM);
//    _rotationAngleData=[NSArray arrayWithArray:arrM];
//    arrM=nil;
//
    
    if(_rotationAngleData==nil){
        NSString *path=[[NSBundle mainBundle]
        pathForResource:@"angle.plist" ofType:nil];
        _rotationAngleData=[NSArray arrayWithContentsOfFile:path];
    }
        //NSLog(@"AAAA%@",_rotationAngleData);
    return _rotationAngleData;
}

-(NSArray *)rotationTimeData{
//    NSMutableArray *arrM = [NSMutableArray array];
//    for (int i=1; i<=10; i++) {
//        NSNumber *nn=[NSNumber numberWithInt:i];
//        [arrM addObject:nn];
//    }
//    _rotationTimeData=[NSArray arrayWithArray:arrM];
//    arrM=nil;
    if(_rotationTimeData==nil){
           NSString *path=[[NSBundle mainBundle]
           pathForResource:@"time.plist" ofType:nil];
           _rotationTimeData=[NSArray arrayWithContentsOfFile:path];
       }
     //   NSLog(@"time%@",_rotationTimeData);
       return _rotationTimeData;
    return _rotationTimeData;
}

/*
//每一列的宽度
- (CGFloat)
pickerView:(UIPickerView *)
pickerView widthForComponent:(NSInteger)
component API_UNAVAILABLE(tvos){
    
}

//每一行展示什么样的视图
- (UIView *)
pickerView:(UIPickerView *)
pickerView viewForRow:(NSInteger)
row forComponent:(NSInteger)
component reusingView:(nullable UIView *)
view API_UNAVAILABLE(tvos){}

//每行展示的内容
- (nullable NSString *)
pickerView:(UIPickerView *)pickerView
titleForRow :(NSInteger)row
forComponent :(NSInteger)component API_UNAVAILABLE(tvos){
    if (pickerView.tag == 5){
        return self.rotationAngleData[row];
    }else if(pickerView.tag == 6){
       return self.rotationTimeData[row];
        
    }
    return 0;
}
**/

// 每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView
rowHeightForComponent:(NSInteger)component API_UNAVAILABLE(tvos){
    return 30;
}

//每行展示的内容,带属性的字符串(颜色,大小,阴影,描边)
- (nullable NSAttributedString *)
pickerView:(UIPickerView *)pickerView
attributedTitleForRow:(NSInteger)row
forComponent:(NSInteger)component
API_AVAILABLE(ios(6.0))
API_UNAVAILABLE(tvos){
    NSDictionary * textProperty =
  @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    if (pickerView.tag == 5){
        NSAttributedString *NSA =
        [[NSAttributedString alloc]
         initWithString:self.rotationAngleData[row]
         attributes:textProperty];
           return NSA;
       }else if(pickerView.tag == 6){
           NSAttributedString *NSA =
           [[NSAttributedString alloc]
            initWithString:self.rotationTimeData[row]
            attributes:textProperty];
              return NSA;
        
           
       }
       return 0;
}

//当前展示多少行多少列
- (void)pickerView:(UIPickerView *)pickerView didSelectRow
                  :(NSInteger)row inComponent
                  :(NSInteger)component API_UNAVAILABLE(tvos){
    NSString *string =[NSString new];
  
    if (pickerView.tag == 5){
        string =self.rotationAngleData[row];
          NSLog(@"当前angle: %@",string);
       }else if(pickerView.tag == 6){
           string =self.rotationTimeData[row];
             NSLog(@"当前time: %@",string);
       }
}

// 返回总共有多少列要显示
- (NSInteger)numberOfComponentsInPickerView
:(UIPickerView *)pickerView{
    return 1;
}

// 返回每一列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent
                       :(NSInteger)component{
    if (pickerView.tag == 5){
       NSLog(@"tag ==5");
        return self.rotationAngleData.count;
        
    }else if(pickerView.tag == 6){
        NSLog(@"tag ==6");
       return self.rotationTimeData.count;
        
    }
    return 0;
    
}

-(UIPickerView *)rotationAnglePicker{
    _rotationAnglePicker.dataSource=self;
    _rotationAnglePicker.delegate=self;
    return _rotationAnglePicker;
}

-(UIPickerView *)rotationTimePicker{
    _rotationTimePicker.dataSource=self;
    _rotationTimePicker.delegate=self;
    return _rotationTimePicker;
}

#pragma mark 滑块背景颜色与圆角化实现
-(UISlider *)segmentSpeedSlider{
    _segmentSpeedSlider.bounds=CGRectMake(0, 0, 300, 23);

    _segmentSpeedSlider.layer.cornerRadius=10.0;
    _segmentSpeedSlider.layer.backgroundColor=
    [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1].CGColor;
    return _segmentSpeedSlider;
}
-(UISlider *)fixSpeedSlider{
    _fixSpeedSlider.bounds=CGRectMake(0, 0, 300, 23);
    _fixSpeedSlider.layer.cornerRadius=10.0;
    _fixSpeedSlider.layer.backgroundColor=
    [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1].CGColor;
    return _fixSpeedSlider;
}

#pragma mark 速度标签的圆角化与速度值的显示实现
-(UILabel *)speedLebel{
    _speedValueLebel.layer.cornerRadius=5.0;
    _speedValueLebel.layer.backgroundColor=
    [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1].CGColor;
    self.speedValuel=
    [NSString stringWithFormat:@"%.0f%%",self.fixSpeedSlider.value*100];
    _speedValueLebel.textColor=[UIColor whiteColor];
    _speedValueLebel.text=self.speedValuel;
    return _speedValueLebel;
}

#pragma mark 播放暂停实现
- (IBAction)playOrPause:(UIButton *)btn {
    if(btn.selected==YES){
        btn.selected=NO;
    }else{
        btn.selected=YES;
    }
}

#pragma mark 下拉标签的实现
/**
旋转方向的默认设置,懒加载
*/

#pragma mark 旋转方向的设置实现
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

#pragma mark 旋转速度模式的设置实现
/**
 单选按钮和状态的默认设置,懒加载
 */
-(UIButton *)fixedSpeedButton{
     NSLog(@"速度模式按钮加载中");
    _fixedSpeedButton.selected=YES;
    self.segmentSpeedSlider.enabled=NO;
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
         self.fixSpeedSlider.enabled=YES;
         self.segmentSpeedSlider.enabled=NO;
    }else if (button.tag==2){
        button.selected=YES;
        UIButton *but=(UIButton*)[self.view viewWithTag:1];
        but.selected=NO;
        self.fixSpeedSlider.enabled=NO;
        self.segmentSpeedSlider.enabled=YES;
        
    }
}

#pragma mark 滑条的实时显示
- (IBAction)segmentSpeedSlider:(UISlider *)sender {
}

- (IBAction)fixSpeedSlider:(UISlider *)sender {
    self.speedValuel=
    [NSString stringWithFormat:@"%.0f%%",self.fixSpeedSlider.value*100];
    self.speedValueLebel.text=self.speedValuel;
}


#pragma mark 模式开关切换实现
/**
 * 无限模式开关懒加载
 */
- (UISwitch *)modeSwitch {
    NSLog(@"模式切换按钮加载中");
    [_modeSwitch setOnTintColor:
     [UIColor colorWithRed:0/255.0 green:121/255.0 blue:221/255.0 alpha:1]];
    [_modeSwitch setTintColor:[UIColor grayColor]];
    _modeSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    //设置开关大小
    return _modeSwitch;
}
//无限模式
- (IBAction)modeSwitchChange:(UISwitch *)sw {
    if(sw.on == YES) {
        NSLog(@"无限模式切换为开");
    } else if(sw.on == NO) {
        NSLog(@"无限模式为关");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"0000");
    self.pointNumber=1;
    self.pointPlace=0;
    [self.view addSubview:self.modeSwitch];
    [self.view addSubview:self.fixedSpeedButton];
    [self.view addSubview:self.clockwiseButton];
    [self.view addSubview:self.segmentSpeedSlider ];
    [self.view addSubview:self.fixSpeedSlider];
    [self.view addSubview:self.speedLebel];
    [self.view addSubview:self.rotationAnglePicker];
    [self.view addSubview:self.rotationTimePicker];
    [self.view addSubview:self.pointScroll];
//  [self.modeSwitchaddTarget:self action:@selector(modeSwitchChange:) forControlEvents:UIControlEventValueChanged];
}


@end
