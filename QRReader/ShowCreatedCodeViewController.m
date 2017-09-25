//
//  ShowCreatedCodeViewController.m
//  QRReader
//
//  Created by ozimacmini9 on 11/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "ShowCreatedCodeViewController.h"

@interface ShowCreatedCodeViewController ()
@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation ShowCreatedCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interstitial = [self createAndLoadInterstitial];
    BOOL tmp = [[NSUserDefaults standardUserDefaults] boolForKey:@"link"];
    [self.createdData setEditable:NO];
    [self.createdData setSelectable:YES];
    [self.createdData setDelegate:self];
    if (tmp) {
        [self.createdData setSelectable:YES];
    }
    else{
        [self.createdData setSelectable:NO];
    }
    self.createdData.text = self.createdDataString;
//    self.qrCodeImage.image = self.myQrCodeImage;
    NSData *stringData = [self.createdDataString dataUsingEncoding: NSISOLatin1StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    self.qrCodeImage.image = self.myQrCodeImage;
    if(self.myQrCodeImage == nil){
        NSData *stringData = [self.createdDataString dataUsingEncoding: NSISOLatin1StringEncoding];
        CIFilter *qrFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
        self.qrCodeImage.image = [UIImage imageWithCIImage:qrFilter.outputImage];
    }
    
//    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Sa" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share2"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction:)];
//    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Sh" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction:)];
    NSArray *tmpArry = [[NSArray alloc] initWithObjects:shareButton,saveButton, nil];
//    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.rightBarButtonItems = tmpArry;
    
//    cell.createdCodeImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
//    cell.createdCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
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
-(IBAction)shareAction:(id)sender{
    NSMutableArray *activityItems= [NSMutableArray arrayWithObjects:self.myQrCodeImage, nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo,UIActivityTypePrint,                                                         UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,                                                         UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,                                                         UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,                                                         UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}
-(IBAction)saveAction:(id)sender{
//    NSMutableArray *activityItems= [NSMutableArray arrayWithObjects:self.myQrCodeImage, nil];
//    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
//    activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo,UIActivityTypePrint,                                                         UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,                                                         UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,                                                         UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,                                                         UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
//    [self presentViewController:activityViewController animated:YES completion:nil];
    
    UIImageWriteToSavedPhotosAlbum(self.myQrCodeImage, self, nil, nil);
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Saved To Photos" message:@"Image Saved to Photos" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    [controller addAction:cancelAction];
    [self presentViewController:controller animated:YES completion:nil];
    
    
    
}
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    NSLog(@"Interacting");
    if([self.navigationItem.title  isEqual: @"URL"] || [self.navigationItem.title  isEqual: @"Web Address"] || [self.navigationItem.title  isEqual: @"Bing"] || [self.navigationItem.title  isEqual: @"Baidu"] || [self.navigationItem.title  isEqual: @"Sogou"] || [self.navigationItem.title  isEqual: @"Yahoo"] || [self.navigationItem.title  isEqual: @"Yandex"] || [self.navigationItem.title  isEqual: @"Ask"] || [self.navigationItem.title  isEqual: @"AOL"] || [self.navigationItem.title  isEqual: @"DuckDuckGo"] || [self.navigationItem.title  isEqual: @"Facebook"] || [self.navigationItem.title  isEqual: @"Twitter"] || [self.navigationItem.title  isEqual: @"Evernote"] || [self.navigationItem.title  isEqual: @"Google Plus"] || [self.navigationItem.title  isEqual: @"LinkedIn"] || [self.navigationItem.title  isEqual: @"Instagram"] || [self.navigationItem.title  isEqual: @"Tumblr"] || [self.navigationItem.title  isEqual: @"Youtube"] || [self.navigationItem.title  isEqual: @"iCloud"] || [self.navigationItem.title  isEqual: @"Google Drive"] || [self.navigationItem.title  isEqual: @"One Drive"] || [self.navigationItem.title  isEqual: @"Dropbox"] || [self.navigationItem.title  isEqual: @"MySpace"] || [self.navigationItem.title  isEqual: @"Flickr"] || [self.navigationItem.title  isEqual: @"Mediafire"] || [self.navigationItem.title  isEqual: @"Box"]){
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
