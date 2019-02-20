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
@property (nonatomic, strong) NSArray<PHAsset *> *assets;
@property (nonatomic, strong) NSMutableArray<HJAssetModel *> *selectedAssetModels;
@property (nonatomic, strong) NSMutableDictionary *selectedAssetModelsDic;
@end

@implementation HJPhotoPreviewController

- (instancetype)initWithPreviewPhotos:(NSArray<PHAsset *> *)assets selectedPhoto:(NSArray<HJAssetModel *> *)assetModels selectedDic:(NSDictionary *)selectedDic{
    self = [super init];
    if (self) {
        self.assets = [assets copy];
        self.selectedAssetModels = [assetModels mutableCopy];
        self.selectedAssetModelsDic = [selectedDic mutableCopy];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor]; [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
//    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor]; [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[HJImagePickerConstant imageNamedFromBundle:HJBundleSourceIndicatorNormal] style:UIBarButtonItemStyleDone target:self action:@selector(doneClikeSelectButton:)];
//    UIImageView *selectedIndicator = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
//    selectedIndicator.contentMode = UIViewContentModeScaleToFill;
//    selectedIndicator.clipsToBounds = YES;
//    selectedIndicator.image = [HJImagePickerConstant imageNamedFromBundle:HJBundleSourceIndicatorNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:selectedIndicator];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[HJImagePickerConstant imageNamedFromBundle:HJBundleSourceNaviBack] style:UIBarButtonItemStyleDone target:self action:@selector(doneClikeBackButton)];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    
    scrollView.pagingEnabled = YES;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        scrollView.scrollIndicatorInsets = scrollView.contentInset;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (void)doneClikeSelectButton:(UIBarButtonItem *)barButtonItem{
//    barButtonItem.image
}

- (void)doneClikeBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
