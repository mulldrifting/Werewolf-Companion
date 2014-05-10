//
//  Seer.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Seer.h"

@implementation Seer

-(id)initWithGame:(Game*)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Seer";
        self.roleID = kSeer;
    }
    
    return self;
}

- (NSString *)getNightZeroInfo
{
    NSString *message = [super getNightZeroInfo];
    Player *randomPlayer = [self.game randomNonWerewolf];
    BOOL doesSeerPeek = [[self.game.gameSetup.settings objectForKey:@"SEER_PEEKS_NIGHT_ZERO"] boolValue];
    
    if (doesSeerPeek) {
        message = [message stringByAppendingString:[NSString stringWithFormat:@"\n\nYou peek, and %@ looks like a %@", randomPlayer.name, randomPlayer.role.seerSeesAs]];
        [self.player.seerPeeks addObject:randomPlayer];
    }
    
    return message;
}

- (NSString *)tapLabel
{
    return @"Seer, who do you want to peek?";
}

@end
