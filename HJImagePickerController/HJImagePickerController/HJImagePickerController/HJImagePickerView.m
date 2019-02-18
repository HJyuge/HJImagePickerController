//
//  HJImagePickerView.m
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/18.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import "HJImagePickerView.h"
#import "HJImagePickerConstant.h"

@interface HJImagePickerView()

@end

@implementation HJImagePickerView

@end

@interface HJSelectOriginImageView()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation HJSelectOriginImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.bounds;
    [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UIImageView *originImageView = [[UIImageView alloc]init];
    [self addSubview:originImageView];
    self.imageView = originImageView;
    
    UILabel *title = [[UILabel alloc]init];
    title.textColor = [UIColor whiteColor];
    title.text = @"原图";
    title.font = [UIFont systemFontOfSize:14];
    [title sizeToFit];
    [self addSubview:title];
    self.titleLabel = title;
    [self viewLayout];
}

- (void)viewLayout{
    CGFloat titleWidth = self.titleLabel.bounds.size.width;
    CGFloat imageViewWidth = 20.0f;
    CGFloat marign = 6.0f;
    CGFloat imageViewX = (self.bounds.size.width - imageViewWidth - titleWidth - marign)/2;
    CGFloat imageViewY = (self.bounds.size.height - imageViewWidth)/2;
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewWidth);
    self.imageView.layer.cornerRadius = imageViewWidth/2;
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    CGFloat titleX = CGRectGetMaxX(self.imageView.frame) + marign;
    CGFloat titleY = (self.bounds.size.height - self.titleLabel.bounds.size.height)/2;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleWidth, self.titleLabel.bounds.size.height);
    
}

- (void)didClickButton:(UIButton *)button {
    button.selected = !button.selected;
    _selected = button.selected;
    self.imageView.image = _selected?[HJImagePickerConstant imageNamedFromBundle:HJBundleSourceIndicatorSelectedOrigin]:nil;
}

@end


@interface HJDetermineSelectedImagesView ()

@end

@implementation HJDetermineSelectedImagesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    
}

@end
