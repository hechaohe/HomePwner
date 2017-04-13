//
//  MYItem.h
//  MyHomePwner
//
//  Created by hc on 2017/3/6.
//  Copyright © 2017年 hc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MYItem : NSObject <NSCoding>

+(instancetype)randomItem;
-(instancetype)initWithItemName:(NSString *)name valueInDollors:(int)value serialNumber:(NSString *)sNumber;

@property(nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic,readonly,strong) NSDate *dateCreated;

/**
 image key
 */
@property (nonatomic,copy) NSString *itemKey;


@property (nonatomic,strong) UIImage *thumbnail;
- (void)setThumbnailFromImage:(UIImage *)image;
@end
