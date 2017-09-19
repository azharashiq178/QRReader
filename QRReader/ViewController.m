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
    [self.resultString setDelegate:self];
    self.navigationItem.title = self.myTitle;
    BOOL tmp = [[NSUserDefaults standardUserDefaults] boolForKey:@"link"];
    if (tmp) {
        [self.resultString setSelectable:YES];
    }
    else{
        [self.resultString setSelectable:NO];
    }

    
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
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    NSLog(@"Interacting");
    if([self.myTitle  isEqual: @"URL"]){
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"Browser"]){

            if ([[UIApplication sharedApplication] canOpenURL:
                 [NSURL URLWithString:@"googlechrome://"]])
            {
                NSLog(@"Yes app can open chrome url");
                NSURL *inputURL = URL;
                NSString *scheme = inputURL.scheme;
                
                // Replace the URL Scheme with the Chrome equivalent.
                NSString *chromeScheme = nil;
                if ([scheme isEqualToString:@"http"]) {
                    chromeScheme = @"googlechrome";
                } else if ([scheme isEqualToString:@"https"]) {
                    chromeScheme = @"googlechromes";
                }
                
                // Proceed only if a valid Google Chrome URI Scheme is available.
                if (chromeScheme) {
                    NSString *absoluteString = [inputURL absoluteString];
                    NSRange rangeForScheme = [absoluteString rangeOfString:@":"];
                    NSString *urlNoScheme =
                    [absoluteString substringFromIndex:rangeForScheme.location];
                    NSString *chromeURLString =
                    [chromeScheme stringByAppendingString:urlNoScheme];
                    NSURL *chromeURL = [NSURL URLWithString:chromeURLString];
                    
                    // Open the URL with Chrome.
                    [[UIApplication sharedApplication] openURL:chromeURL];
                }
                
            }
            else{
                NSLog(@"Noped app can't open chrom url");
            }
            return NO;
        }
    }
    return YES;
    
}
@end
