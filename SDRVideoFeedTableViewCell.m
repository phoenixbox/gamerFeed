//
//  SDRVideoFeedTableViewCell.m
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/25/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import "SDRVideoFeedTableViewCell.h"

@implementation SDRVideoFeedTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.paddingContainer.layer.cornerRadius = 2.0;
    self.paddingContainer.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
