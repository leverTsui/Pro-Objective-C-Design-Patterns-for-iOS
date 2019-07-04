//
//  CoordinatingController.m
//  TouchPainter
//
//  Created by Carlo Chung on 10/18/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "CoordinatingController.h"

@interface CoordinatingController ()

@property (nonatomic, strong) CanvasViewController *canvasViewController;

@end

@implementation CoordinatingController

#pragma mark - life cycle

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CoordinatingController *sharedCoordinator;
    dispatch_once(&onceToken, ^{
        sharedCoordinator = [[CoordinatingController alloc] init];
    });
    return sharedCoordinator;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.canvasViewController = [[CanvasViewController alloc] init];
    }
    return self;
}

- (void)requestViewChangeByObject:(id)object {
    [self.canvasViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - getter & setter


@end
