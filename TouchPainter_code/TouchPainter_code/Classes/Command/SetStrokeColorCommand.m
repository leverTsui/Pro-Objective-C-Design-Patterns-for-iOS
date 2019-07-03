//
//  StrokeColorCommand.m
//  TouchPainter
//
//  Created by Carlo Chung on 11/9/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "SetStrokeColorCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"

@implementation SetStrokeColorCommand

- (void)execute {
    CGFloat redValue = 0.0;
    CGFloat greenValue = 0.0;
    CGFloat blueValue = 0.0;

    // Retrieve RGB values from a delegate or a block

    // Delegation (object adapter) approach:

    if (self.delegate && [self.delegate respondsToSelector:@selector(command:didRequestColorComponentsForRed:green:blue:)]) {
        [self.delegate command:self didRequestColorComponentsForRed:&redValue
                     green:&greenValue
                      blue:&blueValue];
    }

    // Block approach:
    if(self.RGBValuesProvider) {
        self.RGBValuesProvider(&redValue, &greenValue, &blueValue);
    }

    // Create a color object based on the RGB values
    UIColor *color = [UIColor colorWithRed:redValue
                                   green:greenValue
                                    blue:blueValue
                                   alpha:1.0];

    // Assign it to the current canvasViewController
    CoordinatingController *coordinator = [CoordinatingController sharedInstance];
    CanvasViewController *controller = [coordinator canvasViewController];
    [controller setStrokeColor:color];

    // Forward a post update message

    // Delegation approach:
    if (self.delegate && [self.delegate respondsToSelector:@selector(command:didFinishColorUpdateWithColor:)]) {
        [self.delegate command:self didFinishColorUpdateWithColor:color];
    }

    // Block approach:
    if (self.postColorUpdateProvider) {
        self.postColorUpdateProvider(color);
    }
} 

@end
