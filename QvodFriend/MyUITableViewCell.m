//
//  MyUITableViewCell.m
//  QShake
//
//  Created by douzifly on 13-10-13.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "MyUITableViewCell.h"

@implementation MyUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [super layoutSubviews];
//    CGRect rect = self.imageView.frame;
//    rect.size.height = 35;
//    rect.size.width = 35;
//    rect.origin.x = 4;
//    rect.origin.y = 4;
//    self.imageView.frame = rect;
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//   
//    CGFloat txtX = rect.origin.x +  rect.size.width + 4;
//    CGRect tmpFrame = self.textLabel.frame;
//    tmpFrame.origin.x = txtX;
//    self.textLabel.frame = tmpFrame;
//    
//    tmpFrame = self.detailTextLabel.frame;
//    tmpFrame.origin.x = txtX;
//    self.detailTextLabel.frame = tmpFrame;
}
@end
