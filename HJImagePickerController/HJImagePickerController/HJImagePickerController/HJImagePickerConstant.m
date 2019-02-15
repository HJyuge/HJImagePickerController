//
//  HJImagePickerConstant.m
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/15.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJImagePickerConstant.h"
#import "HJImagePickerController.h"

NSString *const HJBundleSourceNaviBack = @"image_nav_back";
NSString *const HJBundleSourceIndicatorSelectedIndex = @"image_select_index";
NSString *const HJBundleSourceIndicatorNormal = @"image_select_normal";
NSString *const HJBundleSourceIndicatorSelected = @"image_select_selected";

@implementation HJImagePickerConstant

+ (UIImage *)imageNamedFromBundle:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[HJImagePickerController class]];
    NSURL *url = [bundle URLForResource:@"HJImagePickerController" withExtension:@"bundle"];
    bundle = [NSBundle bundleWithURL:url];
    name = [name stringByAppendingString:@"@2x"];
    NSString *imagePath = [bundle pathForResource:name ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) {
        // 兼容业务方自己设置图片的方式
        name = [name stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
        image = [UIImage imageNamed:name];
    }
    return image;
}

@end
