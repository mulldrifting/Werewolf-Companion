//
//  LLConstants.h
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int MAX_NUM_PEOPLE = 99;

typedef NS_ENUM(NSInteger, roleType)
{
    kVillager,
    kWerewolf,
    kSeer,
    kPriest,
    kVigilante,
    kHunter,
    kMinion,
    kNemesis
};


@interface LLConstants : NSObject

+ (NSArray *)listOfDefinedRoles;
+ (NSArray *)listOfRoleDescriptions;
+ (NSDictionary *)defaultSettings;

FOUNDATION_EXPORT NSString *const kDefaultTimerStartValue;
FOUNDATION_EXPORT NSString *const kDefaultGameSetupsInitialized;

@end
