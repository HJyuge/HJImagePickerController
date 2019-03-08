//
//  HJImagePickerController.h
//  RebuildTasty
//
//  Created by HuangJin on 2019/2/12.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJAssetModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HJImagePickerControllerDelegate;

@interface HJImagePickerController : UIViewController
@property (nonatomic, weak) id<HJImagePickerControllerDelegate> delegate;
@end

@protocol HJImagePickerControllerDelegate <NSObject>
@optional
- (void)imagePickerController:(HJImagePickerController *)picker didFinishPickingImages:(NSArray <HJAssetModel *>*)images;
- (void)imagePickerController:(HJImagePickerController *)picker didFinishPickingMedia:(NSData *)Media;//待完善
- (void)imagePickerControllerDidCancel:(HJImagePickerController *)picker;

@end
NS_ASSUME_NONNULL_END
