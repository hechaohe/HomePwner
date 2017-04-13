//
//  MYImageViewController.m
//  MyHomePwner
//
//  Created by hc on 2017/3/9.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "MYImageViewController.h"

@interface MYImageViewController ()


@end

@implementation MYImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showerImageView.image = self.image;
    self.showerImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    [self.view addGestureRecognizer:tap];
}
- (void)tapGes:(UITapGestureRecognizer *)tap {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
