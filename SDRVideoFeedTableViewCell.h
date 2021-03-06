//
//  SDRVideoFeedTableViewCell.h
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/25/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRVideo.h"

@interface SDRVideoFeedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *videoThumbnail;
@property (strong, nonatomic) IBOutlet UILabel *videoTitle;
@property (strong, nonatomic) IBOutlet UILabel *videoGameName;
@property (strong, nonatomic) IBOutlet UIView *paddingContainer;

@property (strong, nonatomic) SDRVideo *video;

@end