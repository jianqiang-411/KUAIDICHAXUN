//
//  JieGuoCell.m
//  KuaiDiXIUGai
//
//  Created by 殷佳斌 on 13-7-5.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import "JieGuoCell.h"

#import <QuartzCore/QuartzCore.h>

@implementation JieGuoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.lable1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 250, 30)];
        
        self.lable1.layer.cornerRadius = 5.0f;
        
        self.lable2.layer.masksToBounds = YES;
        
        self.lable1.textColor = [UIColor redColor];
        
        [self addSubview:self.lable1];
        
        self.lable2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 31, 250, 30)];
        
        self.lable2.layer.cornerRadius = 5.0f;
        
        self.lable2.layer.masksToBounds = YES;
        
        [self addSubview:self.lable2];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
