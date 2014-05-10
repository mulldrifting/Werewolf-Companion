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
        self.faction = @"Werewolf";
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

@end
