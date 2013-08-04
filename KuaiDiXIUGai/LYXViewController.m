//
//  LYXViewController.m
//  KuaiDiXIUGai
//
//  Created by 李永兴 on 13-6-20.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import "LYXViewController.h"

#import "check.h"

#import <QuartzCore/QuartzCore.h>

#import "ASIHTTPRequest.h"

#import "LYXAppDelegate.h"

#import "detailedView.h"

#define Width self.view.frame.size.width

#define Height self.view.frame.size.height



@interface LYXViewController ()<UITextFieldDelegate>


@end

@implementation LYXViewController

@synthesize backgroundView;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.gongSi.text = [check shareDataModel].Names;
    
    self.NumberLable.text = [check shareDataModel].numbers;

  }
- (void)viewDidLoad
{
    [super viewDidLoad];
    
           //将文件转换成字符串
 
    NSString* arr=[[NSBundle mainBundle] pathForResource:@"gongSiCanShuList" ofType:@"plist"];
    
    //将字符串(即文件的所有关键字和值)存放在字典中
    
    NSDictionary* dic1=[NSDictionary dictionaryWithContentsOfFile:arr];
    
    //初始化字典并将关键字取出，放入到小字典中
    
    self.dic = [[NSDictionary alloc] init];
    
    self.dic=[dic1 objectForKey:@"快递公司"];
    
    NSArray * arr1 = [NSArray new];
    
    arr1 = [self.dic allKeys];
    
#pragma mark--<---------------获得Plist文件中的数据-------------------------->
    
    //将plist文件转换成字符串
    NSString* string = [[NSBundle mainBundle] pathForResource:@"gongSiNumberList" ofType:@"plist"];
    
    //将字符串存放在字典中
    
    NSDictionary* dictionary=[NSDictionary dictionaryWithContentsOfFile:string];
    
    //将字典中的关键字取出来
    
    NSDictionary *dict2 = [dictionary objectForKey:@"快递公司"];
    
    //将所有关键字（allkeys）存放在数组中
    
    NSArray * array2 =[NSArray new];
    
    array2=[dict2 allKeys];
  
    self.array = [NSMutableArray new];
    
    self.mutableString  = [[NSMutableString alloc]init];
    
#pragma mark--<-----------------------创建一个导航栏---------------------------------->
    
    
    [self.navigationController.navigationBar  setTintColor:[UIColor grayColor]];
    
#pragma mark--<----------------------------左侧按钮-------------------------------------->
    
     
    UIButton * leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect rightrec=CGRectMake(0, 0, 60, 30);
    
    leftbutton.frame=rightrec;
    
    UIImage * rightimag=[UIImage imageNamed:@"leftButton"];
    
    [leftbutton setBackgroundImage:rightimag forState:UIControlStateNormal];
    
    //为按钮添加标题
    
    [leftbutton setTitle:@"选择" forState:UIControlStateNormal];
    
    /////////////
    
    UINavigationItem * rightIte =self.navigationItem;
    
    UIBarButtonItem * rightba=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    rightIte.leftBarButtonItem=rightba;
    
    [rightIte setTitle:@"快  递  速  查"];

    
    [leftbutton addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];

    
    
#pragma mark--<----------------------------右侧按钮-------------------------------------->
    
    UIButton * rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect rightrect=CGRectMake(0, 0, 60, 30);
    
    rightbutton.frame=rightrect;
    
    UIImage * rightimage=[UIImage imageNamed:@"rightButton"];
    
    [rightbutton setBackgroundImage:rightimage forState:UIControlStateNormal];
    
       //为按钮添加标题
    
    [rightbutton setTitle:@"更多" forState:UIControlStateNormal];
    
    /////////////
    
    UINavigationItem * rightItem =self.navigationItem;
    
    UIBarButtonItem * rightbar=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    
    rightItem.rightBarButtonItem=rightbar;
    
    [rightItem setTitle:@"快  递  速  查"];
    
    [rightbutton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];


#pragma mark--<------------调用界面设计方法------------------------>
    
    
    [self UI];
  
    
    [self tapRecognizer];
    
    
    self.NumberLable.delegate =self;
    
    self.gongSi.delegate = self;
    
    self.danHaoText.delegate =self;
    
}

#pragma mark -------键盘向上推代理方法实现－-----------------

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
     NSTimeInterval  animtionduration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForkeybord" context:nil];

    [UIView setAnimationDuration:animtionduration];
    
    NSInteger  a = textField.frame.origin.y - (self.view.frame.size.height-216.0) + 50;
    
    if (a>0)
    {
        
        self.view.frame = CGRectMake(0.0f, -a, self.view.frame.size.width, self.view.frame.size.height);

    }
    
    
    [UIView commitAnimations];

}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.NumberLable resignFirstResponder];
    
    [self.gongSi resignFirstResponder];
    
    [self.danHaoText resignFirstResponder];
    
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}





#pragma mark<----------点击背景，释放键盘--------->

-(void)tapRecognizer
{
  
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self    action:@selector(backupgroupTap)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer: tapGestureRecognizer];   //只需要点击非文字输入区域就会响应
    
    [tapGestureRecognizer setCancelsTouchesInView:NO];


}


-(void)backupgroupTap
{
    [self.NumberLable resignFirstResponder]; //关闭所有UITextField控件的键盘。。。
    
    [self.gongSi resignFirstResponder];
    
    [self.danHaoText resignFirstResponder];
}

#pragma mark--<--------------点击导航栏左、右侧按钮完成事件---------------------->

-(void)right
{

    self.OtherView = [[otherView alloc]init];
    
    [self.navigationController pushViewController:self.OtherView animated:YES];

}

-(void)left

{
    self.cellView =[[gongSi alloc]init];
    
    [self.navigationController pushViewController:self.cellView animated:YES];


}


#pragma mark<-----------UI界面设计---------->

-(void)UI
{

    LYXAppDelegate * delegate = [UIApplication sharedApplication].delegate;
    
    NSLog(@"%f",delegate.window.frame.size.height);

#pragma mark<---------if---------------->
    
    if (delegate.window.frame.size.height>480.0)
    {
        
#pragma mark<----------第一个框------------>
        
        
        self.view.backgroundColor = [UIColor grayColor];
        UIView *cyanLayer = [[UIView alloc]init];
        cyanLayer.layer.backgroundColor = [UIColor whiteColor].CGColor;
        cyanLayer.layer.frame = CGRectMake(30, 20, 260, 130);
        //cyanLayer.position = CGPointMake(100, 100);
        cyanLayer.layer.shadowOffset = CGSizeMake(0, 0); //设置阴影的偏移量
        cyanLayer.layer.shadowRadius = 5.0;  //设置阴影的半径
        cyanLayer.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
        cyanLayer.layer.shadowOpacity = 1; //设置阴影的不透明度
        cyanLayer.layer.cornerRadius =5;
        [self.view.layer addSublayer:cyanLayer.layer];
        
        
        
        ////////
        
        UIImageView * imageView = [[UIImageView alloc]init];
        
        imageView.frame = CGRectMake(40, 75, 200, 1);
        
        imageView.backgroundColor = [UIColor blackColor];
        
        imageView.alpha = 0.2f;
        
        [self.view addSubview:imageView];
        
        
#pragma mark<------------快递公司------------>
        
        self.gongsiLbale = [[UILabel alloc]initWithFrame:CGRectMake(45,38 , 200, 30)];
        
        self.gongsiLbale.text = @"快递公司";
        
        [self.gongsiLbale  setTextColor:[UIColor blackColor]];
        
        self.gongsiLbale.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.gongsiLbale.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:self.gongsiLbale];
        
        
#pragma mark-----------公司接收框架----------------
        
        self.gongSi = [[UITextField alloc]initWithFrame:CGRectMake(44, self.gongsiLbale.frame.origin.y+50, 200, 30)];
        
        self.gongSi.backgroundColor = [UIColor whiteColor];
        
        self.gongSi.layer.cornerRadius = 5.0;
        
        self.gongSi.placeholder =@"点击搜索选择公司";
        
        self.gongSi.layer.masksToBounds = YES;
        
         self.gongSi.enabled = NO;
        
        self.gongSi.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.gongSi.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.view addSubview:self.gongSi];
        
        
#pragma mark----------------------------公司搜索按钮---------------------------------------
        
        
        
        self.souSuoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.souSuoButton = [[UIButton alloc]initWithFrame:CGRectMake(235, self.gongSi.frame.origin.y-35, 45, 40)];
        
        [self.souSuoButton addTarget:self action:@selector(xuanzeButton) forControlEvents:UIControlEventTouchUpInside];
        
        self.souSuoButton.backgroundColor = [UIColor whiteColor];
        self.souSuoButton.layer.cornerRadius = 20.0;
        
        [self.souSuoButton setTitle:@"搜索" forState:UIControlStateNormal];
        
        [self.souSuoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.souSuoButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
        
        self.souSuoButton.layer.shadowColor = [UIColor blueColor].CGColor;
        
        self.souSuoButton.layer.shadowOpacity = 1;
        
        self.souSuoButton.layer.shadowOffset = CGSizeMake(0, 3);
        
        [self.view addSubview:self.souSuoButton];
        
        
        
        
#pragma mark<----------第二个框------------>
        
        UIView *cyanLayer2 = [[UIView alloc]init];
        cyanLayer2.layer.backgroundColor = [UIColor whiteColor].CGColor;
        cyanLayer2.layer.frame = CGRectMake(30, 170, 260, 130);
        //cyanLayer.position = CGPointMake(100, 100);
        cyanLayer2.layer.shadowOffset = CGSizeMake(0,0); //设置阴影的偏移量
        cyanLayer2.layer.shadowRadius = 5.0;  //设置阴影的半径
        cyanLayer2.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
        cyanLayer2.layer.shadowOpacity = 1; //设置阴影的不透明度
        cyanLayer2.layer.cornerRadius =5;
        [self.view addSubview:cyanLayer2];
        
#pragma mark------------快递单号标题---------------
        
        self.kuaiDiLbale = [[UILabel alloc]initWithFrame:CGRectMake(45, self.gongSi.frame.origin.y+100, 200, 30)];
        
        self.kuaiDiLbale.text = @"快递单号";
        
        [self.kuaiDiLbale  setTextColor:[UIColor blackColor]];
        
        self.kuaiDiLbale.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.kuaiDiLbale.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:self.kuaiDiLbale];
        
        
#pragma mark------------- 单号输入框 -------------------
        
        self.danHaoText = [[UITextField alloc]initWithFrame:CGRectMake(44,self.kuaiDiLbale.frame.origin.y+50,200, 35)];
        
        self.danHaoText.layer.cornerRadius = 5.0;
        
        self.danHaoText.layer.masksToBounds = YES;
        
         self.danHaoText.placeholder = @"请输入快递单号";
        
        self.danHaoText.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.danHaoText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        self.danHaoText.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:self.danHaoText];
        
        
#pragma mark<-------------查询按钮---------------->
        

        self.chaXunButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.chaXunButton = [[UIButton alloc]initWithFrame:CGRectMake(235, self.kuaiDiLbale.frame.origin.y+15, 45, 40)];
        
        [self.chaXunButton addTarget:self action:@selector(xiangQingView) forControlEvents:UIControlEventTouchUpInside];
        
        self.chaXunButton.backgroundColor = [UIColor whiteColor];
        self.chaXunButton.layer.cornerRadius = 20.0;
        
        [self.chaXunButton setTitle:@"查询" forState:UIControlStateNormal];
        
        [self.chaXunButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.chaXunButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        self.chaXunButton.layer.shadowColor = [UIColor blueColor].CGColor;
        
        self.chaXunButton.layer.shadowOpacity = 1;
        
        self.chaXunButton.layer.shadowOffset = CGSizeMake(0, 3);
        
        [self.view addSubview:self.chaXunButton];
        
        
        ///////////////////
        
        UIImageView * imageView2 = [[UIImageView alloc]init];
        
        
        imageView2.frame = CGRectMake(40, 225, 195, 1);
        
        imageView2.backgroundColor = [UIColor blackColor];
        
        imageView2.alpha = 0.2f;
        
        [self.view addSubview:imageView2];
        
        
#pragma mark<----------第三个框------------>
        
        UIView *cyanLayer3 = [[UIView alloc]init];
        cyanLayer3.layer.backgroundColor = [UIColor whiteColor].CGColor;
        cyanLayer3.layer.frame = CGRectMake(30, 325, 260, 130);
        //cyanLayer.position = CGPointMake(100, 100);
        cyanLayer3.layer.shadowOffset = CGSizeMake(0, 0); //设置阴影的偏移量
        cyanLayer3.layer.shadowRadius = 5.0;  //设置阴影的半径
        cyanLayer3.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
        cyanLayer3.layer.shadowOpacity = 1; //设置阴影的不透明度
        cyanLayer3.layer.cornerRadius =5;
        [self.view addSubview:cyanLayer3];
        
#pragma mark-------------客服电话---------------
        
        self.dianHuaLable = [[UILabel alloc]initWithFrame:CGRectMake(45, self.danHaoText.frame.origin.y+105, 200, 40)];
        
        self.dianHuaLable.text =@"客服电话";
        
        self.dianHuaLable.backgroundColor = [UIColor clearColor];
        
        [self.dianHuaLable setTextColor:[UIColor blackColor]];
        
        self.dianHuaLable.font = [UIFont fontWithName:@"Arial" size:20];
        
        [self.view addSubview:self.dianHuaLable];
        
#pragma mark<------------电话接收框------------------->
        self.NumberLable = [[UITextField alloc]initWithFrame:CGRectMake(45, self.dianHuaLable.frame.origin.y+45, 200, 38)];
        
        self.NumberLable.layer.cornerRadius = 5.0;
        
        self.NumberLable.backgroundColor = [UIColor whiteColor];
        
        self.NumberLable.layer.masksToBounds = YES;
        
        self.NumberLable.placeholder = @"点击按钮可直接拨号";
        
        self.NumberLable.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.NumberLable.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.view addSubview:self.NumberLable];
        
#pragma mark<-------------拨号按钮---------------->

        
        self.boHaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.boHaoButton = [[UIButton alloc]initWithFrame:CGRectMake(235, self.dianHuaLable.frame.origin.y+20, 45, 40)];
        
        [self.boHaoButton addTarget:self action:@selector(boHao) forControlEvents:UIControlEventTouchUpInside];
        
        self.boHaoButton.backgroundColor = [UIColor whiteColor];
        self.boHaoButton.layer.cornerRadius = 20.0;
        
        [self.boHaoButton setTitle:@"拨号" forState:UIControlStateNormal];
        
        [self.boHaoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.boHaoButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        self.boHaoButton.layer.shadowColor = [UIColor blueColor].CGColor;
        
        self.boHaoButton.layer.shadowOpacity = 1;
        
        self.boHaoButton.layer.shadowOffset = CGSizeMake(0, 3);
        
        [self.view addSubview:self.boHaoButton];
        
        //////////////
        
        UIImageView * imageView3 = [[UIImageView alloc]init];
        
        imageView3.frame = CGRectMake(40, 380, 195, 1);
        
        imageView3.backgroundColor = [UIColor blackColor];
        
        imageView3.alpha = 0.2f;
        
        [self.view addSubview:imageView3];
        
#pragma mark<---------公司logo-------------->
        
        UILabel * gSLable = [[UILabel alloc]initWithFrame:CGRectMake(45, self.dianHuaLable.frame.origin.y+120, 280, 38)];
        
        gSLable.backgroundColor = [UIColor clearColor];
        
        gSLable.text = @"上海双子星信息科技有限公司";
        
        [self.view addSubview:gSLable];

    }
 
 #pragma mark<---------else---------------->   
    
    else
    {
        
#pragma mark<----------第一个框------------>
        
        
        self.view.backgroundColor = [UIColor grayColor];
        UIView *cyanLayer = [[UIView alloc]init];
        cyanLayer.layer.backgroundColor = [UIColor whiteColor].CGColor;
        cyanLayer.layer.frame = CGRectMake(30, 20, 260, 100);
        //cyanLayer.position = CGPointMake(100, 100);
        cyanLayer.layer.shadowOffset = CGSizeMake(0, 0); //设置阴影的偏移量
        cyanLayer.layer.shadowRadius = 5.0;  //设置阴影的半径
        cyanLayer.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
        cyanLayer.layer.shadowOpacity = 1; //设置阴影的不透明度
        cyanLayer.layer.cornerRadius =5;
        [self.view.layer addSublayer:cyanLayer.layer];
        
        
        
        ////////
        
        UIImageView * imageView = [[UIImageView alloc]init];
        
        imageView.frame = CGRectMake(40, 60, 200, 1);
        
        imageView.backgroundColor = [UIColor blackColor];
        
        imageView.alpha = 0.2f;
        
        [self.view addSubview:imageView];
        
        
#pragma mark<------------快递公司------------>
        
        self.gongsiLbale = [[UILabel alloc]initWithFrame:CGRectMake(45,28 , 200, 30)];
        
        self.gongsiLbale.text = @"快递公司";
        
        [self.gongsiLbale  setTextColor:[UIColor blackColor]];
        
        self.gongsiLbale.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.gongsiLbale.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:self.gongsiLbale];
        
        
#pragma mark-----------公司接收框架----------------
        
        self.gongSi = [[UITextField alloc]initWithFrame:CGRectMake(44, self.gongsiLbale.frame.origin.y+42, 200, 30)];
        
        self.gongSi.backgroundColor = [UIColor whiteColor];
        
        self.gongSi.layer.cornerRadius = 5.0;
        
        self.gongSi.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.gongSi.placeholder =@"点击搜索选择公司";
        
        self.gongSi.layer.masksToBounds = YES;
        
         self.gongSi.enabled = NO;
        
        self.gongSi.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.view addSubview:self.gongSi];
        
        
#pragma mark----------------------------公司搜索按钮---------------------------------------
        
#pragma mark----------------------------公司搜索按钮---------------------------------------
        
        
        
        self.souSuoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.souSuoButton = [[UIButton alloc]initWithFrame:CGRectMake(235, self.gongSi.frame.origin.y-30, 45, 40)];
        
        [self.souSuoButton addTarget:self action:@selector(xuanzeButton) forControlEvents:UIControlEventTouchUpInside];
        
        self.souSuoButton.backgroundColor = [UIColor whiteColor];
        self.souSuoButton.layer.cornerRadius = 20.0;
        
        [self.souSuoButton setTitle:@"搜索" forState:UIControlStateNormal];
        
        [self.souSuoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.souSuoButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
        
        self.souSuoButton.layer.shadowColor = [UIColor blueColor].CGColor;
        
        self.souSuoButton.layer.shadowOpacity = 1;
        
        self.souSuoButton.layer.shadowOffset = CGSizeMake(0, 3);
        
        [self.view addSubview:self.souSuoButton];
        

        
        
        
        
#pragma mark<----------第二个框------------>
       
        UIView *cyanLayer2 = [[UIView alloc]init];
        cyanLayer2.layer.backgroundColor = [UIColor whiteColor].CGColor;
        cyanLayer2.layer.frame = CGRectMake(30, 140, 260, 100);
        //cyanLayer.position = CGPointMake(100, 100);
        cyanLayer2.layer.shadowOffset = CGSizeMake(0, 0); //设置阴影的偏移量
        cyanLayer2.layer.shadowRadius = 5.0;  //设置阴影的半径
        cyanLayer2.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
        cyanLayer2.layer.shadowOpacity = 1; //设置阴影的不透明度
        cyanLayer2.layer.cornerRadius =5;
        [self.view addSubview:cyanLayer2];
        
#pragma mark------------快递单号标题---------------
        
        self.kuaiDiLbale = [[UILabel alloc]initWithFrame:CGRectMake(45, self.gongSi.frame.origin.y+80, 200, 30)];
        
        self.kuaiDiLbale.text = @"快递单号";
        
        [self.kuaiDiLbale  setTextColor:[UIColor blackColor]];
        
        self.kuaiDiLbale.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.kuaiDiLbale.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:self.kuaiDiLbale];
        
        
#pragma mark------------- 单号输入框 -------------------
        
        self.danHaoText = [[UITextField alloc]initWithFrame:CGRectMake(44,self.kuaiDiLbale.frame.origin.y+37,200, 35)];
        
        self.danHaoText.layer.cornerRadius = 5.0;
        
        self.danHaoText.layer.masksToBounds = YES;
        
         self.danHaoText.placeholder = @"请输入快递单号";
        
        self.danHaoText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        self.danHaoText.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.danHaoText.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:self.danHaoText];
#pragma mark<-------------查询按钮---------------->
        
        
        self.chaXunButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.chaXunButton = [[UIButton alloc]initWithFrame:CGRectMake(235, self.kuaiDiLbale.frame.origin.y+10, 45, 40)];
        
        [self.chaXunButton addTarget:self action:@selector(xiangQingView) forControlEvents:UIControlEventTouchUpInside];
        
        self.chaXunButton.backgroundColor = [UIColor whiteColor];
        self.chaXunButton.layer.cornerRadius = 20.0;
        
        [self.chaXunButton setTitle:@"查询" forState:UIControlStateNormal];
        
        [self.chaXunButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.chaXunButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        self.chaXunButton.layer.shadowColor = [UIColor blueColor].CGColor;
        
        self.chaXunButton.layer.shadowOpacity = 1;
        
        self.chaXunButton.layer.shadowOffset = CGSizeMake(0, 3);
        
        [self.view addSubview:self.chaXunButton];
       
        
        ///////////////////
        
        UIImageView * imageView2 = [[UIImageView alloc]init];
        
        
        imageView2.frame = CGRectMake(40, 180,195, 1);
        
        imageView2.backgroundColor = [UIColor blackColor];
        
        imageView2.alpha = 0.2f;
        
        [self.view addSubview:imageView2];
        
        
#pragma mark<----------第三个框------------>
        
        UIView *cyanLayer3 = [[UIView alloc]init];
        cyanLayer3.layer.backgroundColor = [UIColor whiteColor].CGColor;
        cyanLayer3.layer.frame = CGRectMake(30, 260, 260, 100);
        //cyanLayer.position = CGPointMake(100, 100);
        cyanLayer3.layer.shadowOffset = CGSizeMake(0, 0); //设置阴影的偏移量
        cyanLayer3.layer.shadowRadius = 5.0;  //设置阴影的半径
        cyanLayer3.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
        cyanLayer3.layer.shadowOpacity = 1; //设置阴影的不透明度
        cyanLayer3.layer.cornerRadius =5;
        [self.view addSubview:cyanLayer3];
        
#pragma mark-------------客服电话---------------
        
        self.dianHuaLable = [[UILabel alloc]initWithFrame:CGRectMake(45, self.danHaoText.frame.origin.y+76, 200, 40)];
        
        self.dianHuaLable.text =@"客服电话";
        
        self.dianHuaLable.backgroundColor = [UIColor clearColor];
        
        [self.dianHuaLable setTextColor:[UIColor blackColor]];
        
        self.dianHuaLable.font = [UIFont fontWithName:@"Arial" size:20];
        
        [self.view addSubview:self.dianHuaLable];
        
#pragma mark<------------电话接收框------------------->
        
        self.NumberLable = [[UITextField alloc]initWithFrame:CGRectMake(45, self.dianHuaLable.frame.origin.y+44, 200, 38)];
        
        self.NumberLable.layer.cornerRadius = 5.0;
        
        self.NumberLable.backgroundColor = [UIColor whiteColor];
        
          self.NumberLable.placeholder = @"点击按钮可直接拨号";
        
        self.NumberLable.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.NumberLable.layer.masksToBounds = YES;
        
        self.NumberLable.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.view addSubview:self.NumberLable];
 
#pragma mark<-------------拨号按钮---------------->
        
        
        self.boHaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.boHaoButton = [[UIButton alloc]initWithFrame:CGRectMake(235, self.dianHuaLable.frame.origin.y+15, 45, 40)];
        
        [self.boHaoButton addTarget:self action:@selector(boHao) forControlEvents:UIControlEventTouchUpInside];
        
        self.boHaoButton.backgroundColor = [UIColor whiteColor];
        self.boHaoButton.layer.cornerRadius = 20.0;
        
        [self.boHaoButton setTitle:@"拨号" forState:UIControlStateNormal];
        
        [self.boHaoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.boHaoButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        self.boHaoButton.layer.shadowColor = [UIColor blueColor].CGColor;
        
        self.boHaoButton.layer.shadowOpacity = 1;
        
        self.boHaoButton.layer.shadowOffset = CGSizeMake(0, 3);
        
        [self.view addSubview:self.boHaoButton];

        
        //////////////
        
        UIImageView * imageView3 = [[UIImageView alloc]init];
        
        imageView3.frame = CGRectMake(40, 300, 195, 1);
        
        imageView3.backgroundColor = [UIColor blackColor];
        
        imageView3.alpha = 0.2f;
        
        [self.view addSubview:imageView3];
        
#pragma mark<-----------公司logo----------------->
        
        UILabel * gSLable = [[UILabel alloc]initWithFrame:CGRectMake(45, self.dianHuaLable.frame.origin.y+100, 280, 38)];
        
        gSLable.backgroundColor = [UIColor clearColor];
        
        gSLable.text = @"上海双子星信息科技有限公司";
        
        [self.view addSubview:gSLable];
        
        
        
    }
    

}

#pragma mark<------------点击查询按钮触发事件------------->

-(void)xiangQingView

{
    
    NSString * temp = self.gongSi.text;
    
    NSString * name=[self.dic objectForKey:temp];
    
    NSLog(@"name＝＝＝＝%@",name);
    
    NSURL * url =[NSURL URLWithString:[NSString stringWithFormat:@"http://api.kuaidi100.com/api?id=d6b9888b0da96f6b&com=%@&nu=%@&show=0&muti=1&order=desc&display=mobile",name,self.danHaoText.text]];
    
    NSLog(@"url======%@",url);
    
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    
    [request setCompletionBlock:
     ^{
         
         NSError * error = nil;
         
         NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
         
         
         NSArray * arr = [dictionary objectForKey:@"data"];
         
         [check shareDataModel].jieGuo =arr;
         
         NSLog(@"arrr%@",[check shareDataModel].jieGuo);
         for (NSDictionary * temp in arr)
         {
             
             [self.array addObject:[NSString stringWithFormat:@"%@ \n%@",[temp objectForKey:@"time"],[temp objectForKey:@"context"]]];
             
         }
         
         
         for(NSString* temp in self.array)
         {
             
             [self.mutableString appendString:[NSString stringWithFormat:@"%@\n",temp]];
             
             
         }
         
         
         self.jieGuoLale.text = self.mutableString;
         
         detailedView * detailed = [[detailedView alloc]init];
         
         // [check shareDataModel].jieGuo = self.jieGuoLale.text;
         
         [self.navigationController pushViewController:detailed animated:YES];

         
         
     }];
    
    [request setFailedBlock:
     ^{
         
         UIAlertView * alerteView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"问题警告：网络链接异常，请稍后再试" delegate:nil cancelButtonTitle:@"退出" otherButtonTitles: nil];
         [alerteView show];
         
     }];
    
    
    [request startAsynchronous];
    
    [self.danHaoText resignFirstResponder];
    

    
}



#pragma mark<------------点击查询按钮触发事件------------->


- (void)xuanzeButton
{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanzeButton" object:nil];
    
    [self.gongSi resignFirstResponder];

}

#pragma mark--<------------点击搜索按钮是发送Request请求------------------->

-(void)requestHttp
{
    
    //1200792098331
    
    
    }

#pragma mark--<---------------点击拨号按钮触发事件--------------------------->

-(void)boHao
{
    NSString *phone = self.NumberLable.text;
    
     
    if (phone != nil) {
        
        
        
        NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
        
        
        
        NSURL *url = [[NSURL alloc] initWithString:telUrl];
        
        
        
        [[UIApplication sharedApplication] openURL:url];
    }


    [self.NumberLable resignFirstResponder];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
