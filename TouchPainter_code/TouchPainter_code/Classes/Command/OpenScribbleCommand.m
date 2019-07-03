//
//  OpenScribbleCommand.m
//  TouchPainter
//
//  Created by Carlo Chung on 11/9/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "OpenScribbleCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"

@implementation OpenScribbleCommand

- (id)initWithScribbleSource:(id <ScribbleSource>) aScribbleSource {
  if (self = [super init]) {
      self.scribbleSource = aScribbleSource;
  }
  
  return self;
}

- (void)execute {
  // get a scribble from the scribbleSource_
  Scribble *scribble = [self.scribbleSource scribble];
  
  // set it to the current CanvasViewController
  CoordinatingController *coordinator = [CoordinatingController sharedInstance];
  CanvasViewController *controller = [coordinator canvasViewController];
  [controller setScribble:scribble];
  
  // then tell the coordinator to change views
  [coordinator requestViewChangeByObject:self];
}

@end
