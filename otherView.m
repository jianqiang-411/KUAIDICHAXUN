//
//  otherView.m
//  KuaiDiXIUGai
//
//  Created by 李永兴 on 13-6-21.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import "otherView.h"

#import <QuartzCore/QuartzCore.h>

#import "QRCodeGenerator.h"

#import "LYXViewController.h"

#import "LYXAppDelegate.h"

#import "check.h"

@interface otherView ()<ZBarReaderDelegate,UIAlertViewDelegate>


@property (nonatomic, strong) LYXViewController * lyxView;

@property (nonatomic,strong) UIButton * QRbutton2;

@end

@implementation otherView

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
    
  
    
    
    //<--------------添加背景图片-------------->
    
    //隐藏navigation自带的按钮
    
    self.navigationItem.hidesBackButton = YES;
    
    //
	
    self.view.backgroundColor = [UIColor grayColor];
    
    
    //<-------------添加左侧按钮------------------->
    
    
    
    UIButton * leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect rightrec=CGRectMake(0, 0, 60, 30);
    
    leftbutton.frame=rightrec;
    
    UIImage * rightimag=[UIImage imageNamed:@"leftButton"];
    
    [leftbutton setBackgroundImage:rightimag forState:UIControlStateNormal];
    
    
    //<----------------为按钮添加标题---------------->
    
    
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    
    UINavigationItem * rightIte =self.navigationItem;
    
    UIBarButtonItem * rightba=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    rightIte.leftBarButtonItem=rightba;
    
    [rightIte setTitle:@"智  能  识  别"];
    
    [leftbutton addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    

    [self QRbutton];
    
    
    //<-------------加载二维码------------->
    
    
    self.readerView = [ZBarReaderViewController new];
    
    self.readerView.readerDelegate = self;
    
    self.readerView.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner * scanner = self.readerView.scanner;
    
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
     
    self.readerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 280, 320)];
    
    [self.view addSubview:self.readerImage];
    
    
    UIImageView * tiaoXingMa = [[UIImageView alloc]initWithFrame:CGRectMake(40, 70, 250, 100)];
    
    tiaoXingMa.image = [UIImage imageNamed:@"tiaoxingma.jpg"];
    
    
    tiaoXingMa.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tapPictur = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressQRbutton)];
    
    
    [tiaoXingMa addGestureRecognizer:tapPictur];
    
    [self.view addSubview:tiaoXingMa];
    
    UIImageView * erWeiMa = [[UIImageView alloc]initWithFrame:CGRectMake(40, 250, 150, 150)];
    
    erWeiMa.image = [UIImage imageNamed:@"erweima"];
    
    erWeiMa.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * twoGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressQRbutton)];
    
    [erWeiMa addGestureRecognizer:twoGestureRecognizer];
    
    [self.view addSubview:erWeiMa];
    
}




-(void)pressQRbutton
{

   // self.readerImage.image = [QRCodeGenerator qrImageForString:@"asd" imageSize:self.readerImage.bounds.size.width];

    
    [self presentViewController:self.readerView animated:YES completion:^{
       
    }];

 
}


- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
   
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
    {
        NSLog(@"symbol =%@",symbol.data);
        break;
    }
   
    //<--------------传送数据到单号Text----------->
    
    LYXViewController * LyxViewController = [[LYXViewController alloc]init];
    
    [check shareDataModel].danHaoNumber =symbol.data;
   
     LyxViewController.danHaoText.text = [check shareDataModel].danHaoNumber;

     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:LyxViewController.danHaoText.text message:LyxViewController.danHaoText.text delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    
    self.readerImage.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    
    [self.readerView dismissViewControllerAnimated:YES completion:^{
        
    }];
    
 
    LYXAppDelegate * delegate = [UIApplication sharedApplication].delegate;

    LYXViewController *lyx = [LYXViewController new];
    
    [self.navigationController pushViewController:lyx animated:NO];
    
    delegate.window.rootViewController = lyx;
    

    
    
}



-(void)left
{

    [self.navigationController popToRootViewControllerAnimated:YES];


}

-(void)QRbutton
{

    self.QRButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 15, 80, 40)];
    
   // [self.QRButton setImage:[UIImage imageNamed:@"tiaoxingma"] forState:UIControlStateNormal];
   
    self.QRButton.layer.cornerRadius = 10.0;
    
    self.QRButton.layer.masksToBounds = YES;
    
    self.QRButton.backgroundColor = [UIColor clearColor];
    
    [self.QRButton setTitle:@"条形码" forState: UIControlStateNormal];
    
    [self.QRButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.QRButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [self.QRButton addTarget:self action:@selector(pressQRbutton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.QRButton];
    
    
    //<---------------------------二维码按钮--------------------------------->
    
    self.QRbutton2 = [[UIButton alloc]initWithFrame:CGRectMake(40, 190, 80, 40)];
    
    // [self.QRButton setImage:[UIImage imageNamed:@"tiaoxingma"] forState:UIControlStateNormal];
    
    self.QRbutton2.layer.cornerRadius = 10.0;
    
    self.QRbutton2.layer.masksToBounds = YES;
    
    self.QRbutton2.backgroundColor = [UIColor clearColor];
    
    [self.QRbutton2 setTitle:@"二维码" forState: UIControlStateNormal];
    
    [self.QRbutton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.QRbutton2.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [self.QRbutton2 addTarget:self action:@selector(pressQRbutton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.QRbutton2];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
