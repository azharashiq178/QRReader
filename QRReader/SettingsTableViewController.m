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
#import "AppDelegate.h"
@import GoogleMobileAds;
@interface SettingsTableViewController ()
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.interstitial = [self createAndLoadInterstitial];
    self.linkSwitch.offImage = [UIImage imageNamed:@"on"];
    [self.linkSwitch setOnImage:[UIImage imageNamed:@"on.png"]];
    [self.linkSwitch addTarget:self action:@selector(didSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.laserSwitch addTarget:self action:@selector(didSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.vibrateSwitch addTarget:self action:@selector(didSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.beepSwitch addTarget:self action:@selector(didSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    
    
//    self.linkSwitch.onImage = [UIImage imageNamed:@"check.png"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    self.linkSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"link"];
    self.laserSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"laser"];
    self.vibrateSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"Vibrate"];
    self.beepSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"Beep"];
    self.historySwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"delete"];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"Browser"]){
        self.browserName.text = @"Chrome";
    }
    else{
        self.browserName.text = @"Safari";
    }
    NSDate *todayDate = [NSDate date]; //Get todays date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date.
    //            [dateFormatter setDateFormat:@"dd-MM-yyyy"]; //Here we can set the format which we need
    NSString *myFormatter = [[NSUserDefaults standardUserDefaults] objectForKey:@"Date"];
    [dateFormatter setDateFormat:myFormatter];
    NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];
    self.dateLabel.text = convertedDateString;
}
-(IBAction)didSwitchChanged:(UISwitch *)sender{
    if(sender == self.linkSwitch){
//        if([sender isOn]){
            [[NSUserDefaults standardUserDefaults] setBool:[sender isOn] forKey:@"link"];
            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//        NSLog(@"%hhd",sender.isOn);
    }
    else if (sender == self.laserSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:[sender isOn] forKey:@"laser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if (sender == self.vibrateSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:[sender isOn] forKey:@"Vibrate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if (sender == self.beepSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:[sender isOn] forKey:@"Beep"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
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
            NSString *message = [NSString stringWithFormat:@"Hey..!!! Check out Bar Code Scanner: QR Reade cool app on App Store."];
            
            MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
            messageController.messageComposeDelegate = self;
//            [messageController setRecipients:recipents];
            [messageController setBody:message];
            
            // Present message view controller on screen
            [self presentViewController:messageController animated:YES completion:nil];
        }
    }
//    else if(indexPath.row == 1 && indexPath.section == 4){
//        if ([MFMailComposeViewController canSendMail]) {
//            //Your code will go here
//            MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
//            mailVC.mailComposeDelegate = self;
//            [mailVC setSubject:@"Error reporting"];
//            [mailVC setToRecipients:@[@"azharashiq178@gmail.com"]];
//            [mailVC setMessageBody:@"Testing" isHTML:NO];
//            [self presentViewController:mailVC animated:YES completion:nil];
//        } else {
//            //This device cannot send email
//        }
//    }
    else if(indexPath.row == 1 && indexPath.section == 4){
        if([SKStoreReviewController class]){
            [SKStoreReviewController requestReview];
            
        }
    }
    else if(indexPath.row == 2 && indexPath.section == 4){
        SKStoreProductViewController* spvc = [[SKStoreProductViewController alloc] init];
        [spvc loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @1258137713}
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
    self.interstitial = [self createAndLoadInterstitial];
//    if([self.interstitial isReady]){
//        [self.interstitial presentFromRootViewController:self];
//    }
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
- (IBAction)deleteAction:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:@"delete"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if(!sender.isOn){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure to delete History?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [sender setOn:true];
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"delete"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self deleteFromCoreDataWithEntityNamed:@"ScanHistory"];
            [self deleteFromCoreDataWithEntityNamed:@"History"];
            [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"delete"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIAlertController *okController = [UIAlertController alertControllerWithTitle:@"Deleted" message:@"Data Deleted From App History" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [okController dismissViewControllerAnimated:YES completion:nil];
                self.interstitial = [self createAndLoadInterstitial];
            }];
            [okController addAction:cancelAction1];
            [self presentViewController:okController animated:YES completion:nil];
        }];
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
-(void)deleteFromCoreDataWithEntityNamed:(NSString *)entity{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity];
    
    //    self.createdList = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSMutableArray *tmpArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for(int i = 0 ;i < [tmpArray count] ;i++){
        [context deleteObject:[tmpArray objectAtIndex:i]];
    }
    NSError *error = nil;
    [context save:&error];
    if(error != nil){
        NSLog(@"Data Not Deleted");
    }
    else{
        NSLog(@"Data Deleted");
    }
}
- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-6412217023250030/5400491687"];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}
- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    //    self.interstitial = [self createAndLoadInterstitial];
}
/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    [self.interstitial presentFromRootViewController:self];
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
}
/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
}
@end
