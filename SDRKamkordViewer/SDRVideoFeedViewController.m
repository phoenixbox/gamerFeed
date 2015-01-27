//
//  SDRVideoFeedViewController.m
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/24/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import "SDRVideoFeedViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

// Components
#import "SDRVideoFeedTableViewCell.h"
#import "SDRSpinner.h"

// Constants
#import "SDRComponentConstants.h"

// Data Layer
#import "SDRVideoStore.h"
#import "SDRVideoChannel.h"

@interface SDRVideoFeedViewController ()

@property (nonatomic, strong) UITableView *videoFeed;
@property (nonatomic, strong) SDRVideoChannel *_videoChannel;
@property (nonatomic, strong) SDRSpinner *_spinner;

@end

@implementation SDRVideoFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addVideosTable];
    self._spinner = [SDRSpinner new];
    [self fetchVideos];
}

- (void)fetchVideos {
    [self showOrHideSpinner:YES];

    void(^completionBlock)(SDRVideoChannel *obj, NSError *err)=^(SDRVideoChannel *obj, NSError *err){
        if(!err){
            self._videoChannel = obj;
            [self.videoFeed reloadData];
        } else {
            [self renderError:err];
        }
        [self showOrHideSpinner:NO];
    };
    [[SDRVideoStore sharedStore] fetchVideosWithCompletion:completionBlock];
}

- (void)renderError:(NSError *)err {
    [[[UIAlertView alloc] initWithTitle:err.localizedDescription
                                message:err.localizedRecoverySuggestion
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil, nil] show];

}

- (void)showOrHideSpinner:(BOOL)value {
    if(value) {
        [self._spinner setSpinnerImagesWithView:self.view];

        [self._spinner startAnimating];
        [self.view addSubview:self._spinner];
    } else {
        [self._spinner stopAnimating];
        [self._spinner removeFromSuperview];
    }
}

- (void)addVideosTable {
    self.videoFeed = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.videoFeed setSeparatorColor:[UIColor clearColor]];
    self.videoFeed.backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.videoFeed.backgroundView setBackgroundColor:[UIColor grayColor]];

    [self.videoFeed registerClass:[UITableViewCell class] forCellReuseIdentifier:kSDRVideoFeedTableViewCell];
    self.videoFeed.delegate = self;
    self.videoFeed.dataSource = self;
    self.videoFeed.scrollEnabled = YES;
    self.videoFeed.showsVerticalScrollIndicator = NO;

    if ([self.videoFeed respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.videoFeed setSeparatorInset:UIEdgeInsetsZero];
    }

    [self.view addSubview:self.videoFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self._videoChannel.videos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:kSDRVideoFeedTableViewCell owner:nil options:nil];
    SDRVideoFeedTableViewCell *cell = [nibContents lastObject];


    if([tableView isEqual:self.videoFeed]) {
        SDRVideo *video = [self._videoChannel.videos objectAtIndex:[indexPath row]];

        [cell.videoTitle setText:video.title];
        [cell.videoThumbnail sd_setImageWithURL:[NSURL URLWithString:video.thumbnailUrl] placeholderImage:nil];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSDRVideoFeedCellHeight;
}

@end
