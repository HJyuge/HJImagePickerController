//
//  HJAssetModel.m
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/15.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import "HJAssetModel.h"

@interface HJAssetModel ()
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation HJAssetModel

+ (instancetype)modelWithAsset:(PHAsset *)asset {
    return [HJAssetModel modelWithAsset:asset thumbnail:nil];
}

+ (instancetype)modelWithAsset:(PHAsset *)asset thumbnail:(UIImage *)thumbnail {
    return [[HJAssetModel alloc]initWithAsset:asset thumbnail:thumbnail];
}

- (instancetype)initWithAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        self.asset = asset;
    }
    return self;
}

- (instancetype)initWithAsset:(PHAsset *)asset thumbnail:(UIImage *)thumbnail {
    self = [super init];
    if (self) {
        self.asset = asset;
        self.thumbnail = thumbnail;
    }
    return self;
}

- (void)setModelIsSelect:(BOOL)selected selectedIndex:(NSInteger)selectedIndex {
    self.selected = selected;
    self.selectedIndex = selected?selectedIndex:0;
}


@end
