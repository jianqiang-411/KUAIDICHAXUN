//
//  detailedView.m
//  KuaiDiXIUGai
//
//  Created by 殷佳斌 on 13-7-5.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import "detailedView.h"

#import "check.h"

#import "JieGuoCell.h"

#import <QuartzCore/QuartzCore.h>

@interface detailedView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation detailedView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //将查询结果放入到一个数组中
    
    //self.array = [NSArray arrayWithObject:[check shareDataModel].jieGuo];
   
    self.navigationItem.hidesBackButton = YES;
    
    //<-------------添加左侧按钮---------------->
    
       
    UIButton * leftbutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    CGRect rightrec=CGRectMake(0, 0, 60, 30);
    
    leftbutton.frame=rightrec;
    
    UIImage * rightimag=[UIImage imageNamed:@"leftButton"];
    
    [leftbutton setBackgroundImage:rightimag forState:UIControlStateNormal];
    
    
    //<----------------为按钮添加标题---------------->
    
    
    [leftbutton setTitle:@"主页" forState:UIControlStateNormal];
    
    UINavigationItem * rightIte =self.navigationItem;
    
    UIBarButtonItem * rightba=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    rightIte.leftBarButtonItem=rightba;
    
    [rightIte setTitle:@"查  询  结  果"];
    
    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [leftbutton addTarget:self action:@selector(zhuYe) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.view.frame.size.height >480)
    {
        
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(30, 30, 260, 400) style:UITableViewStylePlain];
        
        self.tableView.dataSource = self;
        
        self.tableView.delegate = self;
        
        self.tableView.layer.cornerRadius = 5.0f;
        
        self.tableView.layer.masksToBounds = YES;
        
        [self.view addSubview:self.tableView];

     
                
        UILabel * Logo = [[UILabel alloc]initWithFrame:CGRectMake(28, 460, 265, 20)];
        
        Logo.text = @" @ 上海双子星信息技术有限公司";
        
        Logo.backgroundColor = [UIColor clearColor];
        
        [Logo setTextColor:[UIColor whiteColor]];
        
        Logo.font = [UIFont fontWithName:@"Arial" size:18];
        
        [self.view addSubview:Logo];
        
        
    }
    else
    {
    
                
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(30, 20, 270, 350) style:UITableViewStylePlain];
        
        self.tableView.dataSource = self;
        
        self.tableView.delegate = self;
        
        self.tableView.layer.cornerRadius = 5.0f;
        
        self.tableView.layer.masksToBounds = YES;
        
        [self.view addSubview:self.tableView];
        
        //
        
        UILabel * Logo = [[UILabel alloc]initWithFrame:CGRectMake(45, 385, 265, 20)];
        
        Logo.text = @" @ 上海双子星信息技术有限公司";
        
        Logo.backgroundColor = [UIColor clearColor];
        
        [Logo setTextColor:[UIColor whiteColor]];
        
        Logo.font = [UIFont fontWithName:@"Arial" size:15];
        
        [self.view addSubview:Logo];
        
       
    }
   
}

#pragma mark<---------跳转到主页面------------->

-(void)zhuYe
{
   
    [self.navigationController popToRootViewControllerAnimated:YES];


}


#pragma mark<---------tableView代理类的方法实现------------->

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{NSLog(@" [[check shareDataModel].jieGuo count] = %i", [[check shareDataModel].jieGuo count]);
    
        
    return [[check shareDataModel].jieGuo count];


}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString * string =@"hello";
    
    JieGuoCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (cell ==nil)
    {
        cell = [[JieGuoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        
    }
    
    NSLog(@"[[check shareDataModel].jieGuo == %@",[check shareDataModel].jieGuo);
    
    NSDictionary * dic= [[check shareDataModel].jieGuo objectAtIndex:indexPath.row];
    
    cell.lable1.text = [dic objectForKey:@"time"];
    
    NSLog(@"cell.lable1.text == %@",cell.lable1.text);
    
     cell.lable2.text = [dic objectForKey:@"context"];

    CGSize labelSize = {0, 0};
    labelSize = [cell.lable2.text sizeWithFont:[UIFont systemFontOfSize:14]
                     constrainedToSize:CGSizeMake(100.0, 5000)
                         lineBreakMode:UILineBreakModeWordWrap];
    
    //14 为UILabel的字体大小
    
    //200为UILabel的宽度，5000是预设的一个高度，表示在这个范围内
    
    
    cell.lable2.numberOfLines = 0;//表示label可以多行显示
    
    cell.lable2.lineBreakMode = UILineBreakModeCharacterWrap;//换行模式，与上面的计算保持一致。
    
    cell.lable2.frame = CGRectMake(cell.lable2.frame.origin.x, cell.lable2.frame.origin.y, cell.lable2.frame.size.width, labelSize.height);//保持原来Label的位置和宽度，只是改变高度。


    return cell;

}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary * dic= [[check shareDataModel].jieGuo objectAtIndex:indexPath.row];

  
    CGSize labelSize = {0, 0};
    
    labelSize = [[dic objectForKey:@"context"] sizeWithFont:[UIFont systemFontOfSize:14]
                 
                     constrainedToSize:CGSizeMake(100.0, 5000)
                 
                         lineBreakMode:UILineBreakModeWordWrap];
    
    //14 为UILabel的字体大小
    
    //200为UILabel的宽度，5000是预设的一个高度，表示在这个范围内
    
    
    
    return labelSize.height + 30;
    
    //delta 是Cell除了自适应控件UILabel外的其它控件所占的高度。
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
