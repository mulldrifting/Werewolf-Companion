//
//  Player.h
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//


#import "_Player.h"

@class Game;
@class Role;

@interface Player : _Player {}

@property (weak, nonatomic) Game *game;
@property (strong, nonatomic) Role *role;
@property (copy, nonatomic) NSString *tempName;
@property (nonatomic) NSInteger index;

@property (strong, nonatomic) NSMutableArray *nightActions;

@property (nonatomic) BOOL isDead;

@property (nonatomic) BOOL isWolfTarget;
@property (nonatomic) BOOL isPriestTarget;
@property (nonatomic) BOOL isVigilanteTarget;
@property (nonatomic) BOOL isNemesisTarget;
@property (weak, nonatomic) Player *target;

- (void)initializeNewPlayerWithGame:(Game *)theGame atIndex:(NSInteger)theIndex;
- (void)performNightActionWithSelectedPlayer:(Player *)player;

@end
