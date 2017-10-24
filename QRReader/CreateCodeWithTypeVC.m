//
//  CreateCodeWithTypeVC.m
//  QRReader
//
//  Created by ozimacmini9 on 07/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "CreateCodeWithTypeVC.h"
#import "CreateQRCodeViewController.h"
#import "HistoryData.h"
//#import "SCSQLite.h"

@interface CreateCodeWithTypeVC ()
@property (nonatomic,strong) NSArray *codeTypes;

@end

@implementation CreateCodeWithTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [SCSQLite executeSQL:@"INSERT INTO QRReader (TypeOfCode) VALUES ('Azher')"];
//    NSArray *result = [SCSQLite selectRowSQL:@"SELECT * FROM QRReader"];
    // Do any additional setup after loading the view.
    UIPickerView *myPickerView = [[UIPickerView alloc] init];
    self.codeTypes = [[NSArray alloc] initWithObjects:@"QRCode",@"Bar Code", nil];
    myPickerView.delegate = self;
    self.typeOfCode.text = @"QRCode";
    self.typeOfCode.inputView = myPickerView;
    self.typeOfCode.delegate = self;
    
    self.myNavBar.topItem.title = self.typeOfCreation;
    [self prepareForWriting];
}
-(void)prepareForWriting{
    if([self.typeOfCreation  isEqualToString: @"Web Address"]){
        self.textForCode.placeholder = @"https://";
        self.textForCode.keyboardType = UIKeyboardTypeURL;
        self.codeTitleLabel.text = @"URL:";
        [self setFieldsHidden:YES];
    }
    else if([self.typeOfCreation  isEqualToString: @"Phone Number"]){
        [self.textForCode setFont:[UIFont systemFontOfSize:11]];
        self.textForCode.placeholder = @"Phone Number";
        self.textForCode.keyboardType = UIKeyboardTypePhonePad;
        self.codeTitleLabel.text = @"Phone Number:";
        [self setFieldsHidden:YES];
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
        self.textForCode.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        self.textForCode.placeholder = @"Enter your text here";
        self.textForCode.keyboardType = UIKeyboardTypeDefault;
        self.codeTitleLabel.text = @"Text:";
        [self setFieldsHidden:YES];
    }
    else if([self.typeOfCreation  isEqualToString: @"E-mail"]){
        self.textForCode.placeholder = @"E-mail";
        self.textForCode.keyboardType = UIKeyboardTypeEmailAddress;
        self.codeTitleLabel.text = @"Email Address:";
        [self setFieldsHidden:YES];
        
    }
    else if ([self.typeOfCreation isEqualToString:@"Contact-Info"]){
        [self.textForCode setFont:[UIFont systemFontOfSize:12]];
        self.textForCode.placeholder = @"Contact Info";
        self.textForCode.keyboardType = UIKeyboardTypeDefault;
        [self setFieldsHidden:NO];
    }
    else if ([self.typeOfCreation isEqualToString:@"SMS"]){
        [self setFieldsHidden:YES];
        [self.lastNameField setHidden:NO];
        [self.lastNameLabel setHidden:NO];
        self.textForCode.placeholder = @"Enter Number";
        self.textForCode.keyboardType = UIKeyboardTypeNumberPad;
        self.lastNameLabel.text = @"Body:";
        self.lastNameField.placeholder = @"Type Your Message here";
        self.codeTitleLabel.text = @"To:";
        NSLayoutConstraint *heightConstraint;
        for (NSLayoutConstraint *constraint in self.lastNameField.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                heightConstraint = constraint;
                break;
            }
        }
        heightConstraint.constant = 300;
        self.lastNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [self.textForCode setFont:[UIFont systemFontOfSize:12]];
        //        self.lastNameField.inputView = [[UITextView alloc] init];
        
    }
    else{
        [self.codeTitleLabel setHidden:YES];
        [self setFieldsHidden:YES];
        self.textForCode.keyboardType = UIKeyboardTypeURL;
        if([self.typeOfCreation isEqualToString:@"Facebook"] || [self.typeOfCreation isEqualToString:@"Twitter"] || [self.typeOfCreation isEqualToString:@"Evernote"] || [self.typeOfCreation isEqualToString:@"Google Plus"] || [self.typeOfCreation isEqualToString:@"LinkedIn"] || [self.typeOfCreation isEqualToString:@"Instagram"] || [self.typeOfCreation isEqualToString:@"Tumblr"] || [self.typeOfCreation isEqualToString:@"Youtube"]){
            self.textForCode.text = [NSString stringWithFormat:@"https://www.%@.com/",self.typeOfCreation];
        }
        else if ([self.typeOfCreation isEqualToString:@"iCloud"]){
            self.textForCode.text = [NSString stringWithFormat:@"https://www.icloud.com/"];
        }
        else if ([self.typeOfCreation isEqualToString:@"Google Drive"]){
            self.textForCode.text = [NSString stringWithFormat:@"https://www.drive.google.com/"];
        }
        else if ([self.typeOfCreation isEqualToString:@"One Drive"]){
            self.textForCode.text = [NSString stringWithFormat:@"https://www.onedrive.live.com/"];
        }
        else if ([self.typeOfCreation isEqualToString:@"Dropbox"]){
            self.textForCode.text = [NSString stringWithFormat:@"https://www.dropbox.com/"];
        }
        else if ([self.typeOfCreation isEqualToString:@"MySpace"]){
            self.textForCode.text = [NSString stringWithFormat:@"https://www.myspace.com/"];
        }
        else if ([self.typeOfCreation isEqualToString:@"Flickr"]){
            self.textForCode.text = [NSString stringWithFormat:@"https://www.flickr.com/"];
        }
        else if ([self.typeOfCreation isEqualToString:@"Mediafire"]){
            self.textForCode.text = [NSString stringWithFormat:@"https://www.mediafire.com/"];
        }
        else if ([self.typeOfCreation isEqualToString:@"Box"]){
            self.textForCode.text = [NSString stringWithFormat:@"https://www.box.com/"];
        }
        else{
            
            self.textForCode.placeholder = [NSString stringWithFormat:@"Enter %@",self.typeOfCreation];
            self.textForCode.keyboardType = UIKeyboardTypeURL;
        }
    }
    
}
- (NSString *)vCardRepresentation
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    [mutableArray addObject:@"BEGIN:VCARD"];
    [mutableArray addObject:@"VERSION:3.0"];
    
    [mutableArray addObject:[NSString stringWithFormat:@"FN:%@", self.textForCode.text]];
    
//    [mutableArray addObject:[NSString stringWithFormat:@"ADR:;;%@",
//                             [self addressWithSeparator:@";"]]];
    
    if (self.phoneField.text != nil)
        [mutableArray addObject:[NSString stringWithFormat:@"TEL:%@", self.phoneField.text]];
    
//    [mutableArray addObject:[NSString stringWithFormat:@"GEO:%g;%g",
//                             self.latitudeValue, self.longitudeValue]];
    
    [mutableArray addObject:[NSString stringWithFormat:@"URL:http://%@",
                             self.webField.text]];
    
    [mutableArray addObject:@"END:VCARD"];
    
    NSString *string = [mutableArray componentsJoinedByString:@"\n"];
    
//    [mutableArray release];
    
    return string;
}
-(void)setFieldsHidden:(BOOL)value{
    [self.lastNameLabel setHidden:value];
    [self.lastNameField setHidden:value];
    [self.emailLabel setHidden:value];
    [self.emailField setHidden:value];
    [self.phoneField setHidden:value];
    [self.phoneLabel setHidden:value];
    [self.webLabel setHidden:value];
    [self.webField setHidden:value];
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
    
    [self dismissViewControllerAnimated:YES completion:^{
//        NSDictionary* userInfo = @{@"total": @"Azher"};
//        
//        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
//        [nc postNotificationName:@"NotificationMessageEvent" object:self userInfo:userInfo];
//        [(CreateQRCodeViewController *)self.presentingViewController setChecking:@"Azher"];
    }];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.codeTypes count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    [self.typeOfCode setUserInteractionEnabled:NO];
    return [self.codeTypes objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(row == 1){
        self.textForCode.text = @"";
        self.textForCode.placeholder = @"Enter Bar Code";
        self.textForCode.keyboardType = UIKeyboardTypePhonePad;
    }
    else if (row == 0){
        [self prepareForWriting];
    }
    self.typeOfCode.text = [self.codeTypes objectAtIndex:row];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    [self.typeOfCode setEnabled:NO];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
}
- (UIImage *)imageFromCIImage:(CIImage *)ciImage {
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [ciContext createCGImage:ciImage fromRect:[ciImage extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}
- (IBAction)createCodeAction:(id)sender {
    if([self.typeOfCode.text isEqualToString:@"QRCode"]){
        
        NSString *tmpStr = [NSString stringWithFormat:@"%@",self.textForCode.text];
        //    NSData *stringData = [tmpStr dataUsingEncoding: NSUTF8StringEncoding];
        NSData *stringData = [tmpStr dataUsingEncoding: NSISOLatin1StringEncoding];
        
        CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
        
        
        CGFloat scaleX = 10;
        CGFloat scaleY = 10;
        CIImage *transformedImage = [qrFilter.outputImage imageByApplyingTransform:CGAffineTransformMakeScale(scaleX, scaleY)];
        
        UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];

//        myImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
        myImageView.image = [self imageFromCIImage:transformedImage];
        [self.view addSubview:myImageView];
        [self dismissViewControllerAnimated:YES completion:^{
            NSDate *todayDate = [NSDate date]; //Get todays date
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date.
//            [dateFormatter setDateFormat:@"dd-MM-yyyy"]; //Here we can set the format which we need
            NSString *myFormatter = [[NSUserDefaults standardUserDefaults] objectForKey:@"Date"];
            [dateFormatter setDateFormat:myFormatter];
            NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
            
            HistoryData *tmpData = [HistoryData new];
            tmpData.myImage = myImageView.image;
            tmpData.resultTime = convertedDateString;
            tmpData.resultType = self.typeOfCreation;
            
            tmpData.resultText = self.textForCode.text;
            if([self.typeOfCreation  isEqual: @"Contact-Info"]){
                
                tmpData.resultText = [self vCardRepresentation];
                NSLog(@"My VCard is %@",tmpData.resultText);
            }
            else if([self.typeOfCreation  isEqual: @"SMS"]){
                
                NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                [tmpArray addObject:@"To:"];
                [tmpArray addObject:self.textForCode.text];
                [tmpArray addObject:@"Message body:"];
                [tmpArray addObject:self.lastNameField.text];
                tmpData.resultText = [tmpArray componentsJoinedByString:@"\n"];
//                tmpData.resultText = [self vCardRepresentation];
                NSLog(@"My VCard is %@",tmpData.resultText);
            }
            else if ([self.typeOfCreation isEqualToString:@"Baidu"]){
                
                NSString *finalString = [self.textForCode.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                tmpData.resultText = [NSString stringWithFormat:@"http://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=0&rsv_idx=1&tn=baidu&wd=%@&rsv_pq=8828100f000021ca&rsv_t=30148ZnJOP%2Fp5vSWMqe79fqkwMd1FmKVPfaRO3uKdwuuApkR%2BL%2FnDKhDRZ0&rqlang=cn&rsv_enter=1&rsv_sug3=8&rsv_sug2=0&inputT=1187&rsv_sug4=1187",finalString];
            }
            else if ([self.typeOfCreation isEqualToString:@"Sogou"]){
                
                NSString *finalString = [self.textForCode.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                tmpData.resultText = [NSString stringWithFormat:@"https://www.sogou.com/web?query=%@",finalString];
            }
            else if ([self.typeOfCreation isEqualToString:@"Yandex"]){
                
                NSString *finalString = [self.textForCode.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                tmpData.resultText = [NSString stringWithFormat:@"https://www.yandex.com/search/?msid=1505971872.15408.22878.3513&text=%@&lr=10616",finalString];
            }
            else if ([self.typeOfCreation isEqualToString:@"Ask"]){
                
                NSString *finalString = [self.textForCode.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                tmpData.resultText = [NSString stringWithFormat:@"https://uk.ask.com/web?q=%@&qsrc=0&o=0&l=dir&qo=homepageSearchBox",finalString];
            }
            else if ([self.typeOfCreation isEqualToString:@"AOL"]){
                
                NSString *finalString = [self.textForCode.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                tmpData.resultText = [NSString stringWithFormat:@"https://search.aol.com/aol/search?s_chn=prt_bon&q=%@&s_it=comsearch",finalString];
            }
            else if ([self.typeOfCreation isEqualToString:@"DuckDuckGo"]){
                
                NSString *finalString = [self.textForCode.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                tmpData.resultText = [NSString stringWithFormat:@"https://duckduckgo.com/?q=%@&t=h_",finalString];
            }
            else if([self.typeOfCreation isEqualToString:@"Google"] || [self.typeOfCreation isEqualToString:@"Bing"]){
                NSString *finalString = [self.textForCode.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                tmpData.resultText = [NSString stringWithFormat:@"http://www.%@.com/search?q=%@",self.typeOfCreation,finalString];
            }
            
            NSDictionary* userInfo = @{@"total": tmpData};
            
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:@"NotificationMessageEvent" object:self userInfo:userInfo];
        }];
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
            

            UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2)-150, self.view.frame.size.height - 200, 300, 100)];
            //        self.qrImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
//            myImageView.image = [UIImage imageWithCIImage:qrFilter.outputImage];
            myImageView.image = [self imageFromCIImage:qrFilter.outputImage];
            [self.view addSubview:myImageView];
            // newString consists only of the digits 0 through 9
            [self dismissViewControllerAnimated:YES completion:^{
                NSDate *todayDate = [NSDate date]; //Get todays date
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date.
                [dateFormatter setDateFormat:@"dd-MM-yyyy"]; //Here we can set the format which we need
                NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
                
                HistoryData *tmpData = [HistoryData new];
                tmpData.myImage = myImageView.image;
                tmpData.resultTime = convertedDateString;
                tmpData.resultType = self.typeOfCreation;
                tmpData.resultText = self.textForCode.text;
                
                NSDictionary* userInfo = @{@"total": tmpData};
                
                NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
                [nc postNotificationName:@"NotificationMessageEvent" object:self userInfo:userInfo];
            }];
        }
        else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Numeric Values Found" message:@"Bar Code needs Numeric Values" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}
@end
