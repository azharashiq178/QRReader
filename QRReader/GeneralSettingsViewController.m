//
//  GeneralSettingsViewController.m
//  QRReader
//
//  Created by ozimacmini9 on 06/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "GeneralSettingsViewController.h"

@interface GeneralSettingsViewController ()
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation GeneralSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//*********************** Open URL in Google chrome ******************
//
//
//
//    if([[UIApplication sharedApplication] canOpenURL:
//        [NSURL URLWithString:@"googlechrome://www.google.com"]]){
//            NSURL *inputURL = [NSURL URLWithString:@"https://www.facebook.com"];
//            NSString *scheme = inputURL.scheme;
//        
//            // Replace the URL Scheme with the Chrome equivalent.
//            NSString *chromeScheme = nil;
//            if ([scheme isEqualToString:@"http"]) {
//                chromeScheme = @"googlechrome";
//            } else if ([scheme isEqualToString:@"https"]) {
//                chromeScheme = @"googlechromes";
//            }
//        
//            // Proceed only if a valid Google Chrome URI Scheme is available.
//            if (chromeScheme) {
//                NSString *absoluteString = [inputURL absoluteString];
//                NSRange rangeForScheme = [absoluteString rangeOfString:@":"];
//                NSString *urlNoScheme =
//                [absoluteString substringFromIndex:rangeForScheme.location];
//                NSString *chromeURLString =
//                [chromeScheme stringByAppendingString:urlNoScheme];
//                NSURL *chromeURL = [NSURL URLWithString:chromeURLString];
//                
//                // Open the URL with Chrome.
//                [[UIApplication sharedApplication] openURL:chromeURL];
//            }
//    }
//
//
//
//************************************************************************************
    
    
    NSLog(@"Your General Setting is %@",self.typeOfGeneralSetting);
    if([self.typeOfGeneralSetting  isEqualToString: @"Language"]){
        [self.navigationItem setTitle:@"Language"];
        self.dataArray = [[NSArray alloc] initWithObjects:@"English",@"Dutch",@"French",@"German",@"Spanish", nil];
        [self.settingsTableView reloadData];
    }
    else if([self.typeOfGeneralSetting  isEqualToString: @"Date"]){
        [self.navigationItem setTitle:@"Date Format"];
        
    }
    else if([self.typeOfGeneralSetting  isEqualToString: @"Browser"]){
        [self.navigationItem setTitle:@"Browser"];
        
    }
    else if([self.typeOfGeneralSetting  isEqualToString: @"Sound"]){
        [self.navigationItem setTitle:@"Sound"];
        
    }
    
    // Do any additional setup after loading the view.
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if(indexPath.row == 0){
//        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//        [cell setSelected:YES animated:YES];
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    return indexPath;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
@end
