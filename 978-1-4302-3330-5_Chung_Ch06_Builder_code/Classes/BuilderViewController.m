//
//  BuilderViewController.m
//  Builder
//
//  Created by Carlo Chung on 11/27/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "BuilderViewController.h"
#import "ChasingGame.h"
#import "StandardCharacterBuilder.h"

@implementation BuilderViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  CharacterBuilder *characterBuilder = [[[StandardCharacterBuilder alloc] init] autorelease];
  ChasingGame *game = [[[ChasingGame alloc] init] autorelease];
  
  Character *player = [game createPlayer:characterBuilder];
  Character *enemy = [game createEnemy:characterBuilder];
}

@end
