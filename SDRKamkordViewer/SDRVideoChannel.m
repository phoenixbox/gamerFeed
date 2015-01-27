//
//  SDRVideoChannel.m
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/25/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import "SDRVideoChannel.h"

@implementation SDRVideoChannel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"response.video_list": @"videos"
                                                       }];
}


@end
