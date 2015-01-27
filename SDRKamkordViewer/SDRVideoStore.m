//
//  SDRVideoStore.m
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/25/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import "SDRVideoStore.h"

#import "AFNetworking.h"

#define kKamkordVideoFeedEndpoint @"https://www.kamcord.com/app/v2/videos/feed/?feed_id=0"

@implementation SDRVideoStore

+ (SDRVideoStore *)sharedStore {
    static SDRVideoStore *videoStore = nil;

    static dispatch_once_t oncePredicate;

    dispatch_once(&oncePredicate, ^{
        videoStore = [[SDRVideoStore alloc] init];
    });
    return videoStore;
}


- (void)fetchVideosWithCompletion:(void (^)(SDRVideoChannel *videoChannel, NSError *err))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:kKamkordVideoFeedEndpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *rawJSON = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

        SDRVideoChannel *videoChannel = [[SDRVideoChannel alloc] initWithString:rawJSON error:nil];

        block(videoChannel, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}


@end
