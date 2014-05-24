//
//  Werewolf.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Werewolf.h"

@implementation Werewolf

-(id)initWithGame:(Game*)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Werewolf";
        self.faction = kWerewolfFaction;
        self.seerSeesAs = @"Werewolf";
        self.roleID = kWerewolf;
    }
    
    return self;
}

- (NSString *)getNightZeroInfo
{
    NSString *message = [super getNightZeroInfo];
    
    message = [message stringByAppendingString:[NSString stringWithFormat:@"\n\n%@", [self.game listOfWolves]]];
    
    return message;
}

-(NSString *)tapLabel
{
    return [NSString stringWithFormat:@"%@. Who do you want to kill?", [self.game listOfWolves]];
}

- (NSString *)verifyNightAction
{
    if ([self.game.wolves count] > 1) {
        return @"If Werewolves do not agree on the kill, a target will be chosen at random from among the picks.";
    }
    return @"";
}

- (void)performNightActionWithSelectedPlayer:(Player *)player
{
    [super performNightActionWithSelectedPlayer:player];
    [self.game.wolfTargets addObject:player];
}

@end
