//
//  ViewController.h
//  QRReader
//
//  Created by Muhammad Azher on 30/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *resultString;
@property (strong,nonatomic) NSString *tmpResult;
@property (strong,nonatomic) NSString *myTitle;


@end

