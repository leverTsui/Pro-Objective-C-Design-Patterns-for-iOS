//
//  CoordinatingController.h
//  TouchPainter
//
//  Created by Carlo Chung on 10/18/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CanvasViewController.h"
#import "PaletteViewController.h"
#import "ThumbnailViewController.h"

typedef NS_ENUM(NSUInteger, ButtonTag) {
    kButtonTagDone,
    kButtonTagOpenPaletteView,
    kButtonTagOpenThumbnailView
}; 

@interface CoordinatingController : NSObject

@property (nonatomic, strong, readonly) CanvasViewController *canvasViewController;

+ (CoordinatingController *) sharedInstance;

- (void)requestViewChangeByObject:(id)object;

@end
