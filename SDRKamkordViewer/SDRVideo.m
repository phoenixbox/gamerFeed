//
//  SDRVideo.m
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/25/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import "SDRVideo.h"

@implementation SDRVideo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"username": @"username",
                                                       @"thumbnails.REGULAR": @"thumbnailUrl",
                                                       @"upload_time": @"uploadTime",
                                                       @"title": @"title",
                                                       @"video_url": @"videoUrl",
                                                       @"duration": @"duration",
                                                       @"video_id": @"videoId",
                                                       @"game_name": @"gameName",
                                                       @"interaction_counts.likes": @"likes",
                                                       @"interaction_counts.views": @"views",
                                                       @"interaction_counts.comments": @"comments"
                                                       }];
}

@end
