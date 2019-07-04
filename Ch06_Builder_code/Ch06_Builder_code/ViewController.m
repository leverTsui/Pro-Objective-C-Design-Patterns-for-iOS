//
//  ViewController.m
//  Ch06_Builder_code
//
//  Created by 徐利华 on 2019/7/4.
//  Copyright © 2019 徐利华. All rights reserved.
//

#import "ViewController.h"
#import "ChasingGame.h"
#import "StandardCharacterBuilder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CharacterBuilder *characterBuilder = [[StandardCharacterBuilder alloc] init];
    ChasingGame *game = [[ChasingGame alloc] init];
    
    Character *player = [game createPlayer:characterBuilder];
    Character *enemy = [game createEnemy:characterBuilder];
}

@end
