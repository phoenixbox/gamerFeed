//
//  SDRVideoStore.h
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/25/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SDRVideoChannel.h"

@interface SDRVideoStore : NSObject

+ (SDRVideoStore *)sharedStore;

- (void)fetchVideosWithCompletion:(void (^)(SDRVideoChannel *videoChannel, NSError *err))block;

@end
