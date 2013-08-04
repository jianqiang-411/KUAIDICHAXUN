//
//  check.h
//  KuaiDiXIUGai
//
//  Created by 李永兴 on 13-6-20.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface check : NSObject

@property(nonatomic,strong) NSString * numbers;

@property(nonatomic,strong) NSString * Names;

@property (nonatomic ,strong) NSString * danHaoNumber;

@property (nonatomic,strong) NSArray * jieGuo;

+(check*)shareDataModel;


@end
