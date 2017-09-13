//
//  CreateContainerViewController.m
//  QRReader
//
//  Created by ozimacmini9 on 13/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "CreateContainerViewController.h"

@interface CreateContainerViewController ()

@end

@implementation CreateContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect frame = CGRectMake(0, 0, 44, self.view.frame.size.width);
//    UILabel *myLabel = [[UILabel alloc] initWithFrame:frame];
//    myLabel.text = @"Select QR Code Type";
//    myLabel.textAlignment = NSTextAlignmentLeft;
//    [myLabel setTextColor:[UIColor whiteColor]];
//    self.navigationItem.titleView = myLabel;
//    self.navigationController.navigationBar.backItem.titleView = myLabel;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"        Select QR Code Type" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
//    self.navigationController.navigationBar.topItem.titleView = myLabel;
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

@end
