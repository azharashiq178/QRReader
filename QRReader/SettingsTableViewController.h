//
//  SettingsTableViewController.h
//  QRReader
//
//  Created by ozimacmini9 on 06/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SettingsTableViewController : UITableViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *linkSwitch;
@property (weak, nonatomic) IBOutlet UILabel *browserName;
@property (weak, nonatomic) IBOutlet UISwitch *laserSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *vibrateSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *beepSwitch;
- (IBAction)deleteAction:(UISwitch *)sender;

@end
