//
//  Villager.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Villager.h"

@implementation Villager

-(id)initWithGame:(Game*)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Villager";
        self.roleID = kVillager;
    }
    
    return self;
}

@end
