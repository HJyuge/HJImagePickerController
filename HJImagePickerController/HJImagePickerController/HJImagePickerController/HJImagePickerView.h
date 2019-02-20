//
//  HJImagePickerView.h
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/18.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HJSelectOriginImageView,HJImagePickerBottomView;
@interface HJImagePickerView : UIView

@end

@protocol HJSelectOriginImageViewDelegate;
@interface HJSelectOriginImageView : UIView
@property (nonatomic, readonly,getter=isSelected) BOOL selected;
@property (nonatomic, weak)id<HJSelectOriginImageViewDelegate>delegate;
@end
@protocol HJSelectOriginImageViewDelegate <NSObject>
- (void)didClickOriginImageViewWithState:(BOOL)selected;
@end

@protocol HJImagePickerBottomViewDelegate;
@interface HJImagePickerBottomView : UIView
@property (nonatomic, readonly,getter=isSelected) BOOL selected;
@property (nonatomic, weak)id<HJImagePickerBottomViewDelegate>delegate;
- (void)updateDetermineBtnTitle:(NSString *)title;
@end

@protocol HJImagePickerBottomViewDelegate <NSObject>
- (void)didClickPreViewBtn;
- (void)didClickOriginbtnWithState:(BOOL)selected;
- (void)didClickDeterminebtn;

@end

NS_ASSUME_NONNULL_END
