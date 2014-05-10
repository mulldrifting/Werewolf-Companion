//
//  LLGameViewController.h
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, alertViewType) {
    kNameEntry,
    kReadyToSeeRole,
    kKillPlayer,
    kShowRoleAlert,
    kNoKillConfirmation,
    kAreYouX,
    kIsDead,
    kNightAction,
    kSeerPeek,
    kNightActionConfirm,
    kNightResult
};

@class Game;

@interface LLGameViewController : UIViewController

@property (strong, nonatomic) Game *game;

@end
