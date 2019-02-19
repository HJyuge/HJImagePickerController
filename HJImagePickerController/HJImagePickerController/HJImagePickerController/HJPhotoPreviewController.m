//
//  HJPhotoPreviewController.m
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/19.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import "HJPhotoPreviewController.h"
#import "HJImagePickerConstant.h"
#import "HJImagePickerView.h"
#import <Photos/Photos.h>

@interface HJPhotoPreviewController ()
@property (nonatomic, strong) HJImagePickerBottomView *bottomView;
@property (nonatomic, strong) NSArray<PHAsset *> *asset;

@end

@implementation HJPhotoPreviewController

- (instancetype)initWithPreviewPhotos:(NSArray<PHAsset *> *)asset selectedPhoto:(NSArray<HJAssetModel *> *)assetModels{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView {
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    
    scrollView.pagingEnabled = YES;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        scrollView.scrollIndicatorInsets = scrollView.contentInset;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

@end
