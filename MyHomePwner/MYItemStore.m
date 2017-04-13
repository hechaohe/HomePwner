//
//  MYItemStore.m
//  MyHomePwner
//
//  Created by hc on 2017/3/6.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "MYItemStore.h"
#import "MYItem.h"
#import "MYImageStore.h"
@interface MYItemStore ()
@property (nonatomic) NSMutableArray *privateItems;

@end


@implementation MYItemStore

+ (instancetype)sharedStore {
    static MYItemStore *sharedStore;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[MYItemStore sharedStore]" userInfo:nil];
    return nil;
}
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        
        //读数据
        NSString *path = [self itemArchivePath];

        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array had't been saved previously, create a new empty one
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
        
    }
    return self;
}
- (NSArray *)allItems {
    return [self.privateItems copy];
}

- (MYItem *)createItem {
//    MYItem *item = [[MYItem alloc] init];
    MYItem *item = [MYItem randomItem];
    [self.privateItems addObject:item];
    return item;
}


- (void)removeItem:(MYItem *)item {
    [self.privateItems removeObjectIdenticalTo:item];
}
- (void)moveItemAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    
    MYItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}




#pragma mark archive
- (NSString *)itemArchivePath {
    
    
    NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}





















@end
