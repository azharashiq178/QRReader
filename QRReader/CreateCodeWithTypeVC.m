//
//  CreateCodeWithTypeVC.m
//  QRReader
//
//  Created by ozimacmini9 on 07/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "CreateCodeWithTypeVC.h"

@interface CreateCodeWithTypeVC ()
@property (nonatomic,strong) NSArray *codeTypes;

@end

@implementation CreateCodeWithTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPickerView *myPickerView = [[UIPickerView alloc] init];
    self.codeTypes = [[NSArray alloc] initWithObjects:@"QRCode",@"Bar Code", nil];
    myPickerView.delegate = self;
    self.typeOfCode.text = @"QRCode";
    self.typeOfCode.inputView = myPickerView;
    self.typeOfCode.delegate = self;
    
    self.myNavBar.topItem.title = self.typeOfCreation;
    if([self.typeOfCreation  isEqualToString: @"Web Address"]){
        self.textForCode.placeholder = @"https://";
        self.textForCode.keyboardType = UIKeyboardTypeURL;
    }
    else if([self.typeOfCreation  isEqualToString: @"Phone Number"]){
        self.textForCode.placeholder = @"Phone Number";
        self.textForCode.keyboardType = UIKeyboardTypePhonePad;
    }
    else if([self.typeOfCreation  isEqualToString: @"Text"]){
//        CGRect frame = self.textForCode.frame;
//        frame.size.height = 300;
//        [self.textForCode setFrame:frame];
        NSLayoutConstraint *heightConstraint;
        for (NSLayoutConstraint *constraint in self.textForCode.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                heightConstraint = constraint;
                break;
            }
        }
        heightConstraint.constant = 300;
        self.textForCode.keyboardType = UIKeyboardTypeDefault;
    }
    else if([self.typeOfCreation  isEqualToString: @"E-mail"]){
        self.textForCode.placeholder = @"E-mail";
        self.textForCode.keyboardType = UIKeyboardTypeEmailAddress;
    }
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
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.codeTypes count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    [self.typeOfCode setUserInteractionEnabled:NO];
    return [self.codeTypes objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.typeOfCode.text = [self.codeTypes objectAtIndex:row];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    [self.typeOfCode setEnabled:NO];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
}
- (IBAction)createCodeAction:(id)sender {
    if([self.typeOfCode.text isEqualToString:@"QRCode"]){
        
        NSString *tmpStr = [NSString stringWithFormat:@"%@",self.textForCode.text];
        //    NSData *stringData = [tmpStr dataUsingEncoding: NSUTF8StringEncoding];
        NSData *stringData = [tmpStr dataUsingEncoding: NSISOLatin1StringEncoding];
        
        CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
        
//        NSLayoutConstraint *heightConstraint;
//        for (NSLayoutConstraint *constraint in self.qrImageView.constraints) {
//            if (constraint.secondAttribute == NSLayoutAttributeWidth) {
//                heightConstraint = constraint;
//                break;
//            }
//        }
//        heightConstraint.constant = 100;
        
//        [self.qrImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.qrImageView
//                                                          attribute:NSLayoutAttributeWidth
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:nil
//                                                          attribute: NSLayoutAttributeNotAnAttribute
//                                                         multiplier:1
//                                                           constant:100]];
        UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
//        self.qrImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
        myImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
        [self.view addSubview:myImageView];
    }
    else if([self.typeOfCode.text isEqualToString:@"Bar Code"]){
        
        NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if ([self.textForCode.text rangeOfCharacterFromSet:notDigits].location == NSNotFound)
        {
            NSString *tmpStr = [NSString stringWithFormat:@"%@",self.textForCode.text];
            //    NSData *stringData = [tmpStr dataUsingEncoding: NSUTF8StringEncoding];
            NSData *stringData = [tmpStr dataUsingEncoding: NSISOLatin1StringEncoding];
            
            CIFilter *qrFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
            [qrFilter setValue:stringData forKey:@"inputMessage"];
            
//            NSLayoutConstraint *heightConstraint;
//            for (NSLayoutConstraint *constraint in self.qrImageView.constraints) {
//                if (constraint.secondAttribute == NSLayoutAttributeWidth) {
//                    heightConstraint = constraint;
//                    break;
//                }
//            }
//            heightConstraint.constant = 300;
//            self.qrImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
            UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 500, 300, 100)];
            //        self.qrImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
            myImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
            [self.view addSubview:myImageView];
            // newString consists only of the digits 0 through 9
        }
        else{
            NSLog(@"String is not numeric");
        }
    }
}
@end
