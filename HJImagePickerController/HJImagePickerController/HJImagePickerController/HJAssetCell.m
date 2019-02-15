//
//  HJAssetCell.m
//  RebuildTasty
//
//  Created by HuangJin on 2019/2/12.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import "HJAssetCell.h"
#import "HJImagePickerConstant.h"

@interface HJAssetCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *selectedIndicator;
@property (nonatomic, strong) UIImageView *maskImageView;
@property (nonatomic, strong) UILabel     *countLabel;

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
        
        CGFloat width = 20.0;
        CGFloat margin = 2;
        self.selectedIndicator = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width - width - margin , margin, width, width)];
        self.selectedIndicator.contentMode = UIViewContentModeScaleToFill;
        self.selectedIndicator.clipsToBounds = YES;
        self.selectedIndicator.image = [HJImagePickerConstant imageNamedFromBundle:HJBundleSourceIndicatorNormal];
        [self.contentView addSubview:self.selectedIndicator];
        
//        self.maskImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
//        self.maskImageView.image = [UIImage imageNamed:@""];
//        [self.contentView addSubview:self.maskImageView];
        
        self.countLabel = [[UILabel alloc]initWithFrame:_selectedIndicator.bounds];
        self.countLabel.text = @"";
        self.countLabel.textColor = [UIColor whiteColor];
        self.countLabel.font = [UIFont systemFontOfSize:14];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        [self.selectedIndicator addSubview:_countLabel];
        
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
    self.selectedIndicator.image = state?[HJImagePickerConstant imageNamedFromBundle:HJBundleSourceIndicatorSelected]:[HJImagePickerConstant imageNamedFromBundle:HJBundleSourceIndicatorNormal];;
}

- (void)setIndicatorStateWithIndex:(NSInteger)index {
    self.selectedIndicator.image = index > 0?[HJImagePickerConstant imageNamedFromBundle:HJBundleSourceIndicatorSelectedCount]:[HJImagePickerConstant imageNamedFromBundle:HJBundleSourceIndicatorNormal];
    self.countLabel.text = index > 0 ? @(index).stringValue:@"";
}

@end
