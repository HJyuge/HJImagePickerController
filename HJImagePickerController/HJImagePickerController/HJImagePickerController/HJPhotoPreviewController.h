//
//  HJPhotoPreviewController.h
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/19.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAsset,HJAssetModel;
@protocol HJPhotoPreviewControllerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface HJPhotoPreviewController : UIViewController
@property (nonatomic, weak) id<HJPhotoPreviewControllerDelegate> delegate;
- (instancetype)initWithSelectedPhoto:(NSArray<HJAssetModel *> *)assetModels selectedOriginImage:(BOOL)selected;
@end

@protocol HJPhotoPreviewControllerDelegate <NSObject>
- (void)endPreViewPhoto:(NSMutableArray<HJAssetModel *> *)assetModels selectedOriginImage:(BOOL)selected;
@end

NS_ASSUME_NONNULL_END
