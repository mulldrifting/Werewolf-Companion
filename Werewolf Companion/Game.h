//
//  Game.h
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameSetup;
@class Player;

@interface Game : NSObject

@property (strong, nonatomic) GameSetup *gameSetup;
@property (weak, nonatomic) Player *currentPlayer;

@property (strong, nonatomic) NSMutableArray *players;
@property (strong, nonatomic) NSMutableArray *roles;
@property (strong, nonatomic) NSMutableArray *wolves;
@property (strong, nonatomic) NSMutableArray *wolfTargets;
@property (strong, nonatomic) NSMutableArray *gameHistory;

@property (nonatomic) NSInteger numPlayers;
@property (nonatomic) NSInteger currentRound;
@property (nonatomic) BOOL isNight;
@property (nonatomic) BOOL isOver;
@property (nonatomic) BOOL didWrap;

- (id)initWithGameSetup:(GameSetup *)gameSetup;

- (BOOL)isDuplicateName:(NSString*)name;
- (int)nextAlivePlayer:(int)index;
- (Player*)currentPlayer;
- (Player*)previousPlayer;
- (Player*)randomPlayer;
- (Player*)randomNonWerewolf;
- (Player*)randomVillager;

- (void)killPlayerAtIndex:(int)index;
- (void)checkGameState;
- (NSString *)checkNightResult;
- (NSString *)listOfWolves;
- (void)resetPlayersNightStatus;

@end
