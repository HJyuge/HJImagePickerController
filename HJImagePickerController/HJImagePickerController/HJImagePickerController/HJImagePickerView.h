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
//- (void)setOriginImageViewState:(BOOL)selected;
@end
@protocol HJSelectOriginImageViewDelegate <NSObject>
- (void)didClickOriginImageViewWithState:(BOOL)selected;
@end

@protocol HJImagePickerBottomViewDelegate;
@interface HJImagePickerBottomView : UIView
@property (nonatomic,getter=isSelected) BOOL selected;
@property (nonatomic, weak)id<HJImagePickerBottomViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame selectedOriginBtn:(BOOL)selected;
- (void)updateDetermineBtnTitle:(NSString *)title;
//- (void)setOriginBtnState:(BOOL)selected;
@end

@protocol HJImagePickerBottomViewDelegate <NSObject>
@optional;
- (void)didClickPreViewBtn;
- (void)didClickOriginbtnWithState:(BOOL)selected;
- (void)didClickDeterminebtn;
@end

@protocol HJImagePickerCellIndicatorDelegate;
@interface HJImagePickerCellIndicator : UIView
@property (nonatomic, weak)id<HJImagePickerCellIndicatorDelegate>delegate;
@property (nonatomic, assign) BOOL needGestureRecognizer;
- (void)setIndicatorState:(BOOL)state;
- (void)setIndicatorStateWithIndex:(NSInteger)index;
@end
@protocol HJImagePickerCellIndicatorDelegate <NSObject>
@optional;
- (void)didClickIndicatorWithState:(BOOL)state Index:(NSInteger)index;
@end
NS_ASSUME_NONNULL_END
