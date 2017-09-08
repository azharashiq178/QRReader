//
//  CreatedTableViewCell.h
//  QRReader
//
//  Created by ozimacmini9 on 07/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *createdCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *createdCodeTitle;
@property (weak, nonatomic) IBOutlet UILabel *createdCodeText;
@property (weak, nonatomic) IBOutlet UILabel *createdCodeDate;

@end
