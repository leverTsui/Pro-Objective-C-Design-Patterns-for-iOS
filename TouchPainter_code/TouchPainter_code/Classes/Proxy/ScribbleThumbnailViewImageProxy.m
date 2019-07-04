//
//  ScribbleThumbnailProxy.m
//  TouchPainter
//
//  Created by Carlo Chung on 10/3/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "ScribbleThumbnailViewImageProxy.h"

// A private category for a forward loading thread 
@interface ScribbleThumbnailViewImageProxy () 

@property (nonatomic, assign) BOOL loadingThreadHasLaunched;

@property (nonatomic, strong) UIImage *realImage; 

@end

@implementation ScribbleThumbnailViewImageProxy

- (Scribble *)scribble {
  if (_scribble == nil) {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *scribbleData = [fileManager contentsAtPath:self.scribblePath];
    ScribbleMemento *scribbleMemento = [ScribbleMemento mementoWithData:scribbleData];
    _scribble = [Scribble scribbleWithMemento:scribbleMemento];
  }
  return _scribble;
}

- (UIImage *)image {
  if (self.realImage == nil) {
    self.realImage = [[UIImage alloc] initWithContentsOfFile:self.imagePath];
  }
  return self.realImage;
}


// A forward call will be established
// in a sperate thread to get a real payload from 
// a real image.
// Before a real pay load is returned,
// drawRect: will handle the background
// loading process and draw a placeholder frame.
// Once the real payload is loaded, 
// it will redraw itself with the real one.
- (void)drawRect:(CGRect)rect {
  // if is no real image available
  // from realImageView_,
  // then just draw a blank frame
  // as a placeholder image
  if (self.realImage == nil)
  {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw a placeholder frame
    // with a 10-user-space-unit-long painted
    // segment and a 3-user-space-unit-long
    // unpainted segment of a dash line
    CGContextSetLineWidth(context, 10.0);
    const CGFloat dashLengths[2] = {10,3};
    CGContextSetLineDash (context, 3, dashLengths, 2);
    CGContextSetStrokeColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // launch a thread to load the real
    // payload if it hasn't done yet
    if (!self.loadingThreadHasLaunched)
    {
      [self performSelectorInBackground:@selector(forwardImageLoadingThread) 
                             withObject:nil];
      self.loadingThreadHasLaunched = YES;
    }
  }
  // otherwise pass the draw*: message
  // along to realImage_ and let it
  // draw the real image
  else 
  {
    [self.realImage drawInRect:rect];
  }
}

#pragma mark Touch event handlers

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.touchCommand execute];
}

#pragma mark -
#pragma mark A private method for loading a real image in a thread

- (void) forwardImageLoadingThread {  
  // forward the message to load
  // the real image payload
  [self image];
  
  // redraw itself with the newly loaded image
  [self performSelectorInBackground:@selector(setNeedsDisplay) withObject:nil];
}

@end

