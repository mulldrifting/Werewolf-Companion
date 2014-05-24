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
    BOOL doesSeerPeek = [self.game.gameSetup.seerPeeksNightZero boolValue];
    
    if (doesSeerPeek) {
        message = [message stringByAppendingString:[NSString stringWithFormat:@"\n\nYou peek, and %@ looks like a %@", randomPlayer.name, randomPlayer.role.seerSeesAs]];
        [self.player.nightActions addObject:randomPlayer];
        self.game.gameHistory = [self.game.gameHistory stringByAppendingString:[NSString stringWithFormat:@"Night %d: The Seer peeked %@ and saw a %@\n", self.game.currentRound, randomPlayer.name, randomPlayer.role.seerSeesAs]];
    }
    
    return message;
}

- (NSString *)tapLabel
{
    return @"Seer, who do you want to peek?";
}

- (NSString *)verifyNightAction
{
    return @"Do you want to peek them?";
}

@end
