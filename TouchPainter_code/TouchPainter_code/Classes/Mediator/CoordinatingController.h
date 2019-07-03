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

typedef enum
{
  kButtonTagDone,
  kButtonTagOpenPaletteView,
  kButtonTagOpenThumbnailView
} ButtonTag;

@interface CoordinatingController : NSObject

@property (nonatomic, strong, readonly) CanvasViewController *canvasViewController;

+ (CoordinatingController *) sharedInstance;

- (IBAction) requestViewChangeByObject:(id)object;

@end
