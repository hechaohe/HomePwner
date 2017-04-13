//
//  MYItemCell.m
//  MyHomePwner
//
//  Created by hc on 2017/3/8.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "MYItemCell.h"

@implementation MYItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)tapImage:(id)sender {
    !self.tapImageBlock ? : self.tapImageBlock();
}

@end
