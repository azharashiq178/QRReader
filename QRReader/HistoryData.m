//
//  HistoryData.m
//  QRReader
//
//  Created by Muhammad Azher on 05/09/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "HistoryData.h"

@implementation HistoryData
-(void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode the properties of the object
    [encoder encodeObject:self.resultType forKey:@"resultType"];
    [encoder encodeObject:self.resultText forKey:@"resultText"];
    [encoder encodeObject:self.resultTime forKey:@"resultTime"];
    [encoder encodeObject:self.resultImageString forKey:@"resultImageString"];
    [encoder encodeObject:self.myImage forKey:@"myImage"];
    
}
- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _resultType = [coder decodeObjectForKey:@"resultType"];
        _resultText = [coder decodeObjectForKey:@"resultText"];
        _resultTime = [coder decodeObjectForKey:@"resultTime"];
        _resultImageString = [coder decodeObjectForKey:@"resultImageString"];
        _myImage = [coder decodeObjectForKey:@"myImage"];
    }
    return self;
}
@end
