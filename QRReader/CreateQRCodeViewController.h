//
//  CreateQRCodeViewController.h
//  QRReader
//
//  Created by Muhammad Azher on 31/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreateQRCodeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (nonatomic,strong) NSString *checking;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myEditButton;
@property (weak, nonatomic) IBOutlet UITableView *createdTableView;
@property (weak, nonatomic) IBOutlet UIToolbar *myToolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *selectAllButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *noHistoryLabel;

- (IBAction)selectAllAction:(UIBarButtonItem *)sender;
- (IBAction)deleteAction:(UIBarButtonItem *)sender;

- (IBAction)editTableView:(id)sender;

@end
