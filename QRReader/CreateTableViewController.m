//
//  CreateTableViewController.m
//  QRReader
//
//  Created by ozimacmini9 on 07/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "CreateTableViewController.h"
#import "CreateCodeWithTypeVC.h"
#import "SWRevealViewController.h"

@interface CreateTableViewController ()

@end

@implementation CreateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.revealViewController revealToggleAnimated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:NO block:^(NSTimer * _Nonnull timer) {
        
        CreateCodeWithTypeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Create"];
        
        vc.typeOfCreation = [self getTypeFromIndexPath:indexPath];
        
//        vc.sampleDelegateObject = self;
        
        [self presentViewController:vc animated:YES completion:nil];
    }];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
}
-(NSString *)getTypeFromIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            return @"Web Address";
        }
        else if(indexPath.row == 1){
            return @"Phone Number";
        }
        else if(indexPath.row == 2){
            return @"Text";
        }
        else if(indexPath.row == 3){
            return @"E-mail";
        }
        else if(indexPath.row == 4){
            return @"Contact-Info";
        }
        else if(indexPath.row == 5){
            return @"SMS";
        }
    }
    else if(indexPath.section == 1){
        if(indexPath.row == 0){
            return @"Google";
        }
        else if(indexPath.row == 1){
            return @"Bing";
        }
        else if(indexPath.row == 2){
            return @"Baidu";
        }
        else if(indexPath.row == 3){
            return @"Sogou";
        }
        else if(indexPath.row == 4){
            return @"Yahoo";
        }
        else if(indexPath.row == 5){
            return @"Yandex";
        }
        else if(indexPath.row == 6){
            return @"Ask";
        }
        else if(indexPath.row == 7){
            return @"AOL";
        }
        else if(indexPath.row == 8){
            return @"DuckDuckGo";
        }
    }
    else if(indexPath.section == 2){
        if(indexPath.row == 0){
            return @"Facebook";
        }
        else if(indexPath.row == 1){
            return @"Twitter";
        }
        else if(indexPath.row == 2){
            return @"Evernote";
        }
        else if(indexPath.row == 3){
            return @"Google Plus";
        }
        else if(indexPath.row == 4){
            return @"LinkedIn";
        }
        else if(indexPath.row == 5){
            return @"Instagram";
        }
        else if(indexPath.row == 6){
            return @"Tumblr";
        }
        else if(indexPath.row == 7){
            return @"Youtube";
        }
        
    }
    else if(indexPath.section == 3){
        if(indexPath.row == 0){
            return @"iCloud";
        }
        else if(indexPath.row == 1){
            return @"Google Drive";
        }
        else if(indexPath.row == 2){
            return @"One Drive";
        }
        else if(indexPath.row == 3){
            return @"Dropbox";
        }
        else if(indexPath.row == 4){
            return @"MySpace";
        }
        else if(indexPath.row == 5){
            return @"Flickr";
        }
        else if(indexPath.row == 6){
            return @"Mediafire";
        }
        else if(indexPath.row == 7){
            return @"Box";
        }
        
    }
    return nil;
}

@end
