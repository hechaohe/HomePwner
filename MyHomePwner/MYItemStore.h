//
//  MYItemStore.h
//  MyHomePwner
//
//  Created by hc on 2017/3/6.
//  Copyright © 2017年 hc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MYItem;


@interface MYItemStore : NSObject

@property (nonatomic,readonly) NSArray *allItems;

+ (instancetype)sharedStore;
-(MYItem *)createItem;


/**
 remove

 @param item remove
 */
- (void)removeItem:(MYItem *)item;

/**
 yidong

 @param fromIndex target
 @param toIndex destination
 */
- (void)moveItemAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;


/**
 change

 @return save
 */
- (BOOL)saveChanges;
@end
