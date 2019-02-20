//
//  HJAssetCell.m
//  RebuildTasty
//
//  Created by HuangJin on 2019/2/12.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import "HJAssetCell.h"
#import "HJImagePickerConstant.h"
#import "HJImagePickerView.h"

@interface HJAssetCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *maskImageView;
@property (nonatomic, strong) HJImagePickerCellIndicator *selectedIndicator;

@end

@implementation HJAssetCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        
        CGFloat width = 24.0;
        CGFloat margin = 2;
        self.selectedIndicator = [[HJImagePickerCellIndicator alloc]initWithFrame:CGRectMake(self.bounds.size.width - width - margin , margin, width, width)];
        [self.contentView addSubview:self.selectedIndicator];
        
//        self.maskImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
//        self.maskImageView.image = [UIImage imageNamed:@""];
//        [self.contentView addSubview:self.maskImageView];
        
    }
    return self;
}

- (UIImage *)thumbnail {
    return self.imageView.image;
}

- (void)setCellImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)setIndicatorState:(BOOL)state {
    [self.selectedIndicator setIndicatorState:state];
}

- (void)setIndicatorStateWithIndex:(NSInteger)index {
    [self.selectedIndicator setIndicatorStateWithIndex:index];
}

@end
