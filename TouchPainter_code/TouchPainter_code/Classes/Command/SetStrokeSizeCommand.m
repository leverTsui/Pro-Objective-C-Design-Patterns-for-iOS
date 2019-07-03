//
//  StrokeSizeCommand.m
//  TouchPainter
//
//  Created by Carlo Chung on 11/9/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "SetStrokeSizeCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"

@implementation SetStrokeSizeCommand

- (void)execute {
    // get the current stroke size
    // from whatever it's my delegate
    CGFloat strokeSize = 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(command:didRequestForStrokeSize:)]) {
        [self.delegate command:self didRequestForStrokeSize:&strokeSize];
    }

    // get a hold of the current
    // canvasViewController from
    // the coordinatingController
    // (see the Mediator pattern chapter
    // for details)
    CoordinatingController *coordinator = [CoordinatingController sharedInstance];
    CanvasViewController *controller = [coordinator canvasViewController];

    // assign the stroke size to
    // the canvasViewController
    [controller setStrokeSize:strokeSize];
}

@end
