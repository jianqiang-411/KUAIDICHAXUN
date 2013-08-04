//
//  otherView.h
//  KuaiDiXIUGai
//
//  Created by 李永兴 on 13-6-21.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBarSDK.h"



@interface otherView : UIViewController

@property (nonatomic ,strong) UIButton * QRButton;

@property (nonatomic ,strong) ZBarReaderViewController * readerView;

@property (nonatomic ,strong) UIImageView * readerImage;



@end
