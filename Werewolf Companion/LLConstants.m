//
//  LLConstants.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLConstants.h"

NSString *const kDefaultTimerStartValue = @"kDefaultTimerStartValue";
NSString *const kDefaultGameSetupsInitialized = @"kDefaultGameSetupsInitialized";

@implementation LLConstants

+ (NSArray *)listOfDefinedRoles
{
    static NSArray *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = @[
                 @"Villager",
                 @"Werewolf",
                 @"Seer",
                 @"Priest",
                 @"Vigilante",
                 @"Hunter",
                 @"Minion",
                 @"Nemesis"
                 ];
    });
    return inst;
}

+ (NSArray *)listOfRoleDescriptions
{
    static NSArray *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = @[
                 @"Villagers do not have any special abilities. Their goal is to find and kill the Werewolves.",
                 @"Werewolves know who's in their pack, and at night they get to secretly kill someone in the Village. They win if they equal or outnumber Villagers.",
                 @"The Seer is a Villager who can look at someone at night to reveal which side they're on. (Special roles not revealed.)",
                 @"The Priest is a Villager who can choose someone at night to save from potential death.",
                 @"The Vigilante is a Villager who can shoot someone at night once per game. Hopefully a Werewolf.",
                 @"The Hunter is a Villager who lets the Village win if they are the last Villager alive.",
                 @"The Minion is a Villager who wins if the Werewolves win but doesn't count as one. The Minion knows who the Werewolves are but not vice versa.",
                 @"The Nemesis starts with a random Villager target. Their goal is to convince the Village to kill that person in the Day."
                 ];
    });
    return inst;
}

+ (NSDictionary *)defaultSettings
{
    static NSDictionary *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = @{@"DAY_KILL_ANNOUNCED": @YES,
                 @"NIGHT_KILL_ANNOUNCED": @NO,
                 @"WOLVES_SEE_ROLE_OF_KILL": @YES,
                 @"PRIEST_CAN_TARGET_SELF": @YES,
                 @"PRIEST_CAN_TARGET_SAME_PERSON_TWICE_IN_A_ROW": @NO,
                 @"SEER_PEEKS_NIGHT_ZERO": @NO,
                 @"SEER_SEES_ROLE":@NO,
                 @"VIGILANTE_KILLS_AT_NIGHT": @NO,
                 @"VIGILANTE_KILLS_ONCE_PER_GAME": @YES
                 
                 };
    });
    return inst;
}


@end
