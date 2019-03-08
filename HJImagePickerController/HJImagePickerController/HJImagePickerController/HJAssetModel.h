//
//  HJAssetModel.h
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/15.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJAssetModel : NSObject
@property (nonatomic, strong)PHAsset *asset;
@property (nonatomic, assign,readonly) BOOL selected;
@property (nonatomic, assign,readonly) NSInteger selectedIndex;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong,nullable) NSIndexPath *cellIndexPath;
@property (nonatomic, strong,nullable) NSData *imgData;

+ (instancetype)modelWithAsset:(PHAsset *)asset;
+ (instancetype)modelWithAsset:(PHAsset *)asset thumbnail:(UIImage * _Nullable )thumbnail;

- (void)selectedIndex:(NSInteger)selectedIndex;
- (void)setModelIsSelect:(BOOL)selected selectedIndex:(NSInteger)selectedIndex;

@end

NS_ASSUME_NONNULL_END
