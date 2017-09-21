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
        NSDate *todayDate = [NSDate date]; //Get todays date
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date.
        [dateFormatter setDateFormat:@"dd/MM/YYYY"]; //Here we can set the format which we need
        NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
        [dateFormatter setDateFormat:@"dd.MM.YYYY"];
        NSString *convertedDateString1 = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
        [dateFormatter setDateFormat:@"dd-MM-YYYY"];
        NSString *convertedDateString2 = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
        [dateFormatter setDateFormat:@"MM/dd/YYYY"];
        NSString *convertedDateString3 = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
        [dateFormatter setDateFormat:@"MM.dd.YYYY"];
        NSString *convertedDateString4 = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
        self.dataArray = [[NSArray alloc] initWithObjects:convertedDateString,convertedDateString1,convertedDateString2,convertedDateString3,convertedDateString4, nil];
        [self.settingsTableView reloadData];
        
    }
    else if([self.typeOfGeneralSetting  isEqualToString: @"Browser"]){
        [self.navigationItem setTitle:@"Browser"];
        self.dataArray = [[NSArray alloc] initWithObjects:@"Safari (Native)",@"Chrome", nil];
        [self.settingsTableView reloadData];
        
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
    if([self.typeOfGeneralSetting  isEqualToString: @"Browser"]){
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"Browser"]){
            if(indexPath.row == 1){
                [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            }
        }
        else{
            if(indexPath.row == 0){
                [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            }
        }
    }
    else if ([self.typeOfGeneralSetting isEqualToString:@"Date"]){
        if([[[NSUserDefaults standardUserDefaults] stringForKey:@"Date"] isEqualToString:@"dd/MM/YYYY"] && indexPath.row == 0){
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
//            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"Date"] isEqualToString:@"dd.MM.YYYY"] && indexPath.row == 1){
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"Date"] isEqualToString:@"dd-MM-YYYY"] && indexPath.row == 2){
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"Date"] isEqualToString:@"MM/dd/YYYY"] && indexPath.row == 3){
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"Date"] isEqualToString:@"MM.dd.YYYY"] && indexPath.row == 4){
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
//        else if (indexPath.row == 0){
//            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
//            //            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] setAccessoryType:UITableViewCellAccessoryCheckmark];
//            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//        }
    }
    else if(indexPath.row == 0){
        //        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        //        [cell setSelected:YES animated:YES];
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    [cell setBackgroundColor:[UIColor grayColor]];
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
    if([self.typeOfGeneralSetting  isEqualToString: @"Browser"]){
        if(indexPath.row == 0)
            [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"Browser"];
        else if (indexPath.row == 1){
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"Browser"];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if([self.typeOfGeneralSetting isEqualToString:@"Date"]){
        if(indexPath.row == 0){
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"dd/MM/YYYY"] forKey:@"Date"];
        }
        else if(indexPath.row == 1){
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"dd.MM.YYYY"] forKey:@"Date"];
        }
        else if(indexPath.row == 2){
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"dd-MM-YYYY"] forKey:@"Date"];
        }
        else if(indexPath.row == 3){
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"MM/dd/YYYY"] forKey:@"Date"];
        }
        else if(indexPath.row == 4){
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"MM.dd.YYYY"] forKey:@"Date"];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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
