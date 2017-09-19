//
//  HistoryViewController.h
//  QRReader
//
//  Created by Muhammad Azher on 31/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Messages/Messages.h>

@interface HistoryViewController : UIViewController <MFMessageComposeViewControllerDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *tmpTextField;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
- (IBAction)editAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UILabel *noHistoryLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *myToolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *selectAllButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;

- (IBAction)selectAllAction:(UIBarButtonItem *)sender;
- (IBAction)moveToAction:(UIBarButtonItem *)sender;
- (IBAction)deleteAction:(UIBarButtonItem *)sender;

@end
