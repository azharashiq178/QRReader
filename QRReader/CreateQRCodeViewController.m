//
//  CreateQRCodeViewController.m
//  QRReader
//
//  Created by Muhammad Azher on 31/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "CreateQRCodeViewController.h"
#import <Contacts/Contacts.h>
#import "SWRevealViewController.h"
#import "CreatedTableViewCell.h"
#import "CreateCodeWithTypeVC.h"
#import "HistoryData.h"
#import "ShowCreatedCodeViewController.h"
#import "SCSQLite.h"
#import "AppDelegate.h"
@import IQKeyboardManager;

@interface CreateQRCodeViewController ()
@property (nonatomic,strong) NSMutableArray *createdList;
@property (nonatomic,strong) NSMutableArray *savedArray;
@property (nonatomic,strong) NSString *titleToPassNext;
@property (nonatomic,strong) NSString *dataToPassNext;
@property (nonatomic,strong) UIImage *imageToPassNext;
@end

@implementation CreateQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.createdList = [[NSMutableArray alloc] init];
    self.savedArray = [[NSMutableArray alloc] init];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self.mySearchBar setDelegate:self];
    
    
    
    
// *************************************** Creating QRCode ****************
//    NSString *qrString = @"Hello My Name is Muhammad Azher";
//    CNMutableContact *tmpContact = [CNMutableContact new];
//    tmpContact.familyName = @"Ashiq";
//    NSString *tmpStr = [NSString stringWithFormat:@"%@",tmpContact];
//    //    NSData *stringData = [tmpStr dataUsingEncoding: NSUTF8StringEncoding];
//    NSData *stringData = [tmpStr dataUsingEncoding: NSISOLatin1StringEncoding];
//    
//    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [qrFilter setValue:stringData forKey:@"inputMessage"];
//    
//    self.qrImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
//
//
//    *************************************************************************
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"MY CHECKING IS %@",self.checking);
//    NSData *arrayData = [[NSUserDefaults standardUserDefaults] objectForKey:@"CreatedList"];
//    self.createdList = [[NSKeyedUnarchiver unarchiveObjectWithData:arrayData] mutableCopy];
//    NSArray *tmp = [SCSQLite selectRowSQL:@"SELECT * FROM QRReader"];
//    if(self.createdList == nil){
        self.createdList = [[NSMutableArray alloc] init];
//    }
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"History"];
//    self.createdList = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSMutableArray *tmpArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for(int i = 0 ;i < [tmpArray count]; i++){
        HistoryData *tmpHistory = [HistoryData new];
        tmpHistory.resultText = [[tmpArray objectAtIndex:i] resultText];
        tmpHistory.resultTime = [[tmpArray objectAtIndex:i] resultTime];
        tmpHistory.resultType = [[tmpArray objectAtIndex:i] valueForKey:@"resultType"];
        NSData *tmpBD = [[tmpArray objectAtIndex:i] valueForKey:@"myImage"];
        tmpHistory.myImage = [UIImage imageWithData:tmpBD];
        [self.createdList addObject:tmpHistory];
//        tmpHistory.myImage = [UIImage imageWithData:[[tmpArray objectAtIndex:i] myImage]];
    }
    
//////*********
//    for(int i = 0 ;i < [tmp count] ;i++){
//        HistoryData *tmpData = [HistoryData new];
//        tmpData.resultType = [[tmp objectAtIndex:i] valueForKey:@"TypeOfCode"];
//        tmpData.resultText = [[tmp objectAtIndex:i] valueForKey:@"DataOfCode"];
//        tmpData.resultTime = [[tmp objectAtIndex:i] valueForKey:@"DateOfCode"];
//        NSData *tmpData1 = [[tmp objectAtIndex:i] valueForKey:@"ImageOfCode"];
//        tmpData.myImage = [UIImage imageWithData:[tmpData1 bytes]];
//        
////        tmpData.myImage = [[UIImage alloc] initWithData:[[NSData alloc] initWithBytes:CFBridgingRetain(tmpData1) length:tmpData1.length]];
//        [self.createdList addObject:tmpData];
//    }
//*************
//    self.createdList = [tmp mutableCopy];
    [self.createdTableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"NotificationMessageEvent" object:nil];
    if([self.createdList count]==0){
        [self.createdTableView setHidden:YES];
        [self.myEditButton setEnabled:NO];
        [self.noHistoryLabel setHidden:NO];
        [self.myEditButton setEnabled:NO];
        
    }
    else{
        [self.noHistoryLabel setHidden:YES];
        [self.createdTableView setHidden:NO];
        [self.myEditButton setEnabled:YES];
        
    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier  isEqualToString: @"showDetail"]){
        ShowCreatedCodeViewController *controller = segue.destinationViewController;
        [controller.navigationItem setTitle:self.titleToPassNext];
        controller.createdDataString = self.dataToPassNext;
        controller.myQrCodeImage = self.imageToPassNext;
        
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([tableView isEditing]) {
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    }
//    
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CreatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showCreatedList"];
    if(cell == nil){
        cell = [[CreatedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"showCreatedList"];
    }
    HistoryData *tmpData = [self.createdList objectAtIndex:indexPath.row];
    cell.createdCodeImageView.image = tmpData.myImage;
    if(tmpData.myImage == nil){
        NSData *stringData = [tmpData.resultText dataUsingEncoding: NSISOLatin1StringEncoding];
        CIFilter *qrFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
        cell.createdCodeImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
        cell.createdCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    cell.createdCodeDate.text = NSLocalizedString(tmpData.resultTime, nil);
    cell.createdCodeText.text = NSLocalizedString(tmpData.resultText,nil);
    cell.createdCodeTitle.text = NSLocalizedString(tmpData.resultType,nil);
    if(indexPath.row % 2 != 0){
        [cell setBackgroundColor:[UIColor colorWithRed:0.114 green:0.114 blue:0.114 alpha:1]];
    }
    else{
        [cell setBackgroundColor:[UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1]];
    }
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor clearColor];
    [cell setSelectedBackgroundView:bgColorView];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
//-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.createdList count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
//-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [[self.createdTableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
//    return indexPath;
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *tmpView = [[UIView alloc] init];
    [tmpView setBackgroundColor:[UIColor blackColor]];
    return tmpView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(![tableView isEditing]){
        CreatedTableViewCell *cell = (CreatedTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.dataToPassNext = [NSString stringWithFormat:@"%@",[[cell createdCodeText] text]];
        self.titleToPassNext = [NSString stringWithFormat:@"%@",[[cell createdCodeTitle] text]];
//        self.imageToPassNext = [[cell createdCodeImageView] image];
        self.imageToPassNext = [[self.createdList objectAtIndex:indexPath.row] myImage];
        [self performSegueWithIdentifier:@"showDetail" sender:self];
    }
    else{
        [self.deleteButton setEnabled:YES];
        if([[tableView indexPathsForSelectedRows] count] == [tableView numberOfRowsInSection:0]){
            self.selectAllButton.title = @"Deselect All";
        }
//        [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
//        //    [[tableView cellForRowAtIndexPath:indexPath] setShowsReorderControl:YES];
//        [[tableView cellForRowAtIndexPath:indexPath] setEditing:YES animated:YES];
    }
    
//    [[tableView cellForRowAtIndexPath:indexPath] setFocusStyle:UITableViewCellFocusStyleCustom];
//    [[self.createdTableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
}
-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleBlue];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [[tableView cellForRowAtIndexPath:indexPath] setEditing:NO animated:YES];
//    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
//    [[tableView cellForRowAtIndexPath:indexPath] setEditing:YES animated:YES];
    return indexPath;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectAllButton.title = @"Select All";
    NSLog(@"Deselecting");
    if([[tableView indexPathsForSelectedRows] count] == 0){
        [self.deleteButton setEnabled:NO];
    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.mySearchBar setShowsCancelButton:NO animated:YES];
    self.mySearchBar.text = @"";
    
    [self.mySearchBar resignFirstResponder];
    [self.myEditButton setEnabled:YES];
    self.createdList = self.savedArray;
    [self.createdTableView reloadData];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.myEditButton setEnabled:NO];
    if([self.createdTableView isEditing]){
        [self editTableView:self];
    }
    [self.mySearchBar setShowsCancelButton:YES animated:YES];
    self.savedArray = self.createdList;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    NSMutableArray *filteredArray = [[NSMutableArray alloc] init];
    for(HistoryData *tmpData in self.savedArray){
        if([tmpData.resultText containsString:searchText] || [tmpData.resultType containsString:searchText]){
            [filteredArray addObject:tmpData];
        }
    }
    self.createdList = filteredArray;
    if([self.mySearchBar.text  isEqualToString: @""]){
        self.createdList = self.savedArray;
    }
//    if([filteredArray count] == 0){
//        self.createdList = self.savedArray;
//    }
    [self.createdTableView reloadData];
//    NSArray *results = [self.createdList valueForKey:@"resultText"];
//    NSArray *results1 = [results filteredArrayUsingPredicate:predicate];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return NO;
}
//-(void) receiveTestNotification:(NSNotification*)notification
//{
//    if ([notification.name isEqualToString:@"TestNotification"])
//    {
//        
//        NSDictionary* userInfo = notification.userInfo;
//        NSNumber* total = (NSNumber*)userInfo[@"total"];
//        NSLog (@"Successfully received test notification! %i", total.intValue);
//    }
//}
#pragma mark - Notification
-(void) triggerAction:(NSNotification *) notification
{
    NSDictionary *dict = notification.userInfo;
    HistoryData *message = [dict valueForKey:@"total"];
    [self.createdList addObject:message];
//    NSData *tmpData = UIImageJPEGRepresentation(message.myImage, 0.9);
    UIImage *tmpImg = message.myImage;

    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
    NSManagedObject *device = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:context];
    [device setValue:message.resultType forKey:@"resultType"];
    [device setValue:message.resultTime forKey:@"resultTime"];
    [device setValue:message.resultText forKey:@"resultText"];
    [device setValue:UIImagePNGRepresentation(tmpImg) forKey:@"myImage"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else{
        NSLog(@"Data Saved");
        [self.createdTableView setHidden:NO];
        [self.noHistoryLabel setHidden:YES];
        [self.myEditButton setEnabled:YES];
    }
    
//    NSArray *tmpArray = (NSArray *)self.createdList;
//    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:tmpArray];
//    [[NSUserDefaults standardUserDefaults] setObject:arrayData forKey:@"CreatedList"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.createdTableView reloadData];
}

//- (UIImage *)imageFromCIImage:(CIImage *)ciImage {
//    CIContext *ciContext = [CIContext contextWithOptions:nil];
//    CGImageRef cgImage = [ciContext createCGImage:ciImage fromRect:[ciImage extent]];
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    CGImageRelease(cgImage);
//    return image;
//}
- (IBAction)selectAllAction:(UIBarButtonItem *)sender {
    if([sender.title  isEqual: @"Select All"]){
        [self.deleteButton setEnabled:YES];
        for(int i = 0 ;i < [self.createdTableView numberOfRowsInSection:0]; i++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.createdTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        sender.title = @"Deselect All";
    }
    else{
        [self.deleteButton setEnabled:NO];
        for(int i = 0 ;i < [self.createdTableView numberOfRowsInSection:0]; i++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.createdTableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        sender.title = @"Select All";
    }
}

- (IBAction)deleteAction:(UIBarButtonItem *)sender {
    NSArray *indexesArray = [self.createdTableView indexPathsForSelectedRows];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [[delegate persistentContainer] viewContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"History"];
    
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
            indexesArray = [self.createdTableView indexPathsForSelectedRows];
            NSIndexPath *tmpIndexPath = [indexesArray objectAtIndex:i];
            //            [self.historyTableView deleteRowsAtIndexPaths:@[tmpIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.createdList removeObjectAtIndex:tmpIndexPath.row];
            [self.createdTableView reloadData];
        }
    }
    if([self.createdList count] == 0){
        [self.createdTableView setHidden:YES];
        [self.noHistoryLabel setHidden:NO];
        [self editTableView:self.myEditButton];
        [self.myEditButton setEnabled:NO];
    }
}

- (IBAction)editTableView:(id)sender {
//    if([[self.myEditButton title]  isEqual: @"Edit"]){
//        
//        
//    
//        [self.myEditButton setTitle:@"Done"];
//        [self.createdTableView setAllowsMultipleSelectionDuringEditing:true];
////        [self.createdTableView setAllowsMultipleSelection:true];
//
//        [self.createdTableView setEditing:YES animated:YES];
//    }
//    else{
//        [self.myEditButton setTitle:@"Edit"];
////        [(UIBarButtonItem *)sender setTitle:@"Edit"];
//        if([self.createdTableView isEditing]){
//            NSArray *allSelectedIndex = [self.createdTableView indexPathsForSelectedRows];
//            for(int i = 0 ;i < [allSelectedIndex count] ;i++){
//                NSIndexPath *tmpIndexPath = [allSelectedIndex objectAtIndex:i];
//                [self.createdTableView deselectRowAtIndexPath:tmpIndexPath animated:YES];
////                [[self.createdTableView cellForRowAtIndexPath:tmpIndexPath] setSelected:NO];
//                [[self.createdTableView cellForRowAtIndexPath:tmpIndexPath] setSelectionStyle:UITableViewCellSelectionStyleBlue];
//            }
//        }
//        [self.createdTableView setEditing:NO animated:YES];
//        
//    }
    
    if([[(UIBarButtonItem *)sender title] isEqualToString:NSLocalizedString(@"Edit", nil)]){
        [(UIBarButtonItem *)sender setTitle:NSLocalizedString(@"Done", nil)];
        [self.createdTableView setAllowsMultipleSelectionDuringEditing:YES];
        
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
        [self.createdTableView setEditing:YES animated:YES];
    }
    else{
        [(UIBarButtonItem *)sender setTitle:NSLocalizedString(@"Edit", nil)];
        [self.createdTableView setEditing:NO animated:YES];
        
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
    return YES;
}

@end
