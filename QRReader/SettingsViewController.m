//
//  SettingsViewController.m
//  QRReader
//
//  Created by ozimacmini9 on 06/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myBanner.delegate = self;
    self.myBanner.adUnitID = @"ca-app-pub-6412217023250030/8601370095";
    self.myBanner.rootViewController = self;
    //    [self.myBanner setAutoloadEnabled:YES];
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
    //    request.testDevices = @[
    //                            @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
    //                            ];
    //        request.testDevices = @[ @"b5492ec64ecbad0f31be3bf73c85cf59" ];
//        request.testDevices = @[ @"63a67b748f428013d8b58124d3f19e8f" ];
//    request.testDevices = @[ kGADSimulatorID ];
    [self.myBanner loadRequest:request];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.200 green:0.200 blue:0.200 alpha:1]];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
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
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    
    for (NSLayoutConstraint *constraint in self.myBanner.constraints) {
        if([constraint.identifier isEqualToString:@"my"]){
            constraint.constant = 50;
        }
    }
    [self.myBanner layoutIfNeeded];
    NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    for (NSLayoutConstraint *constraint in self.myBanner.constraints) {
        if([constraint.identifier isEqualToString:@"my"]){
            constraint.constant = 0;
        }
    }
    [self.myBanner layoutIfNeeded];
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}
@end
