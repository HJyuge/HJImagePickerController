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


@interface HJImagePickerBottomView ()
@property (nonatomic, strong) UIButton *determineSelectedImagesBtn;
@end

@implementation HJImagePickerBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.backgroundColor = [UIColor colorWithRed:41/255.0 green:43/255.0 blue:50/255.0 alpha:1];
    
    UIButton *previewbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 60, 40)];
    previewbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [previewbtn setTitle:@"预览" forState:UIControlStateNormal];
    [previewbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [previewbtn addTarget:self action:@selector(didClickPreViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:previewbtn];
    
    HJSelectOriginImageView *selectOriginImageView = [[HJSelectOriginImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 60)/2, 5, 60, 40)];
    [self addSubview:selectOriginImageView];
    
    UIButton *determinebtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 64 - 12, 10, 64, 30)];
    [determinebtn setTitle:@"发送" forState:UIControlStateNormal];
    determinebtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [determinebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determinebtn setBackgroundColor:[UIColor colorWithRed:8/255.0 green:190/255.0 blue:8/255.0 alpha:1]];
    determinebtn.layer.cornerRadius = 5;
    determinebtn.layer.masksToBounds = YES;
    //    [determinebtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [determinebtn addTarget:self action:@selector(didClickOrginDeterminebtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:determinebtn];
    self.determineSelectedImagesBtn = determinebtn;
}

- (void)updateDetermineBtnTitle:(NSString *)title {
    [self.determineSelectedImagesBtn setTitle:title forState:UIControlStateNormal];
}

- (void)didClickPreViewBtn:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didClickPreViewBtn)]) {
        [self.delegate didClickPreViewBtn];
    }
}

- (void)didClickOrginDeterminebtn:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didClickOrginDeterminebtn)]) {
        [self.delegate didClickOrginDeterminebtn];
    }
}

@end
