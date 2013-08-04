//
//  gongSi.m
//  KuaiDiXIUGai
//
//  Created by 阿阿 on 13-7-11.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import "gongSi.h"


#import "LYXAppDelegate.h"

#import "check.h"

#import <QuartzCore/QuartzCore.h>

#import "LYXViewController.h"

#import "custumCell.h"

#import "FMDatabase.h"

@interface gongSi ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation gongSi

@synthesize tableView,array,array2;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    LYXAppDelegate * delegate = [UIApplication sharedApplication].delegate;
    
    NSLog(@"%f",delegate.window.frame.size.height);
    
#pragma mark<---------if---------------->
    
    if (delegate.window.frame.size.height>480.0)
    {
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 15, 300, 460) style:UITableViewStylePlain];
        
        self.tableView.layer.cornerRadius = 5.0f;
        
        self.tableView.layer.masksToBounds = YES;
        
        self.tableView.dataSource = self;
        
        self.tableView.delegate = self;
        
        [self.view addSubview:self.tableView];
        
    
    }
    
    else
    {

        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 5, 300, 405) style:UITableViewStylePlain];
        
        self.tableView.layer.cornerRadius = 5.0f;
        
        self.tableView.layer.masksToBounds = YES;
        
        self.tableView.dataSource = self;
        
        self.tableView.delegate = self;
        
        [self.view addSubview:self.tableView];

    
    }
    
    
    self.navigationItem.hidesBackButton = YES;
    
    //<-----------------------------添加一个右侧按钮----------------------------------->
    
    UIButton * rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect rightrect=CGRectMake(0, 0, 60, 30);
    
    rightbutton.frame=rightrect;
    
    UIImage * rightimage=[UIImage imageNamed:@"rightButton"];
    
    [rightbutton setBackgroundImage:rightimage forState:UIControlStateNormal];
    
    //为按钮添加标题
    
    [rightbutton setTitle:@"主页" forState:UIControlStateNormal];
    
    /////////////
    
    UINavigationItem * rightItem =self.navigationItem;
    
    UIBarButtonItem * rightbar=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    
    rightItem.rightBarButtonItem=rightbar;
    
    [rightItem setTitle:@"快  递  公  司"];
    
    [rightbutton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    
    
    
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
    
    
    self.array2 = [[NSMutableArray alloc]init];
    
    self.array = [[NSMutableArray alloc]init];
    
    NSString * str = [[NSBundle mainBundle]pathForResource:@"kdcx" ofType:@"db"];
    
    FMDatabase * FMData = [[FMDatabase alloc]initWithPath:str];
    
    [FMData open];
    
    FMResultSet * resultSet = [FMData executeQuery:@"select * from  name"];
    
    while ([resultSet next])
    {
        
        [self.array addObject:[resultSet stringForColumn:@"name"]];
        
        [self.array2 addObject:[resultSet stringForColumn:@"phone"]];
        
        NSLog(@"array === %@",array);
        
        NSLog(@"array2 == %@",array2);
        
  
    }
    
    
    
}

-(void)right
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"hello";
    
    custumCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (cell==nil)
    {
        cell = [[custumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    NSLog(@"aaaa == %@",array);
    
    cell.gongSiLable.text=[array objectAtIndex:indexPath.row];
    
    NSLog(@"bbb == %@",array2);
    
    cell.phoneNumberLable.text = [array2 objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    [check shareDataModel].Names = [array objectAtIndex:indexPath.row];
    
    [check shareDataModel].numbers= [array2 objectAtIndex:indexPath.row];
    
    LYXAppDelegate * delegate = [UIApplication sharedApplication].delegate;
    
    LYXViewController *lyx = [LYXViewController new];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(void)postNotifaction
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"postNotifaction" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}




@end
