//
//  GeneralSettingsViewController.h
//  QRReader
//
//  Created by ozimacmini9 on 06/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralSettingsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;
@property (nonatomic,strong) NSString *typeOfGeneralSetting;
@end
