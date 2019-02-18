//
//  HJImagePickerController.m
//  RebuildTasty
//
//  Created by HuangJin on 2019/2/12.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import "HJImagePickerController.h"
#import <Photos/Photos.h>
#import "HJAssetCell.h"
#import "HJImagePickerConstant.h"
#import "HJAssetModel.h"
#import "HJAblumsController.h"

#define cellMargin 3
#define numberOfColumn 4

@interface HJImagePickerController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    CGFloat _cellWidth;
}
@property (nonatomic, copy) NSArray *fetchResults;
@property (nonatomic, copy) NSArray *assetCollections;
@property (nonatomic, strong) NSMutableArray *selectedAssetModels;
@property (nonatomic, strong) NSMutableDictionary *selectedAssetModelsDic;

@property (nonatomic, strong) UIView *bottomView;
@end

@implementation HJImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(doneClikeCancelButton)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[HJImagePickerConstant imageNamedFromBundle:HJBundleSourceNaviBack] style:UIBarButtonItemStyleDone target:self action:@selector(doneClikeMoreButton)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.title = @"相机胶卷";
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    PHFetchResult *userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
//    PHFetchResult *momentAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeMoment subtype:PHAssetCollectionSubtypeAny options:nil];
    self.fetchResults = @[smartAlbums, userAlbums];
    
    [self updateAssetCollections];
    
    _cellWidth = (kScreenWidth - cellMargin * (numberOfColumn + 1))/numberOfColumn;
    
//    PHImageManager *manager = [PHImageManager defaultManager];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 50 - 64) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[HJAssetCell class] forCellWithReuseIdentifier:NSStringFromClass([HJAssetCell class])];
    
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        collectionView.scrollIndicatorInsets = collectionView.contentInset;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:collectionView];
    if(self.assetCollections.count > 0){
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.assetCollections.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    }
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(collectionView.frame), kScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor darkGrayColor];
    UIButton *previewbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 60, 40)];
    previewbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [previewbtn setTitle:@"预览" forState:UIControlStateNormal];
    [previewbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [previewbtn addTarget:self action:@selector(didClickPreViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:previewbtn];
    UIButton *orginImagebtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 60)/2, 5, 60, 40)];
    [orginImagebtn setTitle:@"原图" forState:UIControlStateNormal];
    orginImagebtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [orginImagebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orginImagebtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [orginImagebtn addTarget:self action:@selector(didClickOrginImagebtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:orginImagebtn];
    UIButton *determinebtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 60 - 15, 5, 60, 40)];
    [determinebtn setTitle:@"发送" forState:UIControlStateNormal];
    determinebtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [determinebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determinebtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [determinebtn addTarget:self action:@selector(didClickOrginDeterminebtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:determinebtn];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
}

- (void)updateAssetCollections
{
    //@(PHAssetCollectionSubtypeAlbumMyPhotoStream),
//    @(PHAssetCollectionSubtypeSmartAlbumPanoramas),//全景
//    @(PHAssetCollectionSubtypeSmartAlbumVideos),
//    @(PHAssetCollectionSubtypeSmartAlbumBursts)
    NSArray *assetCollectionSubtypes = @[ @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),//相机胶卷
                                         ];
    NSMutableDictionary *smartAlbums = [NSMutableDictionary dictionaryWithCapacity:assetCollectionSubtypes.count];
    NSMutableArray *userAlbums = [NSMutableArray array];
    for (PHFetchResult *fetchResult in self.fetchResults) {
        [fetchResult enumerateObjectsUsingBlock:^(PHAssetCollection *assetCollection, NSUInteger idx, BOOL * _Nonnull stop) {
            PHAssetCollectionSubtype subtype = assetCollection.assetCollectionSubtype;
            if (subtype == PHAssetCollectionSubtypeAlbumRegular) {
                //[userAlbums addObject:assetCollection];
            } else if ([assetCollectionSubtypes containsObject:@(subtype)]){
                if (!smartAlbums[@(subtype)]) {
                    smartAlbums[@(subtype)] = [NSMutableArray array];
                }
                [smartAlbums[@(subtype)] addObject:assetCollection];
            }
        }];
        
    }
    
    NSMutableArray *assetCollections = [NSMutableArray array];
    for (NSNumber *assetCollectionSubtype in assetCollectionSubtypes) {
        NSArray *collections = smartAlbums[assetCollectionSubtype];
        if (collections) {
            [assetCollections addObjectsFromArray:collections];
        }
    }
    
    [userAlbums enumerateObjectsUsingBlock:^(PHAssetCollection *assetCollection, NSUInteger idx, BOOL * _Nonnull stop) {
        [assetCollections addObject:assetCollection];
    }];
    
    NSMutableArray *assets = [NSMutableArray array];
    for (PHAssetCollection *assetCollection in assetCollections) {
        // Thumbnail
        PHFetchOptions *options = [PHFetchOptions new];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
        for (PHAsset *asset in fetchResult) {
            [assets addObject:asset];
        }
    }
    self.assetCollections = assets;
    self.selectedAssetModels = [@[] mutableCopy];
    self.selectedAssetModelsDic = [@{} mutableCopy];
}
#pragma mark- Button
- (void)doneClikeMoreButton {
    HJAblumsController *ablumsController = [[HJAblumsController alloc]init];
    [self.navigationController pushViewController:ablumsController animated:YES];
}

- (void)doneClikeCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didClickPreViewBtn:(UIButton *)btn {
    
}

- (void)didClickOrginImagebtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    
}

- (void)didClickOrginDeterminebtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    
}

#pragma mark- UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetCollections.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HJAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HJAssetCell class]) forIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    PHImageManager *imageManager = [PHImageManager defaultManager];
    [imageManager requestImageForAsset:self.assetCollections[indexPath.row]
                            targetSize:CGSizeMake(_cellWidth * [UIScreen mainScreen].scale, _cellWidth* [UIScreen mainScreen].scale)
                           contentMode:PHImageContentModeAspectFill
                               options:nil
                         resultHandler:^(UIImage * result, NSDictionary * info) {
                             if (cell.tag == indexPath.row) {
                                 [cell setCellImage:result];
                             }
                         }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HJAssetCell *cell = (HJAssetCell *)[collectionView cellForItemAtIndexPath:indexPath];
    PHAsset *asset = self.assetCollections[indexPath.row];
    if ([_selectedAssetModelsDic objectForKey:asset.localIdentifier]) {
        [cell setIndicatorStateWithIndex:0];
        HJAssetModel *model = [_selectedAssetModelsDic objectForKey:asset.localIdentifier];
        //先移除model
        model.cellIndexPath = nil;
        [_selectedAssetModelsDic removeObjectForKey:asset.localIdentifier];
        [self.selectedAssetModels removeObject:model];
        //重新排序
        [self assetModelsNeedSortAndUpdateIndicatorStateWithCollectionView:collectionView];
    }else{
        [cell setIndicatorStateWithIndex:self.selectedAssetModels.count+1];
        HJAssetModel *model = [HJAssetModel modelWithAsset:asset thumbnail:cell.thumbnail];
        [model setModelIsSelect:!model.selected selectedIndex:self.selectedAssetModels.count+1];
        [self.selectedAssetModels addObject:model];
        model.cellIndexPath = indexPath;
        [_selectedAssetModelsDic setObject:model forKey:asset.localIdentifier];
    }
}

- (void)assetModelsNeedSortAndUpdateIndicatorStateWithCollectionView:(UICollectionView *)collectionView{
    NSInteger count = 1;
    for(HJAssetModel *model in self.selectedAssetModels) {
        [model selectedIndex:count];
        HJAssetCell *cell = (HJAssetCell *)[collectionView cellForItemAtIndexPath:model.cellIndexPath];
        [cell setIndicatorStateWithIndex:count];
        count++;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_cellWidth, _cellWidth);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return cellMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return cellMargin;
}

@end
