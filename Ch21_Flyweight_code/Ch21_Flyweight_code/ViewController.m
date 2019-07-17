//
//  ViewController.m
//  Ch21_Flyweight_code
//
//  Created by 徐利华 on 2019/7/17.
//  Copyright © 2019 徐利华. All rights reserved.
//

#import "ViewController.h"
#import "FlowerFactory.h"
#import "ExtrinsicFlower.h"
#import "FlyweightView.h"

@interface ViewController ()


@property (nonatomic, strong)  FlyweightView *flyweightView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.flyweightView];
    
    
    // construct a flower list
    FlowerFactory *factory = [[FlowerFactory alloc] init];
    NSMutableArray *flowerList = [[NSMutableArray alloc] initWithCapacity:500];
    
    for (int i = 0; i < 100; ++i) {
        // retrieve a shared instance
        // of a flower flyweight object
        // from a flower factory with a
        // random flower type
        FlowerType flowerType = arc4random() % kTotalNumberOfFlowerTypes;
        UIView *flowerView = [factory flowerViewWithType:flowerType];
        
        // set up a location and an area for the flower
        // to display onscreen
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        CGFloat x = (arc4random() % (NSInteger)screenBounds.size.width);
        CGFloat y = (arc4random() % (NSInteger)screenBounds.size.height);
        NSInteger minSize = 10;
        NSInteger maxSize = 50;
        CGFloat size = (arc4random() % (maxSize - minSize + 1)) + minSize;
        
        // assign attributes for a flower
        // to an extrinsic state object
        ExtrinsicFlower *extrinsicState = [[ExtrinsicFlower alloc] init];
        extrinsicState.flowerView = flowerView;
        extrinsicState.area = CGRectMake(x, y, size, size);
        
        // add an extrinsic flower state
        // to the flower list
        [flowerList addObject:extrinsicState];
    }
    
    // add the flower list to
    // this FlyweightView instance
    [self.flyweightView setFlowerList:flowerList];
}

#pragma mark - getter & setter

- (FlyweightView *)flyweightView {
    if (!_flyweightView) {
        _flyweightView = [[FlyweightView alloc] initWithFrame:self.view.frame];
    }
    return _flyweightView;
}

@end
