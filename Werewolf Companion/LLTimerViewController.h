//
//  LLTimerViewController.h
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCounterLabel.h"

@class Game;

@protocol TimerViewControllerProtocol <NSObject>

- (void)hideTimerViewController;
- (void)beginKillSelection;

@end

@interface LLTimerViewController : UIViewController

@property (weak, nonatomic) IBOutlet TTCounterLabel *counterLabel;

@property (unsafe_unretained, nonatomic) id<TimerViewControllerProtocol> delegate;
@property (weak, nonatomic) Game *game;

@end
