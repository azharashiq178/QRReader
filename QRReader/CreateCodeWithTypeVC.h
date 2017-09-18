//
//  CreateCodeWithTypeVC.h
//  QRReader
//
//  Created by ozimacmini9 on 07/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CreateCodeWithTypeVC : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
- (IBAction)dismissScreen:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *myNavBar;
@property (weak, nonatomic) IBOutlet UITextField *typeOfCode;
@property (nonatomic,strong) NSString *typeOfCreation;
@property (weak, nonatomic) IBOutlet UITextField *textForCode;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (weak, nonatomic) IBOutlet UILabel *codeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UILabel *webLabel;
@property (weak, nonatomic) IBOutlet UITextField *webField;

- (IBAction)createCodeAction:(id)sender;
@end
