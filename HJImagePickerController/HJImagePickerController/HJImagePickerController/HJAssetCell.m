//
//  HJAssetCell.m
//  RebuildTasty
//
//  Created by HuangJin on 2019/2/12.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import "HJAssetCell.h"

@implementation HJAssetCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        
        self.selectedIndicator = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width - 10 - 5 , 5, 10, 10)];
        self.selectedIndicator.contentMode = UIViewContentModeScaleAspectFill;
        self.selectedIndicator.clipsToBounds = YES;
        self.selectedIndicator.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:self.selectedIndicator];
        
        self.maskImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        self.maskImageView.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:self.maskImageView];
        
    }
    return self;
}

- (void)setIndicatorState:(BOOL)state {
    self.selectedIndicator.image = state?[UIImage imageNamed:@""]:[UIImage imageNamed:@""];
}

@end
