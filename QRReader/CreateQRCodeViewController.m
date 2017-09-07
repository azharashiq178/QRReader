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
@import IQKeyboardManager;

@interface CreateQRCodeViewController ()

@end

@implementation CreateQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    CreatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showCreatedList"];
    if(cell == nil){
        cell = [[CreatedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"showCreatedList"];
    }
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.mySearchBar setShowsCancelButton:NO animated:YES];
    self.mySearchBar.text = @"";
    [self.mySearchBar resignFirstResponder];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.mySearchBar setShowsCancelButton:YES animated:YES];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return NO;
}
@end
