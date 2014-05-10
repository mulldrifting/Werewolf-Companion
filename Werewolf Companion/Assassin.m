//
//  Assassin.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Assassin.h"

@implementation Assassin

-(id)initWithGame:(Game *)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Assassin";
        self.faction = @"Assassin";
        self.roleID = kAssassin;
    }
    
    return self;
}

- (NSString *)getNightZeroInfo
{
    NSString *message = [super getNightZeroInfo];
    
    self.player.target = [[self.game randomVillager] name];
    message = [message stringByAppendingString:[NSString stringWithFormat:@"\n\nYour target is:\n%@", self.player.target]];
    
    return message;
}

- (NSString *)tapLabel
{
    return [NSString stringWithFormat:@"Assassin, your target is %@. Guess who you think the Werewolf is!", self.player.target];
}

@end
