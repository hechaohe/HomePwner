//
//  MYItem.m
//  MyHomePwner
//
//  Created by hc on 2017/3/6.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "MYItem.h"

@interface MYItem ()
@property (nonatomic,strong) NSDate *dateCreated;

@end

@implementation MYItem

+(id)randomItem {
    NSArray *randomAdjectiveList = @[@"Fluffy",@"Rusty",@"Shiny"];
    NSArray *randomNunList = @[@"Bear",@"Spork",@"Mac"];
    
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
    NSInteger nounIndex = rand() % [randomNunList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",randomAdjectiveList[adjectiveIndex],randomNunList[nounIndex]];
    int randomValue = rand() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c",
                                    '0' + rand() % 10,
                                    'A' + rand() % 10];
    MYItem *newItem = [[self alloc] initWithItemName:randomName valueInDollors:randomValue serialNumber:randomSerialNumber];
    return newItem;
}
- (instancetype)initWithItemName:(NSString *)name valueInDollors:(int)value serialNumber:(NSString *)sNumber {

    self = [super init];
    if (self) {
        self.name = name;
        self.serialNumber = sNumber;
        self.valueInDollars = value;
        self.dateCreated = [[NSDate alloc] init];
        
        
        //create a nsuuid object   and get its string representation
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
        
        
        
        
    }
    return self;
}

-(instancetype)init {
    return [self initWithItemName:@"MoRen" valueInDollors:0 serialNumber:@"0A"];
}
- (NSString *)description {
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@):Worth $%d,recorded on %@",self.name,self.serialNumber,self.valueInDollars,self.dateCreated];
    return descriptionString;
}
- (void)dealloc {
    NSLog(@"Destroyed:%@",self);
}

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
    [aCoder encodeObject:self.thumbnail forKey:@"thumbnail"];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        _valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
        _thumbnail = [aDecoder decodeObjectForKey:@"thumbnail"];
    }
    return self;
}




#pragma mark Thumbnail
- (void)setThumbnailFromImage:(UIImage *)image {
    CGSize origImageSize = image.size;
    
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    
    float ratio = MAX(newRect.size.width / origImageSize.width, newRect.size.height / origImageSize.height);
    
    //create a transparent bitmap context with a scaling factor
    //equal to that of the screen
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    //Create a path that is a rounded ractangle
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    
    //Center the image in the thumbnail rectangle
    CGRect projectRect;
    projectRect.size.width = ratio *origImageSize.width;
    projectRect.size.height = ratio *origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    //Draw the image on it
    [image drawInRect:projectRect];
    
    //Get the image from the image context;keep it as our thumbnail
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    
    //Cleanup image context resources;we're done
    UIGraphicsEndImageContext();
    
}
















































@end
