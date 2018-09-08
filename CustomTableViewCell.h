//
//  CustomTableViewCell.h
//  My Student Space
//
//  Created by Mahdi Amirmazaheri on 26/10/2015.
//  Copyright © 2015 Mohamadmahdi Amirmazaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *customCellImage;

@property (retain, nonatomic) IBOutlet UILabel *customCellFirstLabel;

@property (retain, nonatomic) IBOutlet UILabel *customCellSecondLabel;

@end
