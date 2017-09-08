//
//  HistoryData.h
//  QRReader
//
//  Created by Muhammad Azher on 05/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HistoryData : NSObject
@property (nonatomic,strong) NSString *resultType;
@property (nonatomic,strong) NSString *resultText;
@property (nonatomic,strong) NSString *resultTime;
@property (nonatomic) NSString *resultImageString;
@property (nonatomic,strong) UIImage *myImage;


@end
