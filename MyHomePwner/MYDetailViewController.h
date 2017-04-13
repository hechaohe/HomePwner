//
//  MYDetailViewController.h
//  MyHomePwner
//
//  Created by hc on 2017/3/6.
//  Copyright © 2017年 hc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYItem;
@interface MYDetailViewController : UIViewController

@property (nonatomic,strong) MYItem *item;

@property (nonatomic,copy) void(^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;
@end
