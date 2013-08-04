//
//  custumCell.m
//  KuaiDiXIUGai
//
//  Created by 李永兴 on 13-6-20.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import "custumCell.h"

#import <QuartzCore/QuartzCore.h>

@implementation custumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    
        [self addSubview:self.kuaiDiView];
        
        self.gongSiLable = [[UILabel alloc]initWithFrame:CGRectMake(0,0,320, 50)];
                
        self.gongSiLable.textColor = [UIColor brownColor];
        
        self.gongSiLable.layer.cornerRadius = 10.0f;
        
        self.gongSiLable.layer.masksToBounds = YES;
        
        self.gongSiLable.font = [UIFont boldSystemFontOfSize:20];

        [self addSubview:self.gongSiLable];
        
        self.phoneNumberLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 51,320, 50)];
        
        self.phoneNumberLable.layer.cornerRadius = 10.0f;
        
        self.phoneNumberLable.layer.masksToBounds = YES;
        
        self.phoneNumberLable.textColor = [UIColor brownColor];
        
        self.phoneNumberLable.font = [UIFont boldSystemFontOfSize:20];
        
        [self addSubview:self.phoneNumberLable];

        
        
        
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

@end
