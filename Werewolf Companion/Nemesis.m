//
//  Nemesis.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Nemesis.h"

@implementation Nemesis

-(id)initWithGame:(Game *)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Nemesis";
        self.faction = @"Nemesis";
        self.roleID = kNemesis;
    }
    
    return self;
}

- (NSString *)getNightZeroInfo
{
    NSString *message = [super getNightZeroInfo];
    
    Player *player = [self.game randomVillager];
    player.isNemesisTarget = YES;
    self.player.target = player;
    
    message = [message stringByAppendingString:[NSString stringWithFormat:@"\n\nYour target is:\n%@", self.player.target.name]];
    
    return message;
}

- (NSString *)tapLabel
{
    return [NSString stringWithFormat:@"Nemesis, your target is %@. Guess who you think the Werewolf is!", self.player.target.name];
}

@end
