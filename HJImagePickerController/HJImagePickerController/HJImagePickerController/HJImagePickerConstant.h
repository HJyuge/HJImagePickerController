//
//  HJImagePickerConstant.h
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/14.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef HJImagePickerConstant_h
#define HJImagePickerConstant_h
/**
 *  弱指针
 */
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
/***  粗体 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]

#endif /* HJImagePickerConstant_h */

UIKIT_EXTERN NSString *const HJBundleSourceNaviBack;
UIKIT_EXTERN NSString *const HJBundleSourceIndicatorSelectedOrigin;
UIKIT_EXTERN NSString *const HJBundleSourceIndicatorSelectedCount;
UIKIT_EXTERN NSString *const HJBundleSourceIndicatorNormal;
UIKIT_EXTERN NSString *const HJBundleSourceIndicatorSelected;


@interface HJImagePickerConstant: NSObject
+ (UIImage *)imageNamedFromBundle:(NSString *)name;

@end
