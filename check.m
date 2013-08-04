//
//  check.m
//  KuaiDiXIUGai
//
//  Created by 李永兴 on 13-6-20.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import "check.h"

@implementation check


static check* dataModel = nil;

+(check*)shareDataModel
{
    if (dataModel ==nil) {
        
        dataModel = [[check alloc]init];
        
    }
    return dataModel;
}



@end
