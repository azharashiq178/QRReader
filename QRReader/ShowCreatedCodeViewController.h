//
//  ShowCreatedCodeViewController.h
//  QRReader
//
//  Created by ozimacmini9 on 11/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShowCreatedCodeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *createdData;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImage;
@property (weak, nonatomic) IBOutlet UIImageView *barCodeImage;
@property (weak, nonatomic) NSString *createdDataString;
@property (weak, nonatomic) UIImage *myQrCodeImage;

@end
