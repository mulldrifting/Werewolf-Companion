//
//  Player.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//


#import "Player.h"
#import "Role.h"

@interface Player ()

// Private interface goes here.

@end


@implementation Player

@synthesize game;
@synthesize role;
@synthesize tempName;
@synthesize target;
@synthesize nightActions;
@synthesize index;
@synthesize isDead;
@synthesize isPriestTarget;
@synthesize isWolfTarget;
@synthesize isVigilanteTarget;
@synthesize isNemesisTarget;

- (void)initializeNewPlayerWithGame:(Game *)theGame atIndex:(NSInteger)theIndex
{
    self.game = theGame;
    self.nightActions = [NSMutableArray new];
    self.index = theIndex;
    self.isDead = NO;
    self.isPriestTarget = NO;
    self.isWolfTarget = NO;
    self.isVigilanteTarget = NO;
    self.isNemesisTarget = NO;
    
    self.name = [NSString stringWithFormat:@"Player %d", self.index];
}

- (void)performNightActionWithSelectedPlayer:(Player *)player
{
    [self.nightActions addObject:player];
}

@end
