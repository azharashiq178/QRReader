//
//  ShowCreatedCodeViewController.m
//  QRReader
//
//  Created by ozimacmini9 on 11/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "ShowCreatedCodeViewController.h"

@interface ShowCreatedCodeViewController ()

@end

@implementation ShowCreatedCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL tmp = [[NSUserDefaults standardUserDefaults] boolForKey:@"link"];
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
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItem = saveButton;
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
-(IBAction)saveAction:(id)sender{
    UIImageWriteToSavedPhotosAlbum(self.myQrCodeImage, self, nil, nil);
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Saved To Photos" message:@"Image Saved to Photos" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    [controller addAction:cancelAction];
    [self presentViewController:controller animated:YES completion:nil];
}
@end
