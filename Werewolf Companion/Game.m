//
//  Game.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Game.h"
#import "GameSetup.h"
#import "Player.h"
#import "Role.h"
#import "Werewolf.h"
#import "Villager.h"
#import "Priest.h"
#import "Seer.h"
#import "Vigilante.h"
#import "Hunter.h"
#import "Minion.h"
#import "Nemesis.h"

@interface Game ()

@property (strong, nonatomic) NSMutableArray *roles;
@property (nonatomic) BOOL hasHunter, hasNemesis;

@end

@implementation Game

- (id)initWithGameSetup:(GameSetup*)gameSetup
{
    if (self = [super init])
    {
        _gameSetup = gameSetup;
        _numPlayers = [gameSetup numPlayers];
    
        _players = [NSMutableArray new];
        _wolves = [NSMutableArray new];
        _wolfTargets = [NSMutableArray new];
        
        _gameHistory =  @"";
        _winningFaction = -1;
        
        _isNight = NO;
        _townDidNotKill = NO;
        _didWrap = NO;
        
        _currentRound = 0;
        
        [self prepareGame];
    }
    
    return self;
}

- (id)initWithGameSetup:(GameSetup *)gameSetup players:(NSMutableArray *)players
{
    if (self = [super init])
    {
        _gameSetup = gameSetup;
        _numPlayers = [gameSetup numPlayers];
        
        _players = players;
        _wolves = [NSMutableArray new];
        _wolfTargets = [NSMutableArray new];
        
        _gameHistory =  @"";
        _winningFaction = -1;
        
        _isNight = NO;
        _townDidNotKill = NO;
        _didWrap = NO;
        
        _currentRound = 0;
        
        [self prepareGame];
    }
    
    return self;

}

-(BOOL)isDuplicateName:(NSString *)name
{
    for (Player *player in _players) {
        if ([player.name isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Game Logic Methods

- (int)numberAlive:(NSInteger)roleID
{
    int total = 0;
    for (Player *player in _players) {
        if (!player.isDead && player.role.roleID == roleID) {
            total++;
        }
    }
    return total;
}

- (NSString *)checkNightResult
{
    NSString *dayMessage = @"";
    BOOL nobodyDied = YES;
    BOOL firstString = YES;
    
    if (_wolfTargets.count > 0) {
        Player* targetPlayer = _wolfTargets[arc4random_uniform((u_int32_t)[_wolfTargets count])];
        targetPlayer.isWolfTarget = YES;
        self.gameHistory = [self.gameHistory stringByAppendingString:[NSString stringWithFormat:@"Night %d: The Wolves targeted %@\n", self.currentRound, targetPlayer.name]];
        [_wolfTargets removeAllObjects];
    }
    
    for (Player *player in _players) {
        if (player.isWolfTarget || player.isVigilanteTarget) {
            
            if (!player.isPriestTarget) {
                [self killPlayerAtIndex:player.index];
                
                if (!firstString) {
                    dayMessage = [dayMessage stringByAppendingString:@"\n"];
                }
                
                dayMessage = [dayMessage stringByAppendingString:[NSString stringWithFormat:@"%@ was killed in the night!", player.name]];
                self.gameHistory = [self.gameHistory stringByAppendingString:[NSString stringWithFormat:@"Night %d: %@ died!\n", self.currentRound, player.name]];
                firstString = NO;
                nobodyDied = NO;
            }
        }
    }
    
    if (nobodyDied) {
        dayMessage = [dayMessage stringByAppendingString:@"Nobody died last night!"];
        self.gameHistory = [self.gameHistory stringByAppendingString:[NSString stringWithFormat:@"Night %d: Nobody Died!\n", self.currentRound]];
    }
    
    [self resetPlayersNightStatus];
    
    return dayMessage;
}

- (BOOL)isOver
{
    int numWolf = [self numberAlive:kWerewolf];
    int numVillage = 0;
    NSMutableArray *aliveVillagers = [NSMutableArray new];
    
    for (Player *player in _players) {
        if (!player.isDead) {
            if ([player.role.seerSeesAs isEqualToString:@"Human"]) {
                [aliveVillagers addObject:player];
                numVillage++;
            }
        }
    }
    
    
    
    if (numWolf == 0) {
        _winningFaction = kTownFaction;
        return YES;
    }
    
    if (numWolf == 1 && numVillage == 1)
    {
        if ([aliveVillagers[0] roleID] == kHunter) {
            _winningFaction = kTownFaction;
        }
        else {
            _winningFaction = kWerewolfFaction;
        }
        return YES;
    }
    
    if (numWolf > numVillage) {
        _winningFaction = kWerewolfFaction;
        return YES;
    }
    
    if (numWolf == numVillage) {
        if (_hasNemesis && [self nemesisTargetAlive]) {
            return NO;
        }
        _winningFaction = kWerewolfFaction;
        return YES;
    }

    
    return NO;
}

- (NSString *)gameSummary
{
    NSString *gameSummary = @"";
    
    NSString *wolfSummary = [self listOfWolves];
    NSString *nemesisSummary = @"Nemesis: ";
    NSString *villageSummary = @"The Village: ";
    
    BOOL isFirstTownObject = YES;
    BOOL isFirstNemesisObject = YES;
    
    for (Player *player in _players) {
        if (player.role.faction == kTownFaction) {
            if (isFirstTownObject) {
                villageSummary = [villageSummary stringByAppendingString:[NSString stringWithFormat:@"%@", player.name]];
                isFirstTownObject = NO;
            }
            else {
                villageSummary = [villageSummary stringByAppendingString:[NSString stringWithFormat:@", %@", player.name]];
            }
        }
        if (player.role.faction == kNemesisFaction) {
            if (isFirstNemesisObject) {
                nemesisSummary = [nemesisSummary stringByAppendingString:[NSString stringWithFormat:@"%@", player.name]];
                isFirstNemesisObject = NO;
            }
            else {
                nemesisSummary = [nemesisSummary stringByAppendingString:[NSString stringWithFormat:@", %@", player.name]];
            }
        }
    }
    
    switch (self.winningFaction) {
        case kTownFaction:
            gameSummary = villageSummary;
            if (_wolves) {
                gameSummary = [gameSummary stringByAppendingString:[NSString stringWithFormat:@"\n%@",wolfSummary]];
            }
            if (!isFirstNemesisObject) {
                gameSummary = [gameSummary stringByAppendingString:[NSString stringWithFormat:@"\n%@",nemesisSummary]];
            }
            break;
        case kWerewolfFaction:
            gameSummary = wolfSummary;
            if (!isFirstTownObject) {
                gameSummary = [gameSummary stringByAppendingString:[NSString stringWithFormat:@"\n%@",villageSummary]];
            }
            if (!isFirstNemesisObject) {
                gameSummary = [gameSummary stringByAppendingString:[NSString stringWithFormat:@"\n%@",nemesisSummary]];
            }
            break;
        case kNemesisFaction:
            gameSummary = nemesisSummary;
            if (!isFirstTownObject) {
                gameSummary = [gameSummary stringByAppendingString:[NSString stringWithFormat:@"\n%@",villageSummary]];
            }
            if (_wolves) {
                gameSummary = [gameSummary stringByAppendingString:[NSString stringWithFormat:@"\n%@",wolfSummary]];
            }
            break;
            
        default:
            break;
    }
    
    gameSummary = [gameSummary stringByAppendingString:[NSString stringWithFormat:@"\n\n%@",self.gameHistory]];
    
    return gameSummary;
}

#pragma mark - Player Action Methods

- (void)resetPlayersNightStatus
{
    for (Player *player in _players) {
        player.isPriestTarget = NO;
        player.isWolfTarget = NO;
        player.isVigilanteTarget = NO;
    }
}



#pragma mark - Player Control Methods

- (int)prevPlayerIndex:(int)index
{
    int prevPlayerIndex = index - 1;
    if (prevPlayerIndex < 0) {
        prevPlayerIndex = _numPlayers-1;
    }
    return prevPlayerIndex;
}

- (int)nextPlayerIndex:(int)index
{
    int nextPlayerIndex = index + 1;
    if (nextPlayerIndex == _numPlayers) {
        _didWrap = YES;
        nextPlayerIndex = 0;
    }
    return nextPlayerIndex;
}

- (Player *)nextPlayerAtIndex:(int)index
{
    int nextPlayerIndex = index + 1;
    if (nextPlayerIndex == _numPlayers) {
        _didWrap = YES;
        nextPlayerIndex = 0;
    }
    
    return _players[nextPlayerIndex];
}

- (Player *)nextAlivePlayer:(int)index
{
    int i = index;
    
    Player *currentPlayer = [self nextPlayerAtIndex:i];
    
    if (_didWrap) {
        return 0;
    }
    
    while (currentPlayer.isDead) {
        i++;
        currentPlayer = [self nextPlayerAtIndex:i];
        if (_didWrap) {
            return 0;
        }
    }
    
    return currentPlayer;
    
}


-(Player *)randomPlayer
{
    return _players[arc4random_uniform((u_int32_t)[_players count])];
}

// Seer
-(Player *)randomNonWerewolf
{
    Player *randomPlayer = [self randomPlayer];
    while ([randomPlayer.role isKindOfClass:[Werewolf class]] || [randomPlayer isEqual:[self currentPlayer]]) {
        randomPlayer = [self randomPlayer];
    }
    return randomPlayer;
}

// Nemesis
- (Player*)randomVillager
{
    Player *randomPlayer = [self randomPlayer];
    while (!randomPlayer.role.roleID == kVillager || randomPlayer.isNemesisTarget == YES) {
        randomPlayer = [self randomPlayer];
    }
    return randomPlayer;
}

-(void)killPlayerAtIndex:(int)index
{
    Player *player = _players[index];
    
    if (player.isDead) {
        NSLog(@"Tried to kill dead player");
    }
    if (player.role.roleID == kNemesis) {
        player.target.isNemesisTarget = NO;
    }
    
    player.isDead = YES;
}

- (BOOL)nemesisTargetAlive
{
    BOOL nemesisTargetAlive = NO;
    for (Player *player in _players) {
        if (player.isNemesisTarget) {
            nemesisTargetAlive = YES;
        }
    }
    return nemesisTargetAlive;
}

#pragma mark - Setup Game Methods

- (void)prepareGame
{
    [self preparePlayers];
    [self prepareRoles];
    [self shuffleRoles];
    [self assignRoles];
}

- (void)prepareGameWithPlayers
{
    [self prepareRoles];
    [self shuffleRoles];
    [self assignRoles];
}

- (void)preparePlayers
{
    for (int i = 0; i < _numPlayers; i++) {
        
        Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.gameSetup.managedObjectContext];
        [player initializeNewPlayerWithGame:self atIndex:i];
        
        if (i == 0) {
            player.name = @"YOU";
        }
        
        [_players addObject:player];
    }
}

- (void)prepareRoles
{
    int keyIndex = 0;
    self.roles = [NSMutableArray new];
    _hasHunter = NO;
    _hasNemesis = NO;
    
    for (NSString *roleName in [LLConstants listOfDefinedRoles]) {
        
        int roleNum = [[_gameSetup valueForKey:[@"num" stringByAppendingString:roleName]] intValue];
        
        for (int i = 0; i < roleNum; i++) {
            [_roles addObject:[self roleForIndex:keyIndex]];
        }
        
        keyIndex++;
    }
}

-(id)roleForIndex:(int)roleType
{
    switch (roleType) {
        case kVillager:
            return [[Villager alloc] initWithGame:self];
        case kWerewolf:
            return [[Werewolf alloc] initWithGame:self];
        case kSeer:
            return [[Seer alloc] initWithGame:self];
        case kPriest:
            return [[Priest alloc] initWithGame:self];
        case kVigilante:
            return [[Vigilante alloc] initWithGame:self];
        case kHunter:
            self.hasHunter = YES;
            return [[Hunter alloc] initWithGame:self];
        case kMinion:
            return [[Minion alloc] initWithGame:self];
        case kNemesis:
            self.hasNemesis = YES;
            return [[Nemesis alloc] initWithGame:self];
        default:
            NSLog(@"Unknown role type");
            return [Role new];
    }
}

- (void)assignRoles
{
    int index = 0;
    for (Player *player in _players) {
        player.role = _roles[index];
        player.role.player = player;
        
        if (player.role.roleID == kWerewolf) {
            [_wolves addObject:player];
        }
        
        NSLog(@"%@: %@",player.name,[_roles[index] name]);
        index++;
    }
}

- (void)shuffleRoles
{
    NSUInteger count = [_roles count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = arc4random_uniform((u_int32_t)nElements) + i;
        [_roles exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (NSString *)listOfWolves
{
    BOOL isFirstObject = YES;
    
    NSString *list = @"The Wolves: ";
    for (Player *wolf in _wolves) {
        if (isFirstObject) {
            list = [list stringByAppendingString:[NSString stringWithFormat:@"%@", wolf.name]];
            isFirstObject = NO;
        }
        else {
            list = [list stringByAppendingString:[NSString stringWithFormat:@", %@", wolf.name]];
        }
    }
    return list;
}

@end
