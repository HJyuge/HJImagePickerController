//
//  ViewController.m
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/14.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import "ViewController.h"
#import "HJImagePickerController.h"
#import "HJImagePickerController/HJAssetCell.h"
#import "HJImagePickerController/HJAssetModel.h"

/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define cellMargin 3
#define numberOfColumn 4

@interface ViewController ()<
HJImagePickerControllerDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource
>{
    CGFloat _cellWidth;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<HJAssetModel *> *selectedAssetModels;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _selectedAssetModels = @[].mutableCopy;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 170, kScreenWidth, kScreenWidth) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[HJAssetCell class] forCellWithReuseIdentifier:NSStringFromClass([HJAssetCell class])];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    _cellWidth = (kScreenWidth - cellMargin * (numberOfColumn + 1))/numberOfColumn;
}

- (IBAction)didClickImageBtn:(UIButton *)sender {
    HJImagePickerController *imagePickerController = [[HJImagePickerController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:imagePickerController];
    imagePickerController.delegate = self;
    [self presentViewController:navigationController animated:YES completion:nil];

}

#pragma mark - HJImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(HJImagePickerController *)picker {

}

- (void)imagePickerController:(HJImagePickerController *)picker didFinishPickingImages:(NSArray<HJAssetModel *> *)images {
    self.selectedAssetModels = [images mutableCopy];
    [self.collectionView reloadData];
}

- (void)imagePickerController:(nonnull HJImagePickerController *)picker didFinishPickingMedia:(nonnull NSData *)Media {

}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectedAssetModels.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HJAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HJAssetCell class]) forIndexPath:indexPath];
    cell.tag = indexPath.row;
    HJAssetModel *model = self.selectedAssetModels[indexPath.row];
    [cell setCellImage: model.thumbnail];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    HJAssetCell *cell = (HJAssetCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    HJAssetModel *model = self.selectedAssetModels[indexPath.row];

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
