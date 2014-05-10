//
//  GameSetup.h
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//


#import "_GameSetup.h"

@interface GameSetup : _GameSetup {}


- (NSInteger)numPlayers;
- (BOOL)hasSameAttributesAs:(NSDictionary *)dictionary;

@end
