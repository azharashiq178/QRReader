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
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    if([self.interstitial isReady]){
//        [self.interstitial presentFromRootViewController:self];
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interstitial = [self createAndLoadInterstitial];
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
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Can't Open in Chrome" message:@"Can't open link in chrome, if you don't have chrome then please install it or select safari in Settings" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [controller dismissViewControllerAnimated:YES completion:nil];
                }];
                [controller addAction:cancelAction];
                [self presentViewController:controller animated:YES completion:nil];
            }
            return NO;
        }
    }
    return YES;
}
- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-6412217023250030/5400491687"];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}
- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
//    self.interstitial = [self createAndLoadInterstitial];
}
/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    [self.interstitial presentFromRootViewController:self];
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
}
/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
}
@end
