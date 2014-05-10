//
//  Hunter.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Hunter.h"

@implementation Hunter

-(id)initWithGame:(Game*)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Hunter";
        self.roleID = kHunter;
    }
    
    return self;
}
@end
