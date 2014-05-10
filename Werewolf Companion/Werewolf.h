//
//  Werewolf.h
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Role.h"

@interface Werewolf : Role

-(id)initWithGame:(Game*)game;
-(NSString *)getNightZeroInfo;
-(NSString *)tapLabel;

@end
