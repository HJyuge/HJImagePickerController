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

static NSInteger const displayScrollViewTag = 100;
@interface HJPhotoPreviewController ()<
HJImagePickerBottomViewDelegate,
UIScrollViewDelegate,
HJImagePickerCellIndicatorDelegate
>
@property (nonatomic, strong) HJImagePickerBottomView *bottomView;
@property (nonatomic, strong) NSArray<PHAsset *> *assets;
@property (nonatomic, strong) NSMutableArray<HJAssetModel *> *selectedAssetModels;
@property (nonatomic, strong) NSMutableArray<HJAssetModel *> *tempAssetModels;
@property (nonatomic, assign) BOOL selectedOriginImage;
@property (nonatomic, strong) HJImagePickerCellIndicator *naviItemIndicator;
@property (nonatomic, assign) NSInteger currentDisplayIndex;
@end

@implementation HJPhotoPreviewController

- (instancetype)initWithSelectedPhoto:(NSArray<HJAssetModel *> *)assetModels selectedOriginImage:(BOOL)selected;{
    self = [super init];
    if (self) {
        self.selectedAssetModels = [assetModels mutableCopy];
        self.tempAssetModels = [assetModels mutableCopy];
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
    
    HJImagePickerCellIndicator *selectedIndicator = [[HJImagePickerCellIndicator alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
    selectedIndicator.delegate = self;
    self.naviItemIndicator = selectedIndicator;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:selectedIndicator];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[HJImagePickerConstant imageNamedFromBundle:HJBundleSourceNaviBack] style:UIBarButtonItemStyleDone target:self action:@selector(doneClikeBackButton)];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 + 5, kScreenWidth, kScreenHeight - 64 - 50 - 90 - 5)];
    NSInteger index = 0;
    CGFloat imageViewWidth = scrollView.bounds.size.width;
    CGFloat imageViewHeight = scrollView.bounds.size.height;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.tag = displayScrollViewTag;
    for (HJAssetModel *model in self.selectedAssetModels) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(index * imageViewWidth, 0, imageViewWidth, imageViewHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = index;
        PHImageManager *imageManager = [PHImageManager defaultManager];
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        //PHImageManagerMaximumSize
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
    
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        scrollView.scrollIndicatorInsets = scrollView.contentInset;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:scrollView];
    
    if (self.selectedAssetModels > 0) {
        [self.naviItemIndicator setIndicatorStateWithIndex:1];
    }
    
    HJImagePickerBottomView *bottomView = [[HJImagePickerBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame) + 90, kScreenWidth, 50) selectedOriginBtn:self.selectedOriginImage];
    bottomView.backgroundColor = [UIColor colorWithRed:41/255.0 green:43/255.0 blue:50/255.0 alpha:1];
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    NSString *selectedCount = self.selectedAssetModels.count > 0? [NSString stringWithFormat:@"发送(%ld)",self.selectedAssetModels.count]:@"发送";
    [self.bottomView updateDetermineBtnTitle:selectedCount];
    
}

- (void)doneClikeSelectButton:(UIBarButtonItem *)barButtonItem{

}

- (void)doneClikeBackButton {
    if ([self.delegate respondsToSelector:@selector(endPreViewPhoto:selectedOriginImage:)]) {
        [self.delegate endPreViewPhoto:self.tempAssetModels selectedOriginImage:self.bottomView.isSelected];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - HJImagePickerCellIndicatorDelegate
- (void)didClickIndicatorWithState:(BOOL)state Index:(NSInteger)index {
    HJAssetModel *model = [self.selectedAssetModels objectAtIndex:_currentDisplayIndex];
    if (state) {
        [_naviItemIndicator setIndicatorStateWithIndex:0];
        [model setModelIsSelect:NO selectedIndex:0];
        [_tempAssetModels removeObject:model];
    }else{
        [_naviItemIndicator setIndicatorStateWithIndex:_tempAssetModels.count+1];
        [model setModelIsSelect:YES selectedIndex:_tempAssetModels.count+1];
        [_tempAssetModels addObject:model];
    }
    [self sortModelsAndUpdateIndicatorState:_naviItemIndicator];
    NSString *selectedCount = _tempAssetModels.count > 0? [NSString stringWithFormat:@"发送(%ld)",_tempAssetModels.count]:@"发送";
    [self.bottomView updateDetermineBtnTitle:selectedCount];
}

- (void)sortModelsAndUpdateIndicatorState:(HJImagePickerCellIndicator *)indicator{
    NSInteger count = 1;
    for(HJAssetModel *model in _tempAssetModels) {
        [model selectedIndex:count];
        count++;
    }
}

#pragma mark - HJImagePickerBottomViewDelegate
- (void)didClickOriginbtnWithState:(BOOL)selected {
    
}

- (void)didClickDeterminebtn {
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (displayScrollViewTag == scrollView.tag) {
        //房租超出边界改变index
        if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width) {
            return;
        }
        NSInteger currentIndex = scrollView.contentOffset.x/kScreenWidth;
        _currentDisplayIndex = currentIndex;
        HJAssetModel *model = [self.selectedAssetModels objectAtIndex:currentIndex];
        [self.naviItemIndicator setIndicatorStateWithIndex:model.selectedIndex];
    }
}
@end
