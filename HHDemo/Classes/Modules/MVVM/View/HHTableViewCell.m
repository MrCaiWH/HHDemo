//
//  HHTableViewCell.m
//  HHDemo
//
//  Created by zero on 2017/8/24.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHTableViewCell.h"
#import "HHPlayModel.h"

@implementation HHTableViewCell

+(NSString *)identifier
{
    return [NSString stringWithUTF8String:object_getClassName([self class])];
}

#pragma mark - Intial Methods

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setNeedsUpdateConstraints];
        [self updateConstraints];
    }
    return self;
}

- (void)setModel:(HHPlayModel *)model {
    
    _model = model;
    
    self.textLabel.text = model.streamname;
}

@end
