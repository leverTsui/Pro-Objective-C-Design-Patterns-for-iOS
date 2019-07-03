//
//  CoordinatingController.m
//  TouchPainter
//
//  Created by Carlo Chung on 10/18/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "CoordinatingController.h"

@interface CoordinatingController ()

@property (nonatomic, strong) UIViewController *activeViewController;

@property (nonatomic, strong) CanvasViewController *canvasViewController;

@end

@implementation CoordinatingController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.canvasViewController = [[CanvasViewController alloc] init];
        self.activeViewController = self.canvasViewController;
    }
    return self;
}

#pragma mark -
#pragma mark CoordinatingController Singleton Implementation

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static CoordinatingController *sharedCoordinator;
    dispatch_once(&onceToken, ^{
        sharedCoordinator = [[CoordinatingController alloc] init];
    });
    return sharedCoordinator;
} 

#pragma mark -
#pragma mark A method for view transitions

- (IBAction)requestViewChangeByObject:(id)object {
  if ([object isKindOfClass:[UIBarButtonItem class]]) {
    switch ([(UIBarButtonItem *)object tag]) 
    {
      case kButtonTagOpenPaletteView:
      {
        // load a PaletteViewController
        PaletteViewController *controller = [[PaletteViewController alloc] init];
        
        // transition to the PaletteViewController
        [self.canvasViewController presentModalViewController:controller
                                                     animated:YES];
        
        // set the activeViewController to 
        // paletteViewController
        self.activeViewController = controller;
      }
        break;
      case kButtonTagOpenThumbnailView:
      {
        // load a ThumbnailViewController
        ThumbnailViewController *controller = [[ThumbnailViewController alloc] init];
        
        
        // transition to the ThumbnailViewController
        [self.canvasViewController presentModalViewController:controller
                                                      animated:YES];
        
        // set the activeViewController to
        // ThumbnailViewController
        self.activeViewController = controller;
      }
        break;
      default:
        // just go back to the main canvasViewController
        // for the other types 
      {
        // The Done command is shared on every 
        // view controller except the CanvasViewController
        // When the Done button is hit, it should
        // take the user back to the first page in
        // conjunction with the design
        // other objects will follow the same path
        [self.canvasViewController dismissModalViewControllerAnimated:YES];
        
        // set the activeViewController back to 
        // canvasViewController
        self.activeViewController = self.canvasViewController;
      }
        break;
    }
  }
  // every thing else goes to the main canvasViewController
  else 
  {
    [self.canvasViewController dismissModalViewControllerAnimated:YES];
    
    // set the activeViewController back to 
    // canvasViewController
    self.activeViewController = self.canvasViewController;
  }
  
}

#pragma mark - getter & setter


@end
