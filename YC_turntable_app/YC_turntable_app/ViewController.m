//
//  ViewController.m
//  YC_turntable_app
//
//  Created by Ben on 2020/3/14.
//  Copyright © 2020 Ben. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertController+TapGesAlertController.h"
#import "CustomSlider.h"
#import "DrawView.h"
#import "DrawColorPoint.h"


@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet DrawView *drawView;
@property (weak, nonatomic) IBOutlet DrawColorPoint *drawColorPoint;

#pragma mark 分段速度的角度值与速度的设定
@property(assign,nonatomic) NSInteger segmentAngleValue;
@property(assign,nonatomic) NSInteger segmentSpeedValue;

#pragma mark 倒计时的实现
@property (nonatomic, strong) dispatch_source_t timer;    //GCD定时器
@property(assign,nonatomic) NSInteger timePickerValue;
@property(assign,nonatomic) NSInteger anglePickerValue;

#pragma mark 速度点的颜色
@property (strong,nonatomic) UIColor *pointColor;

//#pragma mark 进度条背景
//@property (weak, nonatomic)  UIImageView *progressBG;

#pragma mark 弹窗

@property (weak, nonatomic) UIAlertController *alertController;
@property (strong,nonatomic) NSMutableArray *segmentPointColorArray;
@property (strong,nonatomic) NSMutableArray *segmentAngleValueArray;
@property (strong,nonatomic) NSMutableArray *segmentSpeedValueArray;
@property (strong,nonatomic) NSMutableArray *speedPointLabelArray;
@property (strong,nonatomic) NSMutableArray *speedPointButtonArray;
//存放弹窗里的button速度点


#pragma mark Scroll view的属性
@property (assign,nonatomic) int pointNumber;
@property (assign,nonatomic) int pointPlace;
@property (weak, nonatomic) IBOutlet UIScrollView *pointScroll;
@property (strong, nonatomic) UIScrollView *alertControllerPointScroll;

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
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *addSpeedPointButton;
@property (weak, nonatomic) IBOutlet UIButton *editPointWindowButton;


//@property (weak, nonatomic) IBOutlet UIProgressView *segmentSpeedProgress;
@property (weak, nonatomic) IBOutlet CustomSlider *fixSpeedSlider;

@property (weak, nonatomic) IBOutlet CustomSlider *segmentSpeedSlider;
@property (weak, nonatomic) NSString *speedValuel;
@property (weak, nonatomic) IBOutlet UILabel *speedValueLebel;
@end

@implementation ViewController

#pragma mark 速度点array
//一个标签对应一个button,每次点击之后同时创建,根据在不同的界面显示标签或者button
-(NSArray *)addSpeedPointArray{
    
    UIColor *pointColor=self.pointColor;
    UILabel *label=[UILabel new];
    label.text=
    [NSString stringWithFormat:@"%d",self.pointNumber];
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.frame=CGRectMake(self.pointPlace, 0, 40, 40);
    label.layer.cornerRadius=20.0;
    label.layer.backgroundColor= pointColor.CGColor;
    [self.speedPointLabelArray addObject:label];

    UIButton *button=[[UIButton alloc]init];
    [button setTitle:
     [NSString stringWithFormat:@"%d",self.pointNumber]
            forState:UIControlStateNormal];
    [button setTitleColor:
     [UIColor blackColor]
                 forState:UIControlStateNormal];
    button.titleLabel.textAlignment=NSTextAlignmentCenter;
    button.frame=CGRectMake(self.pointPlace+50, 0, 40, 40);
    button.backgroundColor=pointColor;
    button.layer.cornerRadius=20.0;
    
    
//    [self.speedPointDictionary setObject:
//    [NSNumber numberWithLong:self.segmentSpeedValue]
//                                 forKey:[NSNumber numberWithLong:self.segmentAngleValue]];
    [self.segmentAngleValueArray addObject:[NSNumber numberWithLong:self.segmentAngleValue]];
    [self.segmentSpeedValueArray addObject:[NSNumber numberWithLong:self.segmentSpeedValue]];
    [self.segmentPointColorArray addObject:pointColor];
    [self.speedPointButtonArray addObject:button];
    self.pointPlace=self.pointPlace+50;
    self.pointNumber++;
    //NSArray *arr=@[self.speedPointLabelArray,self.speedPointButtonArray];
    NSArray *arr=@[self.speedPointLabelArray,self.speedPointButtonArray,self.segmentAngleValueArray,self.segmentSpeedValueArray,self.segmentPointColorArray];
    return arr;
}

#pragma mark 主滑动界面增加速度点按钮的实现
- (IBAction)addSpeedPoint:(UIButton *)btn {
    UIAlertController *alert  =
    [UIAlertController alertControllerWithTitle:@"旋转速度"
                                        message:@"1-100"
                                 preferredStyle:UIAlertControllerStyleAlert];
    //2.1 确认按钮
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        self.segmentSpeedValue=[alert.textFields.firstObject.text floatValue];
        self.segmentAngleValue=self.segmentSpeedSlider.value;
        NSArray *arr =self.addSpeedPointArray;
        UILabel *label=[arr[0] objectAtIndex:self.pointNumber-2];
        self.drawView.arr=@[arr[2],arr[3]];
        self.drawColorPoint.arr=@[arr[2],arr[4]];
               //self.pointNumber++;
        self.pointScroll.contentSize=CGSizeMake(self.pointPlace, 0);
        [self.pointScroll addSubview:label];
        self.segmentSpeedValue=0;
    }];
    //2.2 取消按钮
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    //2.3 还可以添加文本框 通过 alert.textFields.firstObject 获得该文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入速度";
        textField.keyboardType=UIKeyboardTypePhonePad;
    }];
    [alert addAction:conform];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{
        [alert tapGesAlert];
    }];
}

#pragma mark 随机颜色懒加载
-(UIColor *)pointColor{
    CGFloat rc =arc4random()%255/255.0;
    CGFloat gc =arc4random()%255/255.0;
    CGFloat bc =arc4random()%255/255.0;
    while( rc==gc && rc==bc && gc==bc){
        rc =arc4random()%255/255.0;
    }
    _pointColor=[UIColor colorWithRed:rc green:gc blue:bc alpha:1];
    return _pointColor;
}

#pragma mark 弹窗界面的增加速度点按钮的实现
- (void)clickAddbtn:(UIButton *)btn {
    NSArray *arr =self.addSpeedPointArray;
    UIButton *speedButton =[arr[1] objectAtIndex:self.pointNumber-2];
    UILabel *label=[arr[0] objectAtIndex:self.pointNumber-2];
    self.pointScroll.contentSize=CGSizeMake(self.pointPlace, 0);
    [self.pointScroll addSubview:label];
    [self.alertController.view addSubview:speedButton];
}

#pragma mark 弹窗
- (IBAction)editPointWindow:(UIButton *)btn {
    self.alertController  =
    [UIAlertController alertControllerWithTitle:@"\n"
                                        message:@" \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIButton *adbtn=[[UIButton alloc]init];
      adbtn.frame = CGRectMake(10,10, 20, 20);
      [adbtn setImage:[UIImage imageNamed:@"s_add"]
                  forState:UIControlStateNormal];
      [adbtn addTarget:self action:@selector(clickAddbtn:)
           forControlEvents:UIControlEventTouchUpInside];
     // [self.alertController.view addSubview:self.alertControllerPointScroll];
      [self.alertController.view addSubview:adbtn];
    //
    //
    //-----------------------
    for (UIButton * speedButton in self.speedPointButtonArray) {
        [self.alertController.view addSubview:speedButton];

    }
    //---------
    //[self.alertController.view addSubview:self.alertControllerPointScroll];
    [self presentViewController:self.alertController animated:YES completion:^{
        [self.alertController tapGesAlert];
    }];
}

   

#pragma mark scrollView
////弹窗里的滚动界面
//-(UIScrollView *)alertControllerPointScroll{
//
//    _alertControllerPointScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,270,300)];
//    _alertControllerPointScroll.contentSize=
//    CGSizeMake(270 , 600);
//    _alertControllerPointScroll.backgroundColor=[UIColor redColor];
//    _alertControllerPointScroll.clipsToBounds=YES;//默认是yes,超出边框的会被裁减
//
//
//    return _alertControllerPointScroll;
//}

//app里的滚动界面
-(UIScrollView *)pointScroll{
    _pointScroll.contentSize=
    CGSizeMake(self.pointPlace, 0);//这个滚动的长度需要动态生成
//    _pointScroll.backgroundColor=[UIColor redColor];
    _pointScroll.clipsToBounds=YES;//默认是yes,超出边框的会被裁减
    return _pointScroll;
}

#pragma mark 旋转角度&时间的picker实现
//时间数据和角度数据
-(NSArray *)rotationAngleData{
    if(_rotationAngleData==nil){
        NSString *path=[[NSBundle mainBundle]
        pathForResource:@"angle.plist" ofType:nil];
        _rotationAngleData=[NSArray arrayWithContentsOfFile:path];
    }
        //NSLog(@"AAAA%@",_rotationAngleData);
    return _rotationAngleData;
}
-(NSArray *)rotationTimeData{
    if(_rotationTimeData==nil){
           NSString *path=[[NSBundle mainBundle]
           pathForResource:@"time.plist" ofType:nil];
           _rotationTimeData=[NSArray arrayWithContentsOfFile:path];
       }
     //   NSLog(@"time%@",_rotationTimeData);
       return _rotationTimeData;
    return _rotationTimeData;
}

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
    if (pickerView.tag == 5){
        NSString *anglePickerValue =self.rotationAngleData[row];
        anglePickerValue =[anglePickerValue componentsSeparatedByString:@"\u00b0"][0];
        self.anglePickerValue=[anglePickerValue intValue];
        NSLog(@"角度为%ld °",self.anglePickerValue);
       }else if(pickerView.tag == 6){
           NSString *timePickerValue =self.rotationTimeData[row];
           timePickerValue =[timePickerValue componentsSeparatedByString:@"s"][0];
           self.timePickerValue=[timePickerValue intValue];
           NSLog(@"时间为%ld s", self.timePickerValue);
       }
    float speed=self.anglePickerValue/self.timePickerValue;
    self.fixSpeedSlider.value=speed/7.19*0.01;
    self.speedValuel=
    [NSString stringWithFormat:@"%.2f%%",self.fixSpeedSlider.value*100];
    self.speedValueLebel.text=self.speedValuel;
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
       //NSLog(@"tag ==5");
        return self.rotationAngleData.count;
        
    }else if(pickerView.tag == 6){
       // NSLog(@"tag ==6");
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


//-(UIImageView *)progressBG{
//    _progressBG.bounds=CGRectMake(0, 0, 300, 300);
//    [_progressBG bringSubviewToFront:self.segmentSpeedProgress];
//    return _progressBG;
//}

#pragma mark 进度条
//-(UIProgressView *)segmentSpeedProgress{
//
//    _segmentSpeedProgress.bounds=CGRectMake(0, 0, 290, 0);
//    _segmentSpeedProgress.progressTintColor=  [UIColor colorWithRed:5/255.0 green: 132/255.0 blue:234/255.0 alpha:1];//设定progressView的显示颜色
//    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.9f);
//    _segmentSpeedProgress.transform = transform;//设定宽高
//    _segmentSpeedProgress.layer.backgroundColor=
//    [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1].CGColor;
//   _segmentSpeedProgress.layer.cornerRadius = 4.5;
//    _segmentSpeedProgress.layer.masksToBounds = YES;
//    _segmentSpeedProgress.progress = 0.0;
//    return _segmentSpeedProgress;
//}

#pragma mark 滑块背景颜色与圆角化实现
-(CustomSlider *)segmentSpeedSlider{
    _segmentSpeedSlider.minimumValue=0;
    _segmentSpeedSlider.maximumValue=360;
    _segmentSpeedSlider.bounds=CGRectMake(0, 0, 300, 20);

    _segmentSpeedSlider.layer.cornerRadius=10.0;
    _segmentSpeedSlider.layer.backgroundColor=
    [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1].CGColor;
    return _segmentSpeedSlider;
}

-(CustomSlider *)fixSpeedSlider{
    //_fixSpeedSlider=[[CustomSlider alloc]init];
   // [_fixSpeedSlider trackRectForBounds:CGRectMake(0, 0, 0, 0)];
    _fixSpeedSlider.bounds=CGRectMake(0, 0, 300, 20);
    _fixSpeedSlider.layer.cornerRadius=10.0;
    _fixSpeedSlider.layer.backgroundColor=
    [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1].CGColor;
    return _fixSpeedSlider;
}

#pragma mark 滑条的事件

- (IBAction)segmentSpeedSlider:(UISlider *)sender {
    //发送角度
}

- (IBAction)fixSpeedSlider:(CustomSlider *)sender {
    self.speedValuel=
     [NSString stringWithFormat:@"%.0f%%",self.fixSpeedSlider.value*100];
     self.speedValueLebel.text=self.speedValuel;
}


#pragma mark 速度百分比值label的圆角化与速度值的显示实现
-(UILabel *)speedLebel{
    
    _speedValueLebel.layer.cornerRadius=5.0;
    _speedValueLebel.layer.backgroundColor=
    [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1].CGColor;
    self.speedValuel=
    [NSString stringWithFormat:@"%.2f%%",self.fixSpeedSlider.value*100];
    _speedValueLebel.textColor=[UIColor whiteColor];
    _speedValueLebel.text=self.speedValuel;
    return _speedValueLebel;
}


#pragma mark 播放暂停实现
- (IBAction)playOrPause:(UIButton *)btn {
    if(btn.selected==NO){
        btn.selected=YES;
        if ( self.fixSpeedSlider.enabled==NO){
            [self createGCDTimer:self.timePickerValue];  //开启定时功能
        }
        
    }else{
        btn.selected=NO;
        if ( self.fixSpeedSlider.enabled==NO){
            dispatch_source_cancel(self.timer);  //reset定时功能
        }
        
        
    }
    
        
    
}

#pragma mark 开启定时器
- (void)createGCDTimer:(NSInteger)countdownTime{
    if(countdownTime==0){
        countdownTime=1;
    }
        __block NSInteger time = countdownTime; //倒计时时间
       dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
       self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
       
       dispatch_source_set_timer( self.timer,DISPATCH_TIME_NOW,1.0*NSEC_PER_SEC, 0); //每秒执行
       
       dispatch_source_set_event_handler( self.timer, ^{
           
           if(time <= 0){ //倒计时结束，关闭
               
               dispatch_source_cancel( self.timer);
               
               dispatch_async(dispatch_get_main_queue(), ^{
                   
                  self.playOrPauseButton.selected=NO;
               });
               
           }else{

               int seconds = time % 60;
               dispatch_async(dispatch_get_main_queue(), ^{
                   NSLog(@"%d",seconds);
                   
                   float progressValue=(1.0/countdownTime)*(countdownTime-time);
                   
                   //self.segmentSpeedProgress.progress = progressValue;
                 

               });
                    
               time--;
           }
       });
                    
       dispatch_resume( self.timer);

}

#pragma mark 旋转方向的设置实现
/**
旋转方向的默认设置,懒加载
*/
-(UIButton *)clockwiseButton{
    // NSLog(@"速度模式按钮加载中");
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
     //NSLog(@"速度模式按钮加载中");
    _fixedSpeedButton.selected=YES;
    self.segmentSpeedSlider.enabled=NO;
    self.addSpeedPointButton.enabled=NO;
    self.editPointWindowButton.enabled=NO;
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
        self.addSpeedPointButton.enabled=NO;
        self.editPointWindowButton.enabled=NO;
    }else if (button.tag==2){
        button.selected=YES;
        UIButton *but=(UIButton*)[self.view viewWithTag:1];
        but.selected=NO;
        self.fixSpeedSlider.enabled=NO;
        self.segmentSpeedSlider.enabled=YES;
        self.addSpeedPointButton.enabled=YES;
        self.editPointWindowButton.enabled=YES;
        
    }
}



#pragma mark 模式开关切换实现
/**
 * 无限模式开关懒加载
 */
- (UISwitch *)modeSwitch {
   //NSLog(@"模式切换按钮加载中");
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
    self.speedPointLabelArray=[NSMutableArray array];
    self.speedPointButtonArray=[NSMutableArray array];
    self.segmentPointColorArray=[NSMutableArray array];
    self.segmentAngleValueArray=[NSMutableArray array];
    self.segmentSpeedValueArray=[NSMutableArray array];
    self.pointNumber=1;
    self.pointPlace=0;
    self.anglePickerValue=10;
    self.timePickerValue=1;
    self.segmentSpeedValue=0;
    self.segmentSpeedSlider.value=0;
    [self.view addSubview:self.modeSwitch];
    [self.view addSubview:self.fixedSpeedButton];
    [self.view addSubview:self.clockwiseButton];
    [self.view addSubview:self.segmentSpeedSlider ];
    [self.view addSubview:self.fixSpeedSlider];
    [self.view addSubview:self.speedLebel];
    [self.view addSubview:self.rotationAnglePicker];
    [self.view addSubview:self.rotationTimePicker];
    [self.view addSubview:self.pointScroll];
   // [self.view addSubview:self.segmentSpeedProgress];
    
//------------------
    
    

}


@end
