//
//  DYQRCodeDecoderViewController.m
//  QRCode-Decoder
//
//  Created by Dwarven on 16/7/5.
//  Copyright © 2016 Dwarven. All rights reserved.
//


#import "DYQRCodeDecoderViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MyTabBarViewController.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface DYQRCodeDecoderViewController () <
AVCaptureMetadataOutputObjectsDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate> {
    void(^_completion)(BOOL, NSString *);
    NSMutableArray *_observers;
    UIView *_viewPreview;
    UIImageView * _lineImageView;
    CGRect _lineRect0;
    CGRect _lineRect1;
}

@property (nonatomic, strong, readwrite) UIBarButtonItem * leftBarButtonItem;
@property (nonatomic, strong, readwrite) UIBarButtonItem * rightBarButtonItem;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) BOOL isReading;


@end

@implementation DYQRCodeDecoderViewController

- (void)dealloc{
    [self cleanNotifications];
    _observers = nil;
    _viewPreview = nil;
    _lineImageView = nil;
    _completion = NULL;
    self.imagePicker = nil;
    self.captureSession = nil;
    self.videoPreviewLayer = nil;
    self.leftBarButtonItem = nil;
    self.rightBarButtonItem = nil;
    self.frameImage = nil;
    self.lineImage = nil;
    self.navigationBarTintColor = nil;
}

- (void)setupNotifications{
    if (!_observers) {
        _observers = [NSMutableArray array];
    }
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    
    __weak DYQRCodeDecoderViewController * SELF = self;
    id o;
    
    o = [center addObserverForName:UIApplicationDidEnterBackgroundNotification
                            object:nil
                             queue:nil
                        usingBlock:^(NSNotification *note) {
                            [SELF.imagePicker dismissViewControllerAnimated:NO completion:NULL];
                            [SELF cancel];
                        }];
    [_observers addObject:o];
}

- (void)cleanNotifications{
    for (id o in _observers) {
        [[NSNotificationCenter defaultCenter] removeObserver:o];
    }
    [_observers removeAllObjects];
}

- (id)initWithCompletion:(void (^)(BOOL, NSString *))completion{
    self = [super init];
    if (self) {
        _needsScanAnnimation = YES;
        _completion = completion;
        _frameImage = [UIImage imageNamed:@"img_animation_scan_pic" inBundle:[NSBundle bundleForClass:[DYQRCodeDecoderViewController class]] compatibleWithTraitCollection:nil];
        _lineImage = [UIImage imageNamed:@"img_animation_scan_line" inBundle:[NSBundle bundleForClass:[DYQRCodeDecoderViewController class]] compatibleWithTraitCollection:nil];
        
//        _leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
//                                                              style:UIBarButtonItemStylePlain
//                                                             target:self
//                                                             action:@selector(cancel)];
//        
//        _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Album"
//                                                               style:UIBarButtonItemStylePlain
//                                                              target:self
//                                                              action:@selector(pickImage)];
    }
    return self;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self startReading];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_needsScanAnnimation) {
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionRepeat animations:^{
            [_lineImageView setFrame:_lineRect1];
        } completion:^(BOOL finished) {
            [_lineImageView setFrame:_lineRect0];
        }];
    }
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"laser"]){
        [_lineImageView setHidden:NO];
    }
    else{
      [_lineImageView setHidden:YES];
    }
//    [_lineImageView setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startReading];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopReading];
}
-(void)setNavigationBarButton{
    UIView *buttonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //    buttonContainer.backgroundColor = [UIColor clearColor];
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button0 setFrame:CGRectMake(40, 10, 100,25)];
    [button0 setTitle:NSLocalizedString(@"ON", nil) forState:UIControlStateNormal];
    [button0.layer setCornerRadius:12.5];
    [button0 setImage:[UIImage imageNamed:@"flash"] forState:UIControlStateNormal];
    button0.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    //    [button0 setBackgroundImage:[UIImage imageNamed:@"button0.png"] forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(turnTorchOnOrOff:) forControlEvents:UIControlEventTouchUpInside];
    //    [button0 setShowsTouchWhenHighlighted:YES];
    [button0 setBackgroundImage:[UIImage imageNamed:@"off1x"] forState:UIControlStateNormal];
//    [button0 setBackgroundColor:[UIColor blackColor]];
    [buttonContainer addSubview:button0];
    
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake((buttonContainer.frame.size.width)-150, 10, 100, 25)];
    [button1.layer setCornerRadius:12.5];
    [button1 setTitle:NSLocalizedString(@"Library", nil)  forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
//    [button1 setBackgroundColor:[UIColor blackColor]];
//    [button1 setImage:[UIImage imageNamed:@"library"] forState:UIControlStateNormal];

//    button1.titleLabel.font = [UIFont systemFontOfSize:10];
    [button1 setImage:[UIImage imageNamed:@"library"] forState:UIControlStateNormal];
    button1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    button1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button1 setBackgroundImage:[UIImage imageNamed:@"off1x"] forState:UIControlStateNormal];
    [buttonContainer addSubview:button1];
    
    self.navigationItem.titleView = buttonContainer;
    self.navigationController.navigationBar.topItem.titleView = buttonContainer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBarController.delegate = self;
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
//    request.testDevices = @[ @"63a67b748f428013d8b58124d3f19e8f" ];
    [self.myBanner loadRequest:request];
    
    [self setupNotifications];
    [self setNavigationBarButton];
    [self initWithCompletion:nil];
    
    
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.delegate = self;
    
    if (_navigationBarTintColor) {
        if (self.navigationController) {
            self.navigationController.navigationBar.tintColor = _navigationBarTintColor;
        }
        _imagePicker.navigationBar.tintColor =_navigationBarTintColor;
    }
    
    // Initially make the captureSession object nil.
    _captureSession = nil;
    
    // Set the initial value of the flag to NO.
    _isReading = NO;
    
    [self.navigationItem setLeftBarButtonItem:_leftBarButtonItem];
    [self.navigationItem setRightBarButtonItem:_rightBarButtonItem];
    
    _viewPreview = [[UIView alloc] init];
    [self.view addSubview:_viewPreview];
    [_viewPreview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_viewPreview
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_viewPreview
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.myBanner
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-50.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_viewPreview
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_viewPreview
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    if (_needsScanAnnimation) {
        UIView * scanView = [[UIView alloc] init];
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgimage"]];
        [scanView addSubview:bgImageView];
        
        [scanView setBackgroundColor:[UIColor blackColor]];
        [scanView setAlpha:0.8];
        [self.view addSubview:scanView];
        [scanView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:scanView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_viewPreview
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:scanView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_viewPreview
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:scanView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_viewPreview
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:scanView
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_viewPreview
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        CGFloat frameWidth = SCREEN_WIDTH * 2 / 3;
        
        //create path
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(SCREEN_WIDTH / 6, SCREEN_HEIGHT / 2 - SCREEN_WIDTH / 3, frameWidth, frameWidth) cornerRadius:0] bezierPathByReversingPath]];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.path = path.CGPath;
        
        [scanView.layer setMask:shapeLayer];
        
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView setImage:_frameImage];
        [self.view addSubview:imageView];
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[imageView(==%f)]", frameWidth]
                                                                          options:0
                                                                          metrics:0
                                                                            views:@{@"imageView":imageView}]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[imageView(==%f)]", frameWidth]
                                                                          options:0
                                                                          metrics:0
                                                                            views:@{@"imageView":imageView}]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_viewPreview
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_viewPreview
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1.0
                                                               constant:50.0]];
        
        
        _lineImageView = [[UIImageView alloc] init];
        CGFloat lineHeight = frameWidth * _lineImage.size.height / _lineImage.size.width;
        _lineRect0 = CGRectMake(0, 0, frameWidth, lineHeight);
        _lineRect1 = CGRectMake(0, frameWidth - 20, frameWidth, lineHeight);
        [_lineImageView setFrame:_lineRect0];
        [_lineImageView setImage:_lineImage];
        [imageView addSubview:_lineImageView];
        
    }
}

- (void)cancel{
    [self dismissViewControllerAnimated:NO completion:NULL];
}

- (void)pickImage{
    [self presentViewController:_imagePicker animated:YES completion:NULL];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [picker dismissViewControllerAnimated:NO completion:NULL];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:context
                                              options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *cgImage = [CIImage imageWithCGImage:image.CGImage];
    NSArray *features = [detector featuresInImage:cgImage];
    CIQRCodeFeature *feature = [features firstObject];
    
    NSString *result = feature.messageString;
    if (_completion) {
        _completion(result != nil, result);
    }
    [self cancel];
    if(result != nil){
        self.myType = @"QRCode";
        [self dealWithResult:result];
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Code Not found" message:@"No Code Found in image" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}


- (void)start {
    [self startReading];
}

- (void)stop {
    [self stopReading];
}

- (void)dealWithResult:(NSString *)result {
//    AudioServicesPlaySystemSound (1108);
//    AudioServicesPlaySystemSound (1052);
//    AudioServicesPlaySystemSound (1106);
//    AudioServicesPlaySystemSound (1057);
//    AudioServicesPlaySystemSound (1100);
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"Beep"]){
        AudioServicesPlaySystemSound (1113);
    }
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"Vibrate"]){
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    if(result != nil){
        self.myResult = result;
        //    [self performSegueWithIdentifier:@"showResult" sender:self];
        self.myResult = result;
        NSLog(@"My Result is %@",result);
        [(MyTabBarViewController *)self.tabBarController setMyResultString:result];
        [(MyTabBarViewController *)self.tabBarController setMyType:self.myType];
        
        [self.tabBarController setSelectedIndex:2];
    }
    else{
        NSLog(@"Not Found");
    }
    
}

#pragma mark - Private method implementation

- (void)startReading {
    if (!_isReading) {
        NSError *error;
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
        
        if (input) {
            // Initialize the captureSession object.
            _captureSession = [[AVCaptureSession alloc] init];
            // Set the input device on the capture session.
            [_captureSession addInput:input];
            
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
            [_captureSession addOutput:captureMetadataOutput];
            
            // Create a new serial dispatch queue.
            dispatch_queue_t dispatchQueue;
            dispatchQueue = dispatch_queue_create("myQueue", NULL);
            [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
//            [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
            [captureMetadataOutput setMetadataObjectTypes:[captureMetadataOutput availableMetadataObjectTypes]];
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
            [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
            [_viewPreview.layer addSublayer:_videoPreviewLayer];
            
            
            // Start video capture.
            [_captureSession startRunning];
            _isReading = !_isReading;
        } else {
            // If any error occurs, simply log the description of it and don't continue any more.
            NSLog(@"%@", [error localizedDescription]);
            return;
        }
    }
}


- (void)stopReading {
    if (_isReading) {
        // Stop video capture and make the capture session object nil.
        [_captureSession stopRunning];
        _captureSession = nil;
        
        // Remove the video preview layer from the viewPreview view's layer.
        [_videoPreviewLayer removeFromSuperlayer];
        _isReading = !_isReading;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
            
            void(^block)() = ^(void) {
                NSLog(@"%@",[metadataObj stringValue]);
                [self stopReading];
                [self cancel];
                if (![metadataObj stringValue] || [[metadataObj stringValue] length] == 0) {
                    if (_completion) {
                        _completion(NO, nil);
                    }
                    self.myType = @"nil";
                    [self dealWithResult:nil];
                } else {
                    if (_completion) {
                        _completion(YES, [metadataObj stringValue]);
                    }
                    self.myType = @"QRCode";
                    [self dealWithResult:[metadataObj stringValue]];
                }
            };
            
            if ([NSThread isMainThread]) {
                block();
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    block();
                });
            }
        }
        else{
            NSLog(@"Bar code detected");
            NSString *capturedBarcode = nil;
            
            // Specify the barcodes you want to read here:
            NSArray *supportedBarcodeTypes = @[AVMetadataObjectTypeUPCECode,
                                               AVMetadataObjectTypeCode39Code,
                                               AVMetadataObjectTypeCode39Mod43Code,
                                               AVMetadataObjectTypeEAN13Code,
                                               AVMetadataObjectTypeEAN8Code,
                                               AVMetadataObjectTypeCode93Code,
                                               AVMetadataObjectTypeCode128Code,
                                               AVMetadataObjectTypePDF417Code,
                                               AVMetadataObjectTypeQRCode,
                                               AVMetadataObjectTypeAztecCode];
            
            // In all scanned values..
            for (AVMetadataObject *barcodeMetadata in metadataObjects) {
                // ..check if it is a suported barcode
                for (NSString *supportedBarcode in supportedBarcodeTypes) {
                    
                    if ([supportedBarcode isEqualToString:barcodeMetadata.type]) {
                        // This is a supported barcode
                        // Note barcodeMetadata is of type AVMetadataObject
                        // AND barcodeObject is of type AVMetadataMachineReadableCodeObject
                        AVMetadataMachineReadableCodeObject *barcodeObject = (AVMetadataMachineReadableCodeObject *)[_videoPreviewLayer transformedMetadataObjectForMetadataObject:barcodeMetadata];
                        capturedBarcode = [barcodeObject stringValue];
                        // Got the barcode. Set the text in the UI and break out of the loop.
                        
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.captureSession stopRunning];
//                            self.scannedBarcode.text = capturedBarcode;
                            NSLog(@"Bar code is %@",capturedBarcode);
                            self.myType = @"Bar Code";
                            [self dealWithResult:capturedBarcode];
                        });
                        return;
                    }
                }
            }
        }
    }
}
-(IBAction)turnTorchOnOrOff:(id)sender{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]){
        
        [device lockForConfiguration:nil];
        if (device.torchMode == AVCaptureTorchModeOff)
        {
            [device setTorchMode:AVCaptureTorchModeOn];
            [device setFlashMode:AVCaptureFlashModeOn];
            
            [sender setTitle:NSLocalizedString(@"OFF", nil) forState:UIControlStateNormal];
            //torchIsOn = YES;
        }
        else
        {
            [device setTorchMode:AVCaptureTorchModeOff];
            [device setFlashMode:AVCaptureFlashModeOff];
            [sender setTitle:NSLocalizedString(@"ON", nil) forState:UIControlStateNormal];
            // torchIsOn = NO;
        }
        [device unlockForConfiguration];
    }
    NSLog(@"Flash is Turning on or off");
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return NO;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier  isEqual: @"showResult"]){
        
        NSLog(@"Done");
        ViewController *destinationController = segue.destinationViewController;
        destinationController.tmpResult = self.myResult;
//        [self presentViewController:destinationController animated:YES completion:nil];
    }
}
//-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    NSLog(@"Selected Tab bar controller");
//}
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
            constraint.constant = 1;
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
