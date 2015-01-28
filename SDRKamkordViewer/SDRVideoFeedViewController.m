//
//  SDRVideoFeedViewController.m
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/24/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import "SDRVideoFeedViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <MediaPlayer/MediaPlayer.h>

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
@property (nonatomic, strong) SDRVideoChannel *videoChannel;
@property (nonatomic, strong) SDRSpinner *spinner;
@property (nonatomic, strong) MPMoviePlayerController *videoPlayer;

@end

@implementation SDRVideoFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addVideosTable];
    self.spinner = [SDRSpinner new];
    [self fetchVideos];
}

- (void)fetchVideos {
    [self showOrHideSpinner:YES];

    void(^completionBlock)(SDRVideoChannel *obj, NSError *err)=^(SDRVideoChannel *obj, NSError *err){
        if(!err){
            self.videoChannel = obj;
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
        [self.spinner setSpinnerImagesWithView:self.view];

        [self.spinner startAnimating];
        [self.view addSubview:self.spinner];
    } else {
        [self.spinner stopAnimating];
        [self.spinner removeFromSuperview];
    }
}

- (void)addVideosTable {
    self.videoFeed = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.videoFeed setBackgroundColor:[UIColor clearColor]];
    [self.videoFeed setSeparatorColor:[UIColor clearColor]];
    self.videoFeed.backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.videoFeed.backgroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"launch_screen"]]];

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

#pragma UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.videoChannel.videos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:kSDRVideoFeedTableViewCell owner:nil options:nil];
    SDRVideoFeedTableViewCell *cell = [nibContents lastObject];

    if([tableView isEqual:self.videoFeed]) {
        SDRVideo *video = [self.videoChannel.videos objectAtIndex:[indexPath row]];

        [cell.videoTitle setText:video.title];
        [cell.videoThumbnail sd_setImageWithURL:[NSURL URLWithString:video.thumbnailUrl] placeholderImage:nil];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SDRVideo *video = [self.videoChannel.videos objectAtIndex:[indexPath row]];

    if (self.videoPlayer != nil){
        [self stopPlayingVideo:nil];
    }

    MPMoviePlayerController *videoPlayer =[[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:video.videoUrl]];
    self.videoPlayer = videoPlayer;

    if (self.videoPlayer != nil){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(videoHasFinishedPlaying:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:self.videoPlayer];

        self.videoPlayer.scalingMode = MPMovieScalingModeAspectFit;
        [self.view addSubview:self.videoPlayer.view];
        [self.videoPlayer setFullscreen:YES
                               animated:NO];

        [self.videoPlayer play];
    } else {
        NSLog(@"Failed to initalize the video player");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSDRVideoFeedCellHeight;
}

#pragma VideoPlayer methods
- (void)stopPlayingVideo:(id)paramSender {
    if (self.videoPlayer != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:self.videoPlayer];

        [self.videoPlayer stop];
        [self.videoPlayer.view removeFromSuperview];
    }
}

- (void)videoHasFinishedPlaying:(NSNotification *)paramNotification {
    NSNumber *reason = paramNotification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];

    if (reason != nil) {
        NSInteger reasonAsInteger = [reason integerValue];

        switch (reasonAsInteger){
            case MPMovieFinishReasonPlaybackEnded:{
                NSLog(@"MPMovieFinishReasonPlaybackEnded");
                break; }
            case MPMovieFinishReasonPlaybackError:{
                NSLog(@"MPMovieFinishReasonPlaybackError");
                break;
            }
            case MPMovieFinishReasonUserExited:{
                NSLog(@"MPMovieFinishReasonUserExited");
                break;
            }
        }
        [self stopPlayingVideo:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end