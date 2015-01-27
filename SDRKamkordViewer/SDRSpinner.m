//
//  SDRSpinner.m
//  SDRKamkordViewer
//
//  Created by Shane Rogers on 1/25/15.
//  Copyright (c) 2015 SDR. All rights reserved.
//

#import "SDRSpinner.h"

@implementation SDRSpinner


- (void)setSpinnerImagesWithView:(UIView *)view {
    UIImage *img = [UIImage imageNamed:@"13.png"];
    [self setImage:img];

    //Add more images which will be used for the animation
    self.animationImages = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"13.png"],
                            [UIImage imageNamed:@"12.png"],
                            [UIImage imageNamed:@"11.png"],
                            [UIImage imageNamed:@"10.png"],
                            [UIImage imageNamed:@"9.png"],
                            [UIImage imageNamed:@"8.png"],
                            [UIImage imageNamed:@"7.png"],
                            [UIImage imageNamed:@"6.png"],
                            [UIImage imageNamed:@"5.png"],
                            [UIImage imageNamed:@"4.png"],
                            [UIImage imageNamed:@"3.png"],
                            [UIImage imageNamed:@"2.png"],
                            [UIImage imageNamed:@"1.png"],
                            [UIImage imageNamed:@"2.png"],
                            [UIImage imageNamed:@"3.png"],
                            [UIImage imageNamed:@"4.png"],
                            [UIImage imageNamed:@"5.png"],
                            [UIImage imageNamed:@"6.png"],
                            [UIImage imageNamed:@"7.png"],
                            [UIImage imageNamed:@"8.png"],
                            [UIImage imageNamed:@"9.png"],
                            [UIImage imageNamed:@"10.png"],
                            [UIImage imageNamed:@"11.png"],
                            [UIImage imageNamed:@"12.png"],
                            [UIImage imageNamed:@"13.png"], nil];

    self.animationDuration = 1.8;
    [self setFrame:CGRectMake(0.0f, 0.0f, 110.0f, 75.0f)];
    [self setCenter:view.center];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
