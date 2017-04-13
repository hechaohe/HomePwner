//
//  MYImageViewController.h
//  MyHomePwner
//
//  Created by hc on 2017/3/9.
//  Copyright © 2017年 hc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYImageViewController : UIViewController
@property (nonatomic,strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *showerImageView;

@end
