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



@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"My REsult is %@",[(MyTabBarViewController *)self.tabBarController myResultString]);
    self.tmpTextField.text = [(MyTabBarViewController *)self.tabBarController myResultString];
    NSString *vCardString = self.tmpTextField.text;
    NSError *errorVCF;
    NSArray  *allContacts = [CNContactVCardSerialization contactsWithData:[vCardString dataUsingEncoding:NSUTF8StringEncoding] error:&errorVCF];
    if (!errorVCF)
    {
        NSMutableString *results = [[NSMutableString alloc] init];
        NSLog(@"AllContacts: %@", allContacts);
        for (CNContact *aContact in allContacts)
        {
            self.tmpTextField.text = [NSString stringWithFormat:@"%@ %@ %@",aContact.givenName,aContact.familyName,[[[aContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"digits"]];
//            self.tmpTextField.text = [NSString stringWithFormat:@"%@",aContact];
//            NSArray *phonesNumbers = [aContact phoneNumbers];
//            for (CNLabeledValue *aValue in phonesNumbers)
//            {
//                CNPhoneNumber *phoneNumber = [aValue value];
//                [results appendFormat:@"%@ %@\n", [aValue label], [phoneNumber stringValue]];
//            }
        }
        if([allContacts count] == 0){
            //For detecting URL
            NSString * urlString = vCardString;
            NSArray *urls = [urlString componentsMatchedByRegex:@"https://[^\\s]*"];
            NSLog(@"urls: %@", urls);
            ////
            
            
            //For Detecting phone number
            NSString *myString = vCardString;
            NSString *myRegex = @"\\d{11}";
            NSRange range = [myString rangeOfString:myRegex options:NSRegularExpressionSearch];
            
            NSString *phoneNumber = nil;
            if (range.location != NSNotFound) {
                phoneNumber = [myString substringWithRange:range];
                NSLog(@"%@", phoneNumber);
            } else {
                NSLog(@"No phone number found");
            }
            //////
            
            
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
                    
                }
                
            }
        }
        else
            NSLog(@"Final: %@", results);
    }
    else{
        NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray* matches = [detector matchesInString:vCardString options:0 range:NSMakeRange(0, [vCardString length])];
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

@end
