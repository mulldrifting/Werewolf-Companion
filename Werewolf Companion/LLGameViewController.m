//
//  LLGameViewController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLGameViewController.h"
#import "LLTimerViewController.h"
#import "LLEndGameViewController.h"
#import "LLCarouselController.h"
#import "UIAlertView+Blocks.h"
#import "iCarousel.h"
#import "LLAlphaView.h"
#import "Game.h"
#import "GameSetup.h"
#import "Player.h"
#import "Role.h"

typedef NS_ENUM(NSInteger, popupViewType) {
    kPassRight,
    kBeginDay,
    kPassToPlayer,
    kShowRoleView,
    kShowNightInfoView,
    kWolvesDecideKill
};

typedef NS_ENUM(NSInteger, cornerButtonType)
{
    kReadyToStart,
    kNoKillToday,
    kNoKillVigilante,
    kNoKillWerewolf
};

@interface LLGameViewController () <UIAlertViewDelegate, UITextFieldDelegate, TimerViewControllerProtocol, CarouselControllerProtocol>


@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) LLTimerViewController *timerViewController;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *whereToTapLabel;
@property (weak, nonatomic) IBOutlet UIButton *cornerButton;

@property (strong, nonatomic) LLEndGameViewController *endGameViewController;
//@property (strong, nonatomic) LLNightActionController *nightActionController;
@property (strong, nonatomic) LLCarouselController *carouselController;

@property (strong, nonatomic) UIAlertView *alertView;
@property (strong, nonatomic) LLAlphaView *alphaView;
@property (strong, nonatomic) UIView *boxView;

@property (nonatomic) BOOL firstAppearance;

@end

@implementation LLGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Game View did Load");
    
    [self setupGameControllers];
    [self setupBoxView];
    [self turnLight];
    [self setupCarousel];
    [self setupCornerButton];
    [self.view sendSubviewToBack:_boxView];
    
    [self updateTapLabelWithString:@"Hello there!\nSelect a player to update their name. (Player 1 is to your right.)"];
    
    //    [self createAlphaView];
    //    [self showPregameExplanationView];
    
    _alphaView = [[LLAlphaView alloc] initWithFrame:self.view.frame];
    _firstAppearance = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_firstAppearance) {
        //        [self beginNameEntry];
        //        [_carousel scrollByNumberOfItems:_game.numPlayers duration:1];
        _firstAppearance = NO;
    }
}

- (void)setupGameControllers
{
    _timerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"timer"];
    _timerViewController.game = _game;
    _timerViewController.delegate = self;

//    _nightActionController = [NightActionController new];
//    _nightActionController.game = _game;
//    _nightActionController.delegate = self;

    _carouselController = [LLCarouselController new];
    _carouselController.game = _game;
    _carouselController.delegate = self;
}

#pragma mark - Timer View Controller Methods

- (void)showTimerViewController
{
    [_alphaView maxAlpha];
    [self showAlphaView];
    [_timerViewController.view setAlpha:0.0];
    
    [self addChildViewController:_timerViewController];
    [self.view addSubview:_timerViewController.view];
    [_timerViewController didMoveToParentViewController:self];
    
    [UIView animateWithDuration:2 animations:^{
        [_timerViewController.view setAlpha:1.0];
    } completion:^(BOOL finished) {
        [self dismissAlphaView];
    }];
    
}

- (void)hideTimerViewController
{
    [_timerViewController.view removeFromSuperview];
    [_timerViewController removeFromParentViewController];
}

#pragma mark - End Game View Controller

- (void)showEndGameViewController
{
    [_alphaView maxAlpha];
    [self showAlphaView];
    [_endGameViewController.view setAlpha:0.0];
    
    [self addChildViewController:_endGameViewController];
    [self.view addSubview:_endGameViewController.view];
    [_endGameViewController didMoveToParentViewController:self];
    
    [UIView animateWithDuration:2 animations:^{
        [_endGameViewController.view setAlpha:1.0];
    } completion:^(BOOL finished) {
        [self dismissAlphaView];
    }];
}

#pragma mark - Changing Skin Methods

- (void)turnDark
{
    //change view to dark skin
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.098 alpha:1.000]];
    [_boxView.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_carousel reloadData];
}

- (void)turnLight
{
    //change view to light skin
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [_boxView.layer setBorderColor:[UIColor blackColor].CGColor];
    
    [_carousel reloadData];
}

#pragma mark - iCarousel Methods

-(void)setupCarousel
{
    _carousel.delegate = _carouselController;
    _carousel.dataSource = _carouselController;
    _carousel.type = iCarouselTypeInvertedWheel;
    _carousel.viewpointOffset = CGSizeMake(50, 0);
    _carousel.vertical = YES;
}


- (void)resetCarousel
{
    _game.currentPlayer = [_game nextAlivePlayer:-1];
    [_carousel scrollToItemAtIndex:_game.currentPlayer.index animated:YES];
    _game.didWrap = NO;
}

#pragma mark - Tap Label Methods

-(void)updateTapLabelWithString:(NSString *)string
{
    [_whereToTapLabel setText:string];
}

-(void)resetTapLabel
{
    [_whereToTapLabel setText:@""];
}

#pragma mark - Button Methods

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupCornerButton
{
    [_cornerButton setTitle:@"Ready To Start" forState:UIControlStateNormal];
    [_cornerButton addTarget:self action:@selector(beginNight) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hideCornerButton
{
    [_cornerButton setHidden:YES];
    [_cornerButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
}

- (void)showNoKillCornerButton
{
    [_cornerButton setTitle:@"No Kill" forState:UIControlStateNormal];
    [_cornerButton addTarget:self action:@selector(noKillPressed) forControlEvents:UIControlEventTouchUpInside];
    [_cornerButton setHidden:NO];
    
}

- (void)noKillPressed
{
    if (!_game.isNight) {
        [self createAlertViewOfType:kNoKillConfirmation];
    }
    else {
        [self showViewOfType:kPassRight];
    }
    
}

- (void)showCornerButtonForCurrentPlayer
{
    switch (_game.currentPlayer.role.roleID) {
        case kWerewolf:
        case kVigilante:
            [self showNoKillCornerButton];
            break;
            
        default:
            break;
    }
}

#pragma mark - Game Mode Methods

- (void)moveToNextNightAction
{
    [self dismissAlphaView];
    
    if (_game.currentRound == 0) { // Night 0
        if (_game.didWrap) {
            [self showViewOfType:kBeginDay];
        }
        else {
            [self createAlertViewOfType:kReadyToSeeRole];
        }
    }
    else { // Night 1+
        if (_game.didWrap) {
            [self createAlertViewOfType:kNightResult];
        }
        else {
            [self createAlertViewOfType:kAreYouX];
        }
    }
}

// Passing the phone to the next player at night
- (void)moveToNextPlayer
{
    _game.currentPlayer = [_game nextAlivePlayer:_game.currentPlayer.index];
    [_carousel scrollToItemAtIndex:_game.currentPlayer.index animated:YES];
    if (_game.currentRound > 0) {
        [self resetTapLabel];
        [self hideCornerButton];
    }
}

- (void)scrollToNextPlayer
{
    int nextIndex = [[_game nextAlivePlayer:_carousel.currentItemIndex] index];
    [_carousel scrollToItemAtIndex:nextIndex animated:YES];
}

- (void)passedToPlayer
{
    [self dismissAlphaView];
    if (_game.currentRound == 0) {
        [self createAlertViewOfType:kReadyToSeeRole];
    }
    else {
        [self createAlertViewOfType:kAreYouX];
    }
    
}

// Pop open Timer View
- (void)beginDay
{
    [self dismissAlphaView];
    
    _game.currentRound++;
    _game.isNight = NO;
    
    
    [self showTimerViewController];
    
}

// Let players select person to kill
- (void)beginKillSelection
{
    [self turnLight];
    [_titleLabel setText:@"Who To Kill?"];
    [self showNoKillCornerButton];
    [self resetCarousel];
    
    [self hideTimerViewController];
    
    //    [self showKillExplanationView];
    
}

- (void)beginNight
{
    [UIView animateWithDuration:2 animations:^{
        
        [self hideCornerButton];
        
        _titleLabel.text = [NSString stringWithFormat:@"Night %d", _game.currentRound];
        _game.isNight = YES;
        [self resetTapLabel];
        [self resetCarousel];
        [self turnDark];
        
    } completion:^(BOOL finished) {
        
        if (_game.currentRound == 0) {
            [self createAlertViewOfType:kReadyToSeeRole];
        }
        else
        {
            int numWolves = [[self.game.gameSetup valueForKey:@"numWerewolf"] intValue];
            if (numWolves > 1) {
                [self showViewOfType:kWolvesDecideKill];
            }
            else {
                [self createAlertViewOfType:kAreYouX];
            }
        }
    }];
}

- (void)wolvesDecidedKill
{
    [self dismissAlphaView];
    [self createAlertViewOfType:kAreYouX];
}

#pragma mark - Subview Methods

- (void)setupBoxView
{
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(20, 233, 160, 40)];
    [_boxView.layer setBorderWidth:1];
    [_boxView.layer setCornerRadius:5];
    _boxView.layer.masksToBounds = YES;
    [self.view addSubview:_boxView];
}

- (void)showAlphaView
{
    [self.view addSubview:_alphaView];
}

-(void)dismissAlphaView
{
    [_alphaView removeFromSuperview];
    [_alphaView reset];
}

- (void)showViewOfType:(NSInteger)type
{
    [self dismissAlphaView];
    UITapGestureRecognizer *tapToDismiss;
    
    switch (type) {
            
        case kPassRight:
            
            [_alphaView addBigText:@"PASS\nRIGHT"];
            tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(moveToNextNightAction)];
            
            [_alphaView addGestureRecognizer:tapToDismiss];
            
            [self moveToNextPlayer];
            break;
            
        case kBeginDay:
            
            [_alphaView addBigText:[NSString stringWithFormat:@"BEGIN\nDAY %d",_game.currentRound+1]];
            tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginDay)];
            [_alphaView addGestureRecognizer:tapToDismiss];
            break;
            
        case kPassToPlayer:
            
            [_alphaView addBigText:@"PASS\nTO"];
            [_alphaView addBoxView];
            tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(passedToPlayer)];
            [_alphaView addGestureRecognizer:tapToDismiss];
            break;
            
        case kWolvesDecideKill:
            
            [_alphaView addExplanationViewWithMessage:@"Moderator, please memorize and then do the following:\n\n1) Say \"Village, go to sleep.\"\n\n2) Close your eyes.\n\n3) Say \"Wolves wake up. Pick who to kill.\"\n\n4) Wait ten seconds.\n\n5) Say \"Wolves go to sleep.\"\n\n6) Say \"Everyone wake up.\"\n\n7) Then starting with you, use the phone to perform night actions."];
            tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wolvesDecidedKill)];
            [_alphaView addGestureRecognizer:tapToDismiss];
            
        default:
            break;
    }
    
    [self showAlphaView];
}


#pragma mark - Alert View Methods

-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    if (alertView.tag == kNameEntry) {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        
        if ([textfield.text length] > 0) {
            if ([_game isDuplicateName:textfield.text]) {
                [alertView setMessage:@"Same or duplicate name! Please change to something different."];
                return NO;
            }
            else {
                [alertView setMessage:@""];
                return YES;
            }
        }
        return NO; // if textfield is blank
    }
    
    return YES; // if alertview is not kNameEntry type
}

- (void)createAlertViewOfType:(NSInteger)type
{
    UIAlertView *alertView;
    Player *selectedPlayer = _game.players[_carousel.currentItemIndex];
    __weak typeof(self) weakSelf = self;
    
    
    switch (type) {
            
            // Player name entry
            
        {case kNameEntry:
            
            _alertView = [[UIAlertView alloc] initWithTitle:@"Enter Name Of Player"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Submit", nil];
            
            
            _alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [[_alertView textFieldAtIndex:0] setDelegate:self];
            [[_alertView textFieldAtIndex:0] setText:[selectedPlayer name]];
            [[_alertView textFieldAtIndex:0] setClearButtonMode:UITextFieldViewModeWhileEditing];
            [[_alertView textFieldAtIndex:0] setAutocapitalizationType:UITextAutocapitalizationTypeWords];
            
            _alertView.tag = kNameEntry;
            
            _alertView.didDismissBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                
                if (buttonIndex == alertView.firstOtherButtonIndex) {

                    [selectedPlayer setName:[alertView textFieldAtIndex:0].text];
                    [weakSelf.carousel reloadData];
                    if (weakSelf.game.isNight) {
                        [weakSelf createAlertViewOfType:kReadyToSeeRole];
                    }
                    else{
                        [weakSelf scrollToNextPlayer];
                    }

                    
                } else if (buttonIndex == alertView.cancelButtonIndex) {

                }
            };
            
            [_alertView show];
            
            break;
        }
            
            // Asks Player if they're ready to see their role
            
        {case kReadyToSeeRole:
            
            [UIAlertView showWithTitle:[NSString stringWithFormat:@"Hello %@", _game.currentPlayer.name]
                               message:@"Ready to see your role?"
                     cancelButtonTitle:[NSString stringWithFormat:@"I'm not %@!", _game.currentPlayer.name]
                     otherButtonTitles:@[@"Yes, show me my role!", @"Yes, but let me fix my name"]
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  
                                  if (buttonIndex == 0) {
                                      [weakSelf showViewOfType:kPassToPlayer]; // Wrong person!
                                  }
                                  else if (buttonIndex == 1) {
                                      [weakSelf createAlertViewOfType:kShowRoleAlert]; // Yes! Show role
                                  }
                                  else if (buttonIndex == 2) {
                                      [weakSelf createAlertViewOfType:kNameEntry]; // Name incorrect! Change
                                  }
                                  
                              }];
            
            alertView.tag = kReadyToSeeRole;
            break;
        }
            
            // Shows player their role, then passes right
            
        {case kShowRoleAlert:
            
            alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Your Role: %@", [[[_game currentPlayer] role] name]]
                                                   message:[[_game.currentPlayer role] getNightZeroInfo]
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles: nil];
            alertView.tag = kShowRoleAlert;
            
            alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                [weakSelf showViewOfType:kPassRight];
            };
            
            [alertView show];
            
            break;
        }
            
            // Verifies Town's decision for a kill
            
        {case kKillPlayer:
            
            alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Kill %@?", selectedPlayer.name]
                                                   message:@""
                                                  delegate:self
                                         cancelButtonTitle:@"No"
                                         otherButtonTitles: @"Yes", nil];
            alertView.tag = kKillPlayer;
            
            alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                [weakSelf.game killPlayerAtIndex:selectedPlayer.index];
                [weakSelf.game checkGameState];
                if (weakSelf.game.isOver) {
                    weakSelf.endGameViewController = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"endGame"];
                    weakSelf.endGameViewController.game = weakSelf.game;
                    [weakSelf showEndGameViewController];
                }
                else {
                    [weakSelf beginNight];
                    [weakSelf.carousel reloadData];

                }
            };
            
            [alertView show];
            
            break;
        }
            
            // Verifies Town's decision for a no kill
            
        {case kNoKillConfirmation:
            
            alertView = [[UIAlertView alloc] initWithTitle:@"Are You Sure?"
                                                   message:@"Not killing is usually inadvisable for the village"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"We're sure", nil];
            alertView.tag = kNoKillConfirmation;
            
            alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    weakSelf.game.townDidNotKill = YES;
                    [weakSelf.game checkGameState];
                    if (weakSelf.game.isOver) {
                        weakSelf.endGameViewController = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"endGame"];
                        weakSelf.endGameViewController.game = weakSelf.game;
                        [weakSelf showEndGameViewController];
                    }
                    else {
                        [weakSelf beginNight];
                    }

                }
            };
            
            [alertView show];
            
            break;
        }
            
            // Verifies correct player is holding the phone
            
        {case kAreYouX:
            
            alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Are You %@?", [_game.currentPlayer name]]
                                                   message:@""
                                                  delegate:self
                                         cancelButtonTitle:@"No"
                                         otherButtonTitles:@"Yes", nil];
            alertView.tag = kAreYouX;
            
            alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    [weakSelf updateTapLabelWithString:[weakSelf.game.currentPlayer.role tapLabel]];
                    [weakSelf showCornerButtonForCurrentPlayer];
                }
                else {
                    [weakSelf showViewOfType:kPassToPlayer];
                }
            };
            
            [alertView show];
            
            break;
        }
            
            // Completes player's night action
            
        {case kNightAction:
            
            alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You've Selected %@", [selectedPlayer name]]
                                                   message:[self.game.currentPlayer.role verifyNightAction]
                                                  delegate:self
                                         cancelButtonTitle:@"No"
                                         otherButtonTitles:@"Yes", nil];
            alertView.tag = kNightAction;
            
            alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                    
                    [weakSelf.game.currentPlayer.role performNightActionWithSelectedPlayer:selectedPlayer];
                    
                    if (weakSelf.game.currentPlayer.role.roleID == kSeer) {
                        
                            [weakSelf createAlertViewOfType:kSeerPeek];
                    }
                    else {
                            [weakSelf showViewOfType:kPassRight];
                    }
                }
            };
            
            [alertView show];
            
            break;
        }
            
        {case kSeerPeek:
            
            alertView = [[UIAlertView alloc] initWithTitle:@"You Take A Peek"
                                                   message:[NSString stringWithFormat:@"%@ looks like a %@", selectedPlayer.name, selectedPlayer.role.seerSeesAs]
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
            alertView.tag = kSeerPeek;
            
            alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                [weakSelf showViewOfType:kPassRight];
            };
            
            [alertView show];
            
            break;
        }
            
        {case kNightResult:
            
            alertView = [[UIAlertView alloc] initWithTitle:@"You wake and find..."
                                                   message:[_game checkNightResult]
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
            alertView.tag = kNightResult;
            
            alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (weakSelf.game.isOver) {
                    weakSelf.endGameViewController = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"endGame"];
                    weakSelf.endGameViewController.game = _game;
                    [weakSelf showEndGameViewController];
                    
                }
                else {
                    [weakSelf beginDay];
                }

            };
            
            [alertView show];
            
            break;
        }
            
        default:
            NSLog(@"unknown alert type: %ld", (long)type);
            break;
    }
}




@end
