//
//  HJAssetCell.h
//  RebuildTasty
//
//  Created by HuangJin on 2019/2/12.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UICollectionViewCellDelegate;


@interface HJAssetCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *selectedIndicator;
@property (nonatomic, strong) UIImageView *maskImageView;

- (void)setIndicatorState:(BOOL)state;
@end

@protocol UICollectionViewCellDelegate <NSObject>

- (void)didSelectAssetCell:(HJAssetCell *)cell;

@end

NS_ASSUME_NONNULL_END
