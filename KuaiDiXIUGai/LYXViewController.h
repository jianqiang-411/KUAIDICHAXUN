//
//  LYXViewController.h
//  KuaiDiXIUGai
//
//  Created by 李永兴 on 13-6-20.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "otherView.h"

#import "gongSi.h"

@interface LYXViewController : UIViewController

//<-------------------------界面设计属性------------------------------>

@property (nonatomic ,strong) UIImageView * backgroundView;

@property (nonatomic ,strong) UILabel * titileLable;

@property (nonatomic ,strong) UILabel * gongsiLbale;

@property (nonatomic ,strong) UIImageView * gongSiView;

@property (nonatomic ,strong) UITextField * gongSi;

@property (nonatomic ,strong) UIButton * souSuoButton;

@property (nonatomic ,strong) UILabel * kuaiDiLbale;

@property (nonatomic ,strong) UITextField * danHaoText;

@property (nonatomic ,strong) UIImageView * danHaoView;

@property (nonatomic ,strong) UIButton * chaXunButton;

@property (nonatomic ,strong) UITextView * jieGuoLale;

@property (nonatomic ,strong) UIImageView * jieGuoView;

@property(nonatomic,strong)NSDictionary* dic;

@property (nonatomic ,strong) NSDictionary* dict2;

@property (strong ,nonatomic) NSMutableArray * array;

@property (strong ,nonatomic) NSMutableString * mutableString;

@property (strong ,nonatomic) UIImageView * NumberView;

@property (strong,nonatomic) UITextField * NumberLable;

@property (strong ,nonatomic)UILabel * dianHuaLable;

@property (strong ,nonatomic) UILabel * xiangQingLable;

@property (strong ,nonatomic) UIButton * boHaoButton;

//<---------------------导航栏属性-------------------------------------->

@property (nonatomic ,strong) UINavigationBar * Navigation;

@property (nonatomic ,strong) UIButton * leftButton;

@property (nonatomic ,strong) UIButton * rightButton;


@property (nonatomic ,strong) otherView * OtherView;

@property (nonatomic ,strong) gongSi * cellView;


@end
