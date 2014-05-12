//
//  Priest.h
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Role.h"

@interface Priest : Role

-(id)initWithGame:(Game*)game;
-(NSString *)tapLabel;
- (void)performNightActionWithSelectedPlayer:(Player *)player;

@end
