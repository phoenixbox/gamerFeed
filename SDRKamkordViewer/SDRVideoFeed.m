//
//  ViewController.m
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/24/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import "SDRVideoFeed.h"

// Components
#import "SDRVideoFeedTableViewCell.h"

// Constants
#import "SDRComponentConstants.h"

@interface SDRVideoFeed ()

@property (nonatomic, strong) UITableView *_videoFeed;

@end

@implementation SDRVideoFeed

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addVideosTable];
}

- (void)addVideosTable {
    self._videoFeed = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self._videoFeed setSeparatorColor:[UIColor blackColor]];
    [self._videoFeed setBackgroundColor:[UIColor greenColor]];
    [self._videoFeed registerClass:[UITableViewCell class] forCellReuseIdentifier:kSDRVideoFeedTableViewCell];
    self._videoFeed.delegate = self;
    self._videoFeed.dataSource = self;
    self._videoFeed.scrollEnabled = YES;
    self._videoFeed.showsVerticalScrollIndicator = NO;

    if ([self._videoFeed respondsToSelector:@selector(setSeparatorInset:)]) {
        [self._videoFeed setSeparatorInset:UIEdgeInsetsZero];
    }

    [self.view addSubview:self._videoFeed];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Load the custom xib
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:kSDRVideoFeedTableViewCell owner:nil options:nil];
    SDRVideoFeedTableViewCell *cell = [nibContents lastObject];

    if([tableView isEqual:self._videoFeed]){
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSDRVideoFeedCellHeight;
}

@end
