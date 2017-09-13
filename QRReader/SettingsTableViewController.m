//
//  SettingsTableViewController.m
//  QRReader
//
//  Created by ozimacmini9 on 06/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "GeneralSettingsViewController.h"
#import <StoreKit/StoreKit.h>
@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.linkSwitch.offImage = [UIImage imageNamed:@"on"];
    [self.linkSwitch setOnImage:[UIImage imageNamed:@"on.png"]];
//    self.linkSwitch.onImage = [UIImage imageNamed:@"check.png"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    GeneralSettingsViewController *viewController = segue.destinationViewController;
    if([segue.identifier  isEqualToString: @"Language"]){
        viewController.typeOfGeneralSetting = @"Language";
    }
    else if([segue.identifier  isEqualToString: @"Date"]){
        viewController.typeOfGeneralSetting = @"Date";
    }
    if([segue.identifier  isEqualToString: @"Browser"]){
        viewController.typeOfGeneralSetting = @"Browser";
    }
    if([segue.identifier  isEqualToString: @"Sound"]){
        viewController.typeOfGeneralSetting = @"Sound";
    }
    NSLog(@"Preparing for segue");
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"You selected row %d in section %d",indexPath.row,indexPath.section);
    if(indexPath.row == 0 && indexPath.section == 4){
        if([MFMessageComposeViewController canSendText]) {
            NSString *message = [NSString stringWithFormat:@"Hey..!!! Check out this cool app on App Store. Link is ==> https://itunes.apple.com/gb/app/compass-free/id284735786?mt=8"];
            
            MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
            messageController.messageComposeDelegate = self;
//            [messageController setRecipients:recipents];
            [messageController setBody:message];
            
            // Present message view controller on screen
            [self presentViewController:messageController animated:YES completion:nil];
        }
    }
    else if(indexPath.row == 1 && indexPath.section == 4){
        if ([MFMailComposeViewController canSendMail]) {
            //Your code will go here
            MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
            mailVC.mailComposeDelegate = self;
            [mailVC setSubject:@"Error reporting"];
            [mailVC setToRecipients:@[@"azharashiq178@gmail.com"]];
            [mailVC setMessageBody:@"Testing" isHTML:NO];
            [self presentViewController:mailVC animated:YES completion:nil];
        } else {
            //This device cannot send email
        }
    }
    else if(indexPath.row == 2 && indexPath.section == 4){
        if([SKStoreReviewController class]){
            [SKStoreReviewController requestReview];
            
        }
    }
    else if(indexPath.row == 3 && indexPath.section == 4){
        SKStoreProductViewController* spvc = [[SKStoreProductViewController alloc] init];
        [spvc loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @284417353}
                        completionBlock:nil];
        spvc.delegate = self;
        [self presentViewController:spvc animated:YES completion:nil];
    }
    else if(indexPath.row == 2 && indexPath.section == 2){
//        if ([[UIApplication sharedApplication] canOpenURL:
//             [NSURL URLWithString:@"googlechrome://"]])
//        {
//            NSLog(@"Yes app can open chrome url");
//        }
//        else{
//            NSLog(@"Noped app can't open chrom url");
//        }
    }
    
}
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"Email Sent");
            //Email sent
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Email Saved");
            //Email saved
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"Email Cancel");
            //Handle cancelling of the email
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Email failed");
            //Handle failure to send.
            break;
        default:
            //A failure occurred while completing the email
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
