//
//  HJPhotoPreviewController.h
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/19.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAsset,HJAssetModel;
NS_ASSUME_NONNULL_BEGIN

@interface HJPhotoPreviewController : UIViewController
- (instancetype)initWithPreviewPhotos:(NSArray<PHAsset *> *)assets selectedPhoto:(NSArray<HJAssetModel *> *)assetModels selectedDic:(NSDictionary *)selectedDic;
@end

NS_ASSUME_NONNULL_END