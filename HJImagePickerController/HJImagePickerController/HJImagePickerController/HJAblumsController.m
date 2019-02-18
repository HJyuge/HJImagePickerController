//
//  HJAblumsController.m
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/18.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import "HJAblumsController.h"
#import <Photos/Photos.h>

@interface HJAblumsController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HJAblumsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *albumTypes = @[
                            @(PHAssetCollectionTypeSmartAlbum),
                            @(PHAssetCollectionTypeAlbum),
                            
                            ];
    //@(PHAssetCollectionTypeMoment)
    NSMutableArray *albums = @[].mutableCopy;
    for (NSNumber *type in albumTypes) {
        PHFetchResult *album = [PHAssetCollection fetchAssetCollectionsWithType:type.integerValue subtype:PHAssetCollectionSubtypeAny options:nil];
        [album enumerateObjectsUsingBlock:^(PHAssetCollection *assetCollection, NSUInteger idx, BOOL * _Nonnull stop) {
            [albums addObject:assetCollection];
        }];
    }
    self.dataSource = albums;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedSectionFooterHeight = 0.1;
    tableView.estimatedSectionHeaderHeight = 0.1;
    tableView.rowHeight = 60.0f;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HJAblumsCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.tag = indexPath.row;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    PHAssetCollection *assetCollection = self.dataSource[indexPath.row];
    cell.textLabel.frame = CGRectMake(70, 0, self.view.bounds.size.width - 70, 60);
    
    PHImageManager *imageManager = [PHImageManager defaultManager];
    PHFetchOptions *options = [PHFetchOptions new];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%ld)",assetCollection.localizedTitle,fetchResult.count];
    
    if (fetchResult.count > 0) {
        [imageManager requestImageForAsset:fetchResult.firstObject
                                targetSize:CGSizeMake(60, 60)
                               contentMode:PHImageContentModeAspectFill
                                   options:nil
                             resultHandler:^(UIImage * result, NSDictionary * info) {
                                 cell.imageView.image = result;
                                 cell.imageView.frame = CGRectMake(0, 0, 60, 60);
                             }];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
