//
//  HistoryViewController.h
//  QRReader
//
//  Created by Muhammad Azher on 31/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Messages/Messages.h>

@interface HistoryViewController : UIViewController <MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tmpTextField;

@end
