//
//  ViewController.m
//  QRReader
//
//  Created by Muhammad Azher on 30/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "ViewController.h"
#import "DYQRCodeDecoderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultString.text = self.tmpResult;
//    [self setNavigationBarButton];
    // Do any additional setup after loading the view, typically from a nib.
 
    
//    [self.view addSubview:vc.view];

    
    
}

-(void)setNavigationBarButton{
    UIView *buttonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //    buttonContainer.backgroundColor = [UIColor clearColor];
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button0 setFrame:CGRectMake(40, 10, 100,25)];
    [button0 setTitle:@"OFF" forState:UIControlStateNormal];
    [button0.layer setCornerRadius:12.5];
    [button0 setImage:[UIImage imageNamed:@"flash"] forState:UIControlStateNormal];
    button0.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    //    [button0 setBackgroundImage:[UIImage imageNamed:@"button0.png"] forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(turnTorchOnOrOff:) forControlEvents:UIControlEventTouchUpInside];
    //    [button0 setShowsTouchWhenHighlighted:YES];
    [button0 setBackgroundColor:[UIColor blackColor]];
    [buttonContainer addSubview:button0];
    
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake((buttonContainer.frame.size.width)-150, 10, 100, 25)];
    [button1.layer setCornerRadius:12.5];
    [button1 setTitle:@"Library" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(openLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundColor:[UIColor blackColor]];
    [button1 setImage:[UIImage imageNamed:@"gallery"] forState:UIControlStateNormal];
    button1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [buttonContainer addSubview:button1];
    
    
    self.navigationItem.titleView = buttonContainer;
    self.navigationController.navigationBar.topItem.titleView = buttonContainer;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)turnTorchOnOrOff:(id)sender{
    NSLog(@"Flash is Turning on or off");
}
-(IBAction)openLibrary:(id)sender{
    NSLog(@"Opening Library");

}
@end
