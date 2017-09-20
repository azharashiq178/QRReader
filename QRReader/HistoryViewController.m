//
//  HistoryViewController.m
//  QRReader
//
//  Created by Muhammad Azher on 31/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "HistoryViewController.h"
#import "MyTabBarViewController.h"
#import <Contacts/Contacts.h>
#import <Foundation/Foundation.h>
#import "RegexKitLite.h"
#import <Messages/Messages.h>
#import <MessageUI/MessageUI.h>
#import "ViewController.h"
#import "HistoryTableViewCell.h"
#import "HistoryData.h"
#import "AppDelegate.h"
@import CoreData;


@interface HistoryViewController ()
@property (nonatomic,strong) NSMutableArray<HistoryData *> *resultArray;
@property (nonatomic,strong) NSMutableArray *personPhoneNumbers;
@property (nonatomic,strong) NSMutableArray *savedArray;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultArray = [[NSMutableArray<HistoryData *> alloc] init];
    self.savedArray = [[NSMutableArray alloc] init];
    [self.searchBar setDelegate:self];
    [self.historyTableView setDelegate:self];
    [self.historyTableView setDataSource:self];
    // Do any additional setup after loading the view.
//    [self.view bringSubviewToFront:self.myToolbar];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    if([(MyTabBarViewController *)self.tabBarController myResultString] != nil){
        [self performSegueWithIdentifier:@"showResult" sender:self];
    }
//    NSData *arrayData = [[NSUserDefaults standardUserDefaults] objectForKey:@"HistoryList"];
//    self.resultArray = [[NSKeyedUnarchiver unarchiveObjectWithData:arrayData] mutableCopy];
//    if(self.resultArray == nil){
        self.resultArray = [[NSMutableArray alloc] init];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ScanHistory"];
    
    //    self.createdList = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSMutableArray *tmpArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for(int i = 0 ;i < [tmpArray count]; i++){
        HistoryData *tmpHistory = [HistoryData new];
        tmpHistory.resultText = [[tmpArray objectAtIndex:i] resultText];
        tmpHistory.resultTime = [[tmpArray objectAtIndex:i] resultTime];
        tmpHistory.resultType = [[tmpArray objectAtIndex:i] valueForKey:@"resultType"];
        NSData *tmpBD = [[tmpArray objectAtIndex:i] valueForKey:@"myImage"];
        tmpHistory.myImage = [UIImage imageWithData:tmpBD];
        [self.resultArray addObject:tmpHistory];
        //        tmpHistory.myImage = [UIImage imageWithData:[[tmpArray objectAtIndex:i] myImage]];
    }
//    }
    [self.historyTableView reloadData];
    if([self.resultArray count]==0){
        [self.historyTableView setHidden:YES];
        [self.editButton setEnabled:NO];
        [self.noHistoryLabel setHidden:NO];
        [self.editButton setEnabled:NO];
        
    }
    else{
        [self.noHistoryLabel setHidden:YES];
        [self.historyTableView setHidden:NO];
        [self.editButton setEnabled:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(IBAction)sendMessage:(id)sender{
    NSLog(@"Message is sending");
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = self.personPhoneNumbers;
    NSString *message = [NSString stringWithFormat:@"Just sent the  file to your email. Please check!"];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
    
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar setShowsCancelButton:NO animated:YES];
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.searchBar setShowsCancelButton:YES animated:YES];
    [self.searchBar setShowsCancelButton:YES animated:YES];
    self.savedArray = self.resultArray;
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return NO;
}
- (UIImage *)imageFromCIImage:(CIImage *)ciImage {
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [ciContext createCGImage:ciImage fromRect:[ciImage extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier  isEqual: @"showResult"]){
        
        ViewController *destinationController = segue.destinationViewController;
        
        
        if([(MyTabBarViewController *)self.tabBarController myResultString] != nil){
            destinationController.tmpResult = [(MyTabBarViewController *)self.tabBarController myResultString];
            HistoryData *tmpData = [HistoryData new];
            tmpData.resultText = destinationController.tmpResult;
            NSDate *todayDate = [NSDate date]; //Get todays date
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date.
            [dateFormatter setDateFormat:@"dd/MM/yyyy"]; //Here we can set the format which we need
            NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
            tmpData.resultTime = convertedDateString;
            
            NSString *tmpStr = [NSString stringWithFormat:@"%@",tmpData.resultText];
            //    NSData *stringData = [tmpStr dataUsingEncoding: NSUTF8StringEncoding];
            NSData *stringData = [tmpStr dataUsingEncoding: NSISOLatin1StringEncoding];
            CIFilter *qrFilter;
            if([[(MyTabBarViewController *)self.tabBarController myType]  isEqual: @"QRCode"]){
                NSLog(@"QRCode");
                qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
            }
            else if ([[(MyTabBarViewController *)self.tabBarController myType]  isEqual: @"Bar Code"]){
                NSLog(@"Bar Code");
                qrFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
            }
            
            [qrFilter setValue:stringData forKey:@"inputMessage"];
            tmpData.myImage = [self imageFromCIImage:qrFilter.outputImage];
            
            NSError *errorVCF;
            
            NSArray  *allContacts = [CNContactVCardSerialization contactsWithData:[[(MyTabBarViewController *)self.tabBarController myResultString] dataUsingEncoding:NSUTF8StringEncoding] error:&errorVCF];
            if(!errorVCF){
                if([allContacts count] != 0){
                    tmpData.resultType = @"Contact";
                }
                else if ([self isTextURL:[(MyTabBarViewController *)self.tabBarController myResultString]]){
                    tmpData.resultType = @"URL";
                }
                else if ([self isTextPhoneNumber:[(MyTabBarViewController *)self.tabBarController myResultString]]){
                    tmpData.resultType = @"Phone Number";
                }
                else if([self isTextEmailAddress:[(MyTabBarViewController *)self.tabBarController myResultString]]){
                    tmpData.resultType = @"Email";
                }
                else{
                    tmpData.resultType = @"Plain Text";
                    NSLog(@"The String is not contact");
                }
                
            }
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
            NSManagedObject *device = [NSEntityDescription insertNewObjectForEntityForName:@"ScanHistory" inManagedObjectContext:context];
            [device setValue:tmpData.resultType forKey:@"resultType"];
            [device setValue:tmpData.resultTime forKey:@"resultTime"];
            [device setValue:tmpData.resultText forKey:@"resultText"];
            [device setValue:UIImagePNGRepresentation(tmpData.myImage) forKey:@"myImage"];
            NSError *error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
            else{
                NSLog(@"Data Saved");
            }
//            [self.resultArray addObject:tmpData];
//            NSArray *tmpArray = (NSArray *)self.resultArray;
//            NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:tmpArray];
//            [[NSUserDefaults standardUserDefaults] setObject:arrayData forKey:@"HistoryList"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else{
            destinationController.tmpResult = [[self.resultArray objectAtIndex:[[self.historyTableView indexPathForSelectedRow] row]] resultText];
            destinationController.myTitle = [[self.resultArray objectAtIndex:[[self.historyTableView indexPathForSelectedRow] row]] resultType];
        }
        
        [(MyTabBarViewController *)self.tabBarController setMyResultString:nil];
        //        [self presentViewController:destinationController animated:YES completion:nil];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.resultArray count];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *tmpView = [[UIView alloc] init];
    [tmpView setBackgroundColor:[UIColor blackColor]];
    return tmpView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    if(cell == nil){
        cell = [[HistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"historyCell"];
    }
    cell.result.text = [[self.resultArray objectAtIndex:indexPath.row] resultText];
    cell.timeAndDate.text = [[self.resultArray objectAtIndex:indexPath.row] resultTime];
    cell.typeOfResult.text = [[self.resultArray objectAtIndex:indexPath.row] resultType];
    cell.typeImageView.image = [[self.resultArray objectAtIndex:indexPath.row] myImage];
    if(cell.typeImageView.image == nil){
        NSLog(@"EMpty");
        NSData *stringData = [[[self.resultArray objectAtIndex:indexPath.row] resultText] dataUsingEncoding: NSISOLatin1StringEncoding];
        CIFilter *qrFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
        cell.typeImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
        cell.typeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    if(indexPath.row % 2 != 0){
        [cell setBackgroundColor:[UIColor colorWithRed:0.114 green:0.114 blue:0.114 alpha:1]];
    }
    else{
        [cell setBackgroundColor:[UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1]];
    }
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor clearColor];
    [cell setSelectedBackgroundView:bgColorView];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.deleteButton setEnabled:YES];
    if([[tableView indexPathsForSelectedRows] count] == [tableView numberOfRowsInSection:0]){
        self.selectAllButton.title = @"Deselect All";
    }
    NSLog(@"HEre");
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(![tableView isEditing]){
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self performSegueWithIdentifier:@"showResult" sender:self];
        return nil;
    }
    return indexPath;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectAllButton.title = @"Select All";
    NSLog(@"Deselecting");
    if([[tableView indexPathsForSelectedRows] count] == 0){
        [self.deleteButton setEnabled:NO];
    }
}
-(BOOL)isTextPhoneNumber:(NSString *)vCardString{
    //    For Detecting phone number
    
    NSString *myString = vCardString;
    
    NSString *myRegex = @"\\d{2}";
    
    NSRange range = [myString rangeOfString:myRegex options:NSRegularExpressionSearch];
    
    NSString *phoneNumber = nil;
    
    if (range.location != NSNotFound) {
        
        phoneNumber = [myString substringWithRange:range];
        return YES;
        
        //        NSLog(@"%@", phoneNumber);
        
    } else {
        
        NSLog(@"No phone number found");
        return NO;
    }
    return NO;
}
-(BOOL)isTextURL:(NSString *)vCardString{
    NSString * urlString = vCardString;
    NSArray *urls = [urlString componentsMatchedByRegex:@"https://[^\\s]*"];
    NSLog(@"urls: %@", urls);
    if([urls count] == 0){
        NSArray *urls1 = [urlString componentsMatchedByRegex:@"http://[^\\s]*"];
        if([urls1 count] == 0)
            return NO;
        else
            return YES;
    }
    else{
        return YES;
    }
}
-(BOOL)isTextEmailAddress:(NSString *)vCardString{
    ///For Detecting Email Adress
    NSString *regexString = @"([A-Za-z0-9_\\-\\.\\+])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]+)";
    
    // experimental search string containing emails
    NSString *searchString = vCardString;
    
    // track regex error
    NSError *error = NULL;
    
    // create regular expression
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:&error];
    
    // make sure there is no error
    if (!error) {
        
        // get all matches for regex
        NSArray *matches = [regex matchesInString:searchString options:0 range:NSMakeRange(0, searchString.length)];
        
        // loop through regex matches
        for (NSTextCheckingResult *match in matches) {
            
            // get the current text
            NSString *matchText = [searchString substringWithRange:match.range];
            
            NSLog(@"Extracted: %@", matchText);
            return YES;
        }
        
    }
    return NO;
}
- (IBAction)editAction:(id)sender {
    [self.historyTableView setSeparatorColor:[UIColor clearColor]];
    if([[(UIBarButtonItem *)sender title] isEqualToString:@"Edit"]){
        [(UIBarButtonItem *)sender setTitle:@"Done"];
        [self.historyTableView setAllowsMultipleSelectionDuringEditing:YES];
        
        self.tabBarController.tabBar.frame = CGRectMake(0, self.tabBarController.tabBar.frame.origin.y, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
        [self.myToolbar setHidden:YES];
        [UIView animateWithDuration:0.1
                              delay:0.1
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.tabBarController.tabBar.frame = CGRectMake(0, self.tabBarController.tabBar.frame.origin.y + 49, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             
                             self.tabBarController.tabBar.frame = CGRectMake(0, self.tabBarController.tabBar.frame.origin.y - 49, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
                             [self.myToolbar setHidden:NO];
                             
                             self.myToolbar.frame = CGRectMake(0, self.myToolbar.frame.origin.y + 44, self.myToolbar.frame.size.width, self.myToolbar.frame.size.height);
                             [self.myToolbar setHidden:NO];
                             [UIView animateWithDuration:0.1
                                                   delay:0.1
                                                 options: UIViewAnimationCurveEaseOut
                                              animations:^{
                                                  self.myToolbar.frame = CGRectMake(0, self.myToolbar.frame.origin.y - 44, self.myToolbar.frame.size.width, self.myToolbar.frame.size.height);
                                              }
                                              completion:^(BOOL finished){
                                              }];
                             [self.tabBarController.tabBar setHidden:YES];
                         }];
        [self.historyTableView setEditing:YES animated:YES];
    }
    else{
        [(UIBarButtonItem *)sender setTitle:@"Edit"];
        [self.historyTableView setEditing:NO animated:YES];
        
        [self.myToolbar setHidden:NO];
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationCurveEaseOut animations:^{
            self.myToolbar.frame = CGRectMake(0, self.myToolbar.frame.origin.y + 44, self.myToolbar.frame.size.width, self.myToolbar.frame.size.height);
        } completion:^(BOOL finished) {
            [self.myToolbar setHidden:YES];
            self.myToolbar.frame = CGRectMake(0, self.myToolbar.frame.origin.y - 44, self.myToolbar.frame.size.width, self.myToolbar.frame.size.height);
            
            self.tabBarController.tabBar.frame = CGRectMake(0, self.tabBarController.tabBar.frame.origin.y + 49, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
            [self.tabBarController.tabBar setHidden:NO];
            [UIView animateWithDuration:0.1
                                  delay:0.1
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 self.tabBarController.tabBar.frame = CGRectMake(0, self.tabBarController.tabBar.frame.origin.y - 49, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
                             }
                             completion:^(BOOL finished){
                             }];
            
        }];
    }
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] setShowsReorderControl:YES];
    [[self.historyTableView cellForRowAtIndexPath:indexPath ] setShowsReorderControl:YES];
    return YES;
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.row == 0){
//        return NO;
//    }
    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    accessoryButton.tag = indexPath.row;
    [accessoryButton addTarget:self action:@selector(editTitle:) forControlEvents:UIControlEventTouchDown];
    accessoryButton.tag = indexPath.row;
    [accessoryButton setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [[tableView cellForRowAtIndexPath:indexPath] setEditingAccessoryView:accessoryButton];
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}
-(IBAction)editTitle:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please Enter Type" message:@"Please Enter Type" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Please Enter type name";
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields.firstObject;
        
        HistoryData *tmpData = [self.resultArray objectAtIndex:sender.tag];
        
        tmpData.resultType = textField.text;
        
        [self.resultArray replaceObjectAtIndex:sender.tag withObject:tmpData];
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ScanHistory"];
        
        NSMutableArray *tmpArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
        
        [[tmpArray objectAtIndex:sender.tag] setValue:textField.text forKey:@"resultType"];
        
        NSError *error = nil;
        
        [context save:&error];
        
        if(error == nil){
            NSLog(@"Data saved");
        }
        
        [self.historyTableView reloadData];
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    NSLog(@"Editing Title");
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSMutableArray *filteredArray = [[NSMutableArray alloc] init];
    for(HistoryData *tmpData in self.savedArray){
        
        if([tmpData.resultText containsString:searchText] || [tmpData.resultType containsString:searchText]){
            [filteredArray addObject:tmpData];
            
        }
    }
    self.resultArray = filteredArray;
    if([self.searchBar.text  isEqualToString: @""]){
        self.resultArray = self.savedArray;
    }
    //    if([filteredArray count] == 0){
    //        self.createdList = self.savedArray;
    //    }
    [self.historyTableView reloadData];
    //    NSArray *results = [self.createdList valueForKey:@"resultText"];
    //    NSArray *results1 = [results filteredArrayUsingPredicate:predicate];
}
- (IBAction)selectAllAction:(UIBarButtonItem *)sender {
    if([sender.title  isEqual: @"Select All"]){
        [self.deleteButton setEnabled:YES];
        for(int i = 0 ;i < [self.historyTableView numberOfRowsInSection:0]; i++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.historyTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        sender.title = @"Deselect All";
    }
    else{
        [self.deleteButton setEnabled:NO];
        for(int i = 0 ;i < [self.historyTableView numberOfRowsInSection:0]; i++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.historyTableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        sender.title = @"Select All";
    }
}

- (IBAction)moveToAction:(UIBarButtonItem *)sender {
}

- (IBAction)deleteAction:(UIBarButtonItem *)sender {
    NSLog(@"Deleted objects are %@",[self.historyTableView indexPathsForSelectedRows]);
    NSArray *indexesArray = [self.historyTableView indexPathsForSelectedRows];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ScanHistory"];
    
    //    self.createdList = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSMutableArray *tmpArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for(int i = 0 ;i < [indexesArray count]; i++){
        [context deleteObject:[tmpArray objectAtIndex:[[indexesArray objectAtIndex:i] row]]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        else{
            NSLog(@"Deleted");
            indexesArray = [self.historyTableView indexPathsForSelectedRows];
            NSIndexPath *tmpIndexPath = [indexesArray objectAtIndex:i];
//            [self.historyTableView deleteRowsAtIndexPaths:@[tmpIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.resultArray removeObjectAtIndex:tmpIndexPath.row];
//            if([self.resultArray count] == 0){
//                [self.historyTableView setHidden:YES];
//            }
//            else{
//                [self.historyTableView setHidden:NO];
                [self.historyTableView reloadData];
//            }
            
        }
//        HistoryData *tmpData = [self.resultArray objectAtIndex:[[indexesArray objectAtIndex:i] row]];
//        NSManagedObject *device = [NSEntityDescription insertNewObjectForEntityForName:@"ScanHistory" inManagedObjectContext:context];
//        [device setValue:tmpData.resultType forKey:@"resultType"];
//        [device setValue:tmpData.resultTime forKey:@"resultTime"];
//        [device setValue:tmpData.resultText forKey:@"resultText"];
//        [device setValue:UIImagePNGRepresentation(tmpData.myImage) forKey:@"myImage"];
//        NSManagedObject *secondObject = [tmpArray objectAtIndex:[[indexesArray objectAtIndex:i] row]];
//        if([[secondObject valueForKey:@"resultType"] isEqual:[device valueForKey:@"resultType"]] && [[secondObject valueForKey:@"resultTime"] isEqual:[device valueForKey:@"resultTime"]] && [[secondObject valueForKey:@"resultText"] isEqual:[device valueForKey:@"resultText"]] && [[secondObject valueForKey:@"myImage"] isEqual:[device valueForKey:@"myImage"]]){
//            // Save the object to persistent store
//            [context deleteObject:secondObject];
//            [self.resultArray removeObjectAtIndex:[[indexesArray objectAtIndex:i] row]];
//        }
        
    }
    if([self.resultArray count] == 0){
        [self.historyTableView setHidden:YES];
        [self.noHistoryLabel setHidden:NO];
        [self editAction:self.editButton];
        [self.editButton setEnabled:NO];
    }
//    [self.historyTableView reloadData];
}
@end
