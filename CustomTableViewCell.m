//
//  CustomTableViewCell.m
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 26/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_customCellImage release];
    [_customCellFirstLabel release];
    [_customCellSecondLabel release];
    [super dealloc];
}
@end
