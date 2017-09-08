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
@import IQKeyboardManager;

@interface CreateQRCodeViewController ()
@property (nonatomic,strong) NSMutableArray *createdList;
@property (nonatomic,strong) NSMutableArray *savedArray;
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
    NSData *arrayData = [[NSUserDefaults standardUserDefaults] objectForKey:@"CreatedList"];
    self.createdList = [[NSKeyedUnarchiver unarchiveObjectWithData:arrayData] mutableCopy];
    if(self.createdList == nil){
        self.createdList = [[NSMutableArray alloc] init];
    }
    [self.createdTableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"NotificationMessageEvent" object:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier  isEqualToString: @"showDetail"]){
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CreatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showCreatedList"];
    if(cell == nil){
        cell = [[CreatedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"showCreatedList"];
    }
    HistoryData *tmpData = [self.createdList objectAtIndex:indexPath.row];
    cell.createdCodeImageView.image = tmpData.myImage;
    cell.createdCodeDate.text = tmpData.resultTime;
    cell.createdCodeText.text = tmpData.resultText;
    cell.createdCodeTitle.text = tmpData.resultType;
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setHighlighted:NO animated:YES];
    return cell;
}
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(![tableView isEditing]){
        [self performSegueWithIdentifier:@"showDetail" sender:self];
    }
    [[tableView cellForRowAtIndexPath:indexPath] setFocusStyle:UITableViewCellFocusStyleCustom];
//    [[self.createdTableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Deselected");
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.mySearchBar setShowsCancelButton:NO animated:YES];
    self.mySearchBar.text = @"";
    [self.mySearchBar resignFirstResponder];
    self.createdList = self.savedArray;
    [self.createdTableView reloadData];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
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
    NSArray *tmpArray = (NSArray *)self.createdList;
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:tmpArray];
    [[NSUserDefaults standardUserDefaults] setObject:arrayData forKey:@"CreatedList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.createdTableView reloadData];
}

- (IBAction)editTableView:(id)sender {
    if([[(UIBarButtonItem *)sender title]  isEqual: @"Edit"]){
        [(UIBarButtonItem *)sender setTitle:@"Done"];
        [self.createdTableView setAllowsMultipleSelectionDuringEditing:true];
        [self.createdTableView setAllowsMultipleSelection:true];

        [self.createdTableView setEditing:YES animated:YES];
    }
    else{
        [(UIBarButtonItem *)sender setTitle:@"Edit"];
        [self.createdTableView setEditing:NO animated:YES];
    }
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

@end
