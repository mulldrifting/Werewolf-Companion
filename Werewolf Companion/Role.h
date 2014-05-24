//
//  Role.h
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "Player.h"
#import "GameSetup.h"

@interface Role : NSObject

@property (weak, nonatomic) Game *game;
@property (weak, nonatomic) Player *player;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *seerSeesAs;
@property (nonatomic) RoleType roleID;
@property (nonatomic) FactionType faction;
@property (nonatomic) BOOL oncePerGameUsed;


-(id)initWithGame:(Game*)game;
-(NSString *)getNightZeroInfo;
-(NSString *)tapLabel;
-(NSString *)verifyNightAction;
- (void)performNightActionWithSelectedPlayer:(Player *)player;

@end
