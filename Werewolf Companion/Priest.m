//
//  Priest.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Priest.h"

@implementation Priest

-(id)initWithGame:(Game*)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Priest";
        self.roleID = kPriest;
    }
    
    return self;
}

- (NSString *)tapLabel
{
    return @"Priest, who do you want to save?";
}

- (NSString *)verifyNightAction
{
    return @"Do you want to protect them?";
}

- (void)performNightActionWithSelectedPlayer:(Player *)player
{
    [super performNightActionWithSelectedPlayer:player];
    player.isPriestTarget = YES;
}

@end
