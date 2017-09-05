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



@interface HistoryViewController ()
@property (nonatomic,strong) NSMutableArray<HistoryData *> *resultArray;
@property (nonatomic,strong) NSMutableArray *personPhoneNumbers;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultArray = [[NSMutableArray<HistoryData *> alloc] init];
    [self.searchBar setDelegate:self];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    if([(MyTabBarViewController *)self.tabBarController myResultString] != nil){
        [self performSegueWithIdentifier:@"showResult" sender:self];
    }
    [self.historyTableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
//    self.personPhoneNumbers = [[NSMutableArray alloc] init];
//    NSLog(@"My REsult is %@",[(MyTabBarViewController *)self.tabBarController myResultString]);
//    self.tmpTextField.text = [(MyTabBarViewController *)self.tabBarController myResultString];
//    NSString *vCardString = self.tmpTextField.text;
//    NSError *errorVCF;
//    NSArray  *allContacts = [CNContactVCardSerialization contactsWithData:[vCardString dataUsingEncoding:NSUTF8StringEncoding] error:&errorVCF];
//    if (!errorVCF)
//    {
//        NSMutableString *results = [[NSMutableString alloc] init];
//        NSLog(@"AllContacts: %@", allContacts);
//        for (CNContact *aContact in allContacts)
//        {
//            if([aContact.phoneNumbers count]!=0){
//                UITextView *tmpTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, 150, 100)];
//                tmpTextView.text = [NSString stringWithFormat:@"%@",[[[aContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"digits"]];
//                [tmpTextView setTintColor:[UIColor redColor]];
//                [tmpTextView setDataDetectorTypes:UIDataDetectorTypeAll];
//                [tmpTextView setEditable:NO];
//                
////                [tmpLabel setBackgroundColor:[UIColor blackColor]];
//                [self.view addSubview:tmpTextView];
//                UIButton *messageButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 50, 50)];
//                [messageButton.layer setCornerRadius:25];
//                [messageButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchDown];
////                [messageButton setTitle:@"Message" forState:UIControlStateNormal];
//                [messageButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
//                [messageButton setTintColor:[UIColor whiteColor]];
//                [messageButton setBackgroundColor:[UIColor clearColor]];
//                [messageButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
//                [messageButton.layer setBorderWidth:1];
//                [self.view addSubview:messageButton];
//                for(int i = 0 ;i < [aContact.phoneNumbers count];i++){
//                    NSString *tmp = [[[aContact.phoneNumbers objectAtIndex:i] valueForKey:@"value"] valueForKey:@"digits"];
//                    [self.personPhoneNumbers addObject:tmp];
//                }
//            }
//            self.tmpTextField.text = [NSString stringWithFormat:@"%@ %@ %@",aContact.givenName,aContact.familyName,[[[aContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"digits"]];
//            
//        }
//        if([allContacts count] == 0){
//            //For detecting URL
//            NSString * urlString = vCardString;
//            NSArray *urls = [urlString componentsMatchedByRegex:@"https://[^\\s]*"];
//            NSLog(@"urls: %@", urls);
//            ////
//            
//            
//            //For Detecting phone number
//            NSString *myString = vCardString;
//            NSString *myRegex = @"\\d{11}";
//            NSRange range = [myString rangeOfString:myRegex options:NSRegularExpressionSearch];
//            
//            NSString *phoneNumber = nil;
//            if (range.location != NSNotFound) {
//                phoneNumber = [myString substringWithRange:range];
//                NSLog(@"%@", phoneNumber);
//            } else {
//                NSLog(@"No phone number found");
//            }
//            //////
//            
//            
//            ///For Detecting Email Adress
//            NSString *regexString = @"([A-Za-z0-9_\\-\\.\\+])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]+)";
//            
//            // experimental search string containing emails
//            NSString *searchString = vCardString;
//            
//            // track regex error
//            NSError *error = NULL;
//            
//            // create regular expression
//            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:&error];
//            
//            // make sure there is no error
//            if (!error) {
//                
//                // get all matches for regex
//                NSArray *matches = [regex matchesInString:searchString options:0 range:NSMakeRange(0, searchString.length)];
//                
//                // loop through regex matches
//                for (NSTextCheckingResult *match in matches) {
//                    
//                    // get the current text
//                    NSString *matchText = [searchString substringWithRange:match.range];
//                    
//                    NSLog(@"Extracted: %@", matchText);
//                    
//                }
//                
//            }
//        }
//        else
//            NSLog(@"Final: %@", results);
//    }
//    else{
//        NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
//        NSArray* matches = [detector matchesInString:vCardString options:0 range:NSMakeRange(0, [vCardString length])];
//    }
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
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return NO;
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
            
            [self.resultArray addObject:tmpData];
        }
        else{
            destinationController.tmpResult = [[self.resultArray objectAtIndex:[[self.historyTableView indexPathForSelectedRow] row]] resultText];
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    if(cell == nil){
        cell = [[HistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"historyCell"];
    }
    cell.result.text = [[self.resultArray objectAtIndex:indexPath.row] resultText];
    cell.timeAndDate.text = [[self.resultArray objectAtIndex:indexPath.row] resultTime];
    cell.typeOfResult.text = [[self.resultArray objectAtIndex:indexPath.row] resultType];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"showResult" sender:self];
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
@end
