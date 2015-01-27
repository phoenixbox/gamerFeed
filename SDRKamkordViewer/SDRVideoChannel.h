//
//  SDRVideoChannel.h
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/25/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRVideo.h"
#import "JSONModel.h"

@interface SDRVideoChannel : JSONModel

@property (strong, nonatomic) NSArray<SDRVideo> *videos;

@end
