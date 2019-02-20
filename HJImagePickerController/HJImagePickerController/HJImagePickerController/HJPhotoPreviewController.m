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
#import "HJAssetModel.h"

@interface HJPhotoPreviewController ()<HJImagePickerBottomViewDelegate>
@property (nonatomic, strong) HJImagePickerBottomView *bottomView;
@property (nonatomic, strong) NSArray<PHAsset *> *assets;
@property (nonatomic, strong) NSMutableArray<HJAssetModel *> *selectedAssetModels;
@property (nonatomic, strong) NSMutableDictionary *selectedAssetModelsDic;
@property (nonatomic, assign) BOOL selectedOriginImage;
@end

@implementation HJPhotoPreviewController

- (instancetype)initWithSelectedPhoto:(NSArray<HJAssetModel *> *)assetModels selectedDic:(NSDictionary *)selectedDic selectedOriginImage:(BOOL)selected;{
    self = [super init];
    if (self) {
        self.selectedAssetModels = [assetModels mutableCopy];
        self.selectedAssetModelsDic = [selectedDic mutableCopy];
        self.selectedOriginImage = selected;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
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
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 + 5, kScreenWidth, kScreenHeight - 64 - 50 - 90 - 5)];
    NSInteger index = 0;
    CGFloat imageViewWidth = scrollView.bounds.size.width;
    CGFloat imageViewHeight = scrollView.bounds.size.height;
    
    for (HJAssetModel *model in self.selectedAssetModels) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(index * imageViewWidth, 0, imageViewWidth, imageViewHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = index;
        PHImageManager *imageManager = [PHImageManager defaultManager];
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        [imageManager requestImageForAsset:model.asset
                                targetSize:CGSizeMake(imageViewWidth * [UIScreen mainScreen].scale, imageViewHeight * [UIScreen mainScreen].scale)
                               contentMode:PHImageContentModeAspectFill
                                   options:options
                             resultHandler:^(UIImage * result, NSDictionary * info) {
                                 if (imageView.tag == index) {
                                     imageView.image = result;
                                 }
                             }];
        [scrollView addSubview:imageView];
        index ++;
    }
    [scrollView setContentSize:CGSizeMake(imageViewWidth * self.selectedAssetModels.count, imageViewHeight)];
    scrollView.pagingEnabled = YES;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        scrollView.scrollIndicatorInsets = scrollView.contentInset;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:scrollView];
    
    HJImagePickerBottomView *bottomView = [[HJImagePickerBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame) + 90, kScreenWidth, 50) selectedOriginBtn:self.selectedOriginImage];
    bottomView.backgroundColor = [UIColor colorWithRed:41/255.0 green:43/255.0 blue:50/255.0 alpha:1];
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
}

- (void)doneClikeSelectButton:(UIBarButtonItem *)barButtonItem{

}

- (void)doneClikeBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickOriginbtnWithState:(BOOL)selected {
    
}

- (void)didClickDeterminebtn {
    
}

@end
