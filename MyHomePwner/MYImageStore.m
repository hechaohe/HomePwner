//
//  MYImageStore.m
//  MyHomePwner
//
//  Created by hc on 2017/3/7.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "MYImageStore.h"

@interface MYImageStore ()
@property (nonatomic,strong) NSMutableDictionary *dictionary;
- (NSString *)imagePathForKey:(NSString *)key;

@end


@implementation MYImageStore

+ (instancetype)sharedStore {
    static MYImageStore *sharedStore;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[MYImageStore sharedStore]" userInfo:nil];
    return nil;
}
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        
        // claer cache
        
        
    }
    return self;
}







- (NSString *)imagePathForKey:(NSString *)key {
    NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return [documentDirectory stringByAppendingPathComponent:key];
}


- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    
    self.dictionary[key] = image;
    
    //
    NSString *imagePath = [self imagePathForKey:key];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    [data writeToFile:imagePath atomically:YES];
    
    
    NSLog(@"%@",imagePath);
    
}
- (UIImage *)imageForKey:(NSString *)key {
    //如果有图片，从文件中获取
    UIImage *result = self.dictionary[key];
    
    if (!result) {
        NSString *imagePath = [self imagePathForKey:key];
        
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        if (result) {
            self.dictionary[key] = result;
        } else {
            NSLog(@"Error:unable to find %@",imagePath);
        }
    }
    return result;
    
    
    
    
}
- (void)deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:NULL];
}

@end
