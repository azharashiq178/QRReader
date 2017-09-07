//
//  CreateCodeWithTypeVC.m
//  QRReader
//
//  Created by ozimacmini9 on 07/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "CreateCodeWithTypeVC.h"

@interface CreateCodeWithTypeVC ()

@end

@implementation CreateCodeWithTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"i am in CreateCodeWithTypeVC");
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

- (IBAction)dismissScreen:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
