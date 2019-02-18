//
//  HJImagePickerView.h
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/18.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HJSelectOriginImageView;
@interface HJImagePickerView : UIView

@end

@interface HJSelectOriginImageView : UIView
@property (nonatomic, readonly,getter=isSelected) BOOL selected;
@end



NS_ASSUME_NONNULL_END
