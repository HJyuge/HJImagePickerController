//
//  ViewController.m
//  HJImagePickerController
//
//  Created by HuangJin on 2019/2/14.
//  Copyright © 2019年 HuangJin. All rights reserved.
//

#import "ViewController.h"
#import "HJImagePickerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)didClickImageBtn:(UIButton *)sender {
    HJImagePickerController *imagePickerController = [[HJImagePickerController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:nil];
}


@end
