//
//  Role.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Role.h"


@implementation Role

-(id)initWithGame:(Game *)game
{
    if (self = [super init])
    {
        _game = game;
        _faction = kTownFaction;
        _seerSeesAs = @"Human";
        _oncePerGameUsed = NO;
    }
    return self;
}

-(NSString *)getNightZeroInfo
{
    return [LLConstants listOfRoleDescriptions][_roleID];
}

-(NSString *)tapLabel
{
    return [NSString stringWithFormat:@"%@, guess who you think the Werewolf is!", _name];
}

-(NSString *)verifyNightAction
{
    return @"Do you think this is the Werewolf?";
}

- (void)performNightActionWithSelectedPlayer:(Player *)player
{
    [self.player.nightActions addObject:player];
}

@end
