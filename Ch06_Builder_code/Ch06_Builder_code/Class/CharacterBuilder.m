//
//  CharacterBuilder.m
//  Builder
//
//  Created by Carlo Chung on 11/27/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "CharacterBuilder.h"

@interface CharacterBuilder ()

@property (nonatomic, strong) Character *character;

@end

@implementation CharacterBuilder

- (CharacterBuilder *)buildNewCharacter {
  self.character = [[Character alloc] init];
  
  return self;
}

- (CharacterBuilder *) buildStrength:(float) value
{
  self.character.strength = value;
  return self;
}

- (CharacterBuilder *) buildStamina:(float) value
{
  self.character.stamina = value;
  return self;
}

- (CharacterBuilder *) buildIntelligence:(float) value
{
  self.character.intelligence = value;
  return self;
}

- (CharacterBuilder *) buildAgility:(float) value
{
  self.character.agility = value;
  return self;
}

- (CharacterBuilder *) buildAggressiveness:(float) value
{
  self.character.aggressiveness = value;
  return self;
}
 

@end
