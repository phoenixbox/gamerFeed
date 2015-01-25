//
//  SDRVideoFeedTableViewCell.h
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/25/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRCellActionsView.h"

@interface SDRVideoFeedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *videoThumbnail;
@property (strong, nonatomic) IBOutlet UIView *videoDuration;
@property (strong, nonatomic) IBOutlet UILabel *videoTitle;
@property (strong, nonatomic) IBOutlet UILabel *videoDescription;

@property (strong, nonatomic) IBOutlet SDRCellActionsView *cellActionsView;

@end
