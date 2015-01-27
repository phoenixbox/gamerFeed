//
//  SDRVideo.h
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/25/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol SDRVideo @end

@interface SDRVideo : JSONModel

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic) NSNumber *uploadTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic) NSNumber *duration;
@property (nonatomic) NSNumber *videoId;
@property (nonatomic, strong) NSString *gameName;
@property (nonatomic) NSNumber *likes;
@property (nonatomic) NSNumber *views;
@property (nonatomic) NSNumber *comments;
@property (nonatomic, strong) UIImage<Optional> *thumbnail;

@end
