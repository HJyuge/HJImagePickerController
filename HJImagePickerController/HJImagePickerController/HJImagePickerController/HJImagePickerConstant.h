//
//  HJImagePickerConstant.h
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/14.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

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
