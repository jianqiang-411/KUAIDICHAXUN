////
////  cell.m
////  KuaiDiXIUGai
////
////  Created by 李永兴 on 13-6-20.
////  Copyright (c) 2013年 李永兴. All rights reserved.
////
//
//#import "cell.h"
//
//#import "LYXAppDelegate.h"
//
//#import "check.h"
//
//#import <QuartzCore/QuartzCore.h>
//
//#import "LYXViewController.h"
//
//#import "custumCell.h"
//
//@interface cell ()
//
//@property (nonatomic ,strong) custumCell * custum;
//
//@end
//
//@implementation cell
//
//@synthesize tableView,array,array2;
//
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//        //[self.view setBackgroundColor:[UIColor clearColor]];
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    
//    self.navigationItem.hidesBackButton = YES;
//    
//    //<-----------------------------添加一个右侧按钮----------------------------------->
//    
//    UIButton * rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
//    
//    CGRect rightrect=CGRectMake(0, 0, 60, 30);
//    
//    rightbutton.frame=rightrect;
//    
//    UIImage * rightimage=[UIImage imageNamed:@"rightButton"];
//    
//    [rightbutton setBackgroundImage:rightimage forState:UIControlStateNormal];
//    
//    //为按钮添加标题
//    
//    [rightbutton setTitle:@"主页" forState:UIControlStateNormal];
//    
//    /////////////
//    
//    UINavigationItem * rightItem =self.navigationItem;
//    
//    UIBarButtonItem * rightbar=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
//    
//    rightItem.rightBarButtonItem=rightbar;
//    
//    [rightItem setTitle:@"快  递  公  司"];
//    
//    [rightbutton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
//
//
//    
//    //将plist文件转换成字符串
//    NSString* arr=[[NSBundle mainBundle]pathForResource:@"gongSiCanShuList" ofType:@"plist"];
//    
//    //将字符串存放在字典中
//    
//    NSDictionary* dic=[NSDictionary dictionaryWithContentsOfFile:arr];
//    
//    //将字典中的关键字取出来
//    
//    NSDictionary *dict1=[dic objectForKey:@"快递公司"];
//    
//    //将所有关键字（allkeys）存放在数组中
//    
//    self.array=[dict1 allKeys];
//    
//    //将plist文件转换成字符串
//    NSString* string = [[NSBundle mainBundle]pathForResource:@"gongSiNumberList" ofType:@"plist"];
//    
//    //将字符串存放在字典中
//    
//    NSDictionary* dictionary=[NSDictionary dictionaryWithContentsOfFile:string];
//    
//    //将字典中的关键字取出来
//    
//    NSDictionary *dict2=[dictionary objectForKey:@"快递公司"];
//    
//    //将所有关键字（allkeys）存放在数组中
//    
//    NSLog(@"%@",dict2);
//    
//    self.array2=[dict2 allKeys];
//    
//    
//}
//
//-(void)right
//{
//
//    [self.navigationController popToRootViewControllerAnimated:YES];
//
//
//}
//
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.array count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *Identifier = @"hello";
//    
//    custumCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
//    
//    if (cell==nil)
//    {
//        cell = [[custumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
//    }
//    
//    
//    cell.gongSiLable.text=[array objectAtIndex:indexPath.row];
//    
//    
//    cell.phoneNumberLable.text = [array2 objectAtIndex:indexPath.row];
//    
//    
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    
//    [check shareDataModel].Names = [array objectAtIndex:indexPath.row];
//    
//    [check shareDataModel].numbers= [array2 objectAtIndex:indexPath.row];
//    
//    LYXAppDelegate * delegate = [UIApplication sharedApplication].delegate;
//    
//    LYXViewController *lyx = [LYXViewController new];
//    
//    [self.navigationController popToRootViewControllerAnimated:YES];
//
//}
//
//- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 90;
//}
//-(void)postNotifaction
//{
//    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"postNotifaction" object:nil];
//    
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    
//}
//
//
//
//
//@end
