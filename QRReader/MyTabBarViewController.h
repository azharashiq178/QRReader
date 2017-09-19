//
//  MyTabBarViewController.h
//  QRReader
//
//  Created by Muhammad Azher on 31/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabBarViewController : UITabBarController <UITabBarControllerDelegate>
@property (nonatomic,retain) NSString *myResultString;
@property (nonatomic,retain) NSString *myType;
@end
