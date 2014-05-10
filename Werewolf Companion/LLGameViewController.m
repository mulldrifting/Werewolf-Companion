//
//  LLGameViewController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLGameViewController.h"
#import "LLTimerViewController.h"
#import "LLCarouselController.h"
#import "UIAlertView+Blocks.h"
#import "iCarousel.h"
#import "LLAlphaView.h"
#import "Game.h"
#import "Player.h"

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

//@property (strong, nonatomic) LLEndGameViewController *endGameViewController;
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
    _game.currentPlayer.index = [_game nextAlivePlayer:-1];
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

//- (void)noKillPressed
//{
//    if (!_game.isNight) {
//        [self createAlertViewOfType:kNoKillConfirmation];
//    }
//    else {
//        [self showViewOfType:kPassRight];
//        [self moveToNextPlayer];
//    }
//    
//}

//- (void)showCornerButtonForCurrentPlayer
//{
//    switch (_game.currentPlayer.role.roleID) {
//        case kWerewolf:
//        case kVigilante:
//            [self showNoKillCornerButton];
//            break;
//            
//        default:
//            break;
//    }
//}

#pragma mark - Game Mode Methods

- (void)showRoleToNextPlayer
{
    [self dismissAlphaView];
    if (_game.didWrap) {
        [self showViewOfType:kBeginDay];
    }
    else {
        [self createAlertViewOfType:kReadyToSeeRole];
    }
}

- (void)moveToNextNightAction
{
    [self dismissAlphaView];
    if (_game.didWrap) {
        [self createAlertViewOfType:kNightResult];
    }
    else {
        [self createAlertViewOfType:kAreYouX];
    }
}

// Passing the phone to the next player at night
- (void)moveToNextPlayer
{
    _game.currentPlayer.index = [_game nextAlivePlayer:_game.currentPlayer.index];
    [_carousel scrollToItemAtIndex:_game.currentPlayer.index animated:YES];
    if (_game.currentRound > 0) {
        [self resetTapLabel];
        [self hideCornerButton];
    }
}

- (void)scrollToNextPlayer
{
    int nextIndex = [_game nextAlivePlayer:_carousel.currentItemIndex];
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
            int numWolves = [[_game.gameSetup.roleNumbers objectForKey:@"Werewolf"] intValue];
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



- (void)createAlertViewOfType:(NSInteger)type
{
    UIAlertView *alertView;
    Player *selectedPlayer = _game.players[_carousel.currentItemIndex];
    __weak typeof(self) weakSelf = self;
    
    
    switch (type) {
            
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
            
            _alertView.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex) {
                
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
            break;
        }
            
        {case kReadyToSeeRole:
            
            
            alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hello %@", _game.currentPlayer.name]
                                                   message:@"Ready to see your role?"
                                                  delegate:self
                                         cancelButtonTitle:[NSString stringWithFormat:@"I'm not %@!", _game.currentPlayer.name]
                                         otherButtonTitles: @"Yes, show me my role!", @"Yes, but let me fix my name", nil];
            alertView.tag = kReadyToSeeRole;
            break;
        }
            
        case kKillPlayer:
            
            alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Kill %@?", selectedPlayer.name]
                                                   message:@""
                                                  delegate:self
                                         cancelButtonTitle:@"No"
                                         otherButtonTitles: @"Yes", nil];
            alertView.tag = kKillPlayer;
            break;
            
        case kShowRoleAlert:
            
            alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Your Role: %@", [_game.currentPlayer.role name]]
                                                   message:[[_game.currentPlayer role] getNightZeroInfo]
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles: nil];
            alertView.tag = kShowRoleAlert;
            break;
            
        case kNoKillConfirmation:
            
            alertView = [[UIAlertView alloc] initWithTitle:@"Are You Sure?"
                                                   message:@"Not killing is usually inadvisable for the village"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"We're sure", nil];
            alertView.tag = kNoKillConfirmation;
            break;
            
        case kAreYouX:
            
            alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Are You %@?", [_game.currentPlayer name]]
                                                   message:@""
                                                  delegate:self
                                         cancelButtonTitle:@"No"
                                         otherButtonTitles:@"Yes", nil];
            alertView.tag = kAreYouX;
            break;
            
        case kNightAction:
            
            alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You've Selected %@", [selectedPlayer name]]
                                                   message:@"Final answer?"
                                                  delegate:self
                                         cancelButtonTitle:@"No"
                                         otherButtonTitles:@"Yes", nil];
            alertView.tag = kNightAction;
            break;
            
        case kSeerPeek:
            
            alertView = [[UIAlertView alloc] initWithTitle:@"You Take A Peek"
                                                   message:[NSString stringWithFormat:@"%@ looks like a %@", selectedPlayer.name, currentSelectedPlayer.role.seerSeesAs]
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
            alertView.tag = kSeerPeek;
            break;
            
        case kNightActionConfirm:
            
            alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You've Chosen %@", selectedPlayer.name]
                                                   message:[_nightActionController getNightActionConfirmMessageForPlayer:selectedPlayer]
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
            alertView.tag = kNightActionConfirm;
            
            break;
            
        case kNightResult:
            
            alertView = [[UIAlertView alloc] initWithTitle:@"You wake and find..."
                                                   message:[_game checkNightResult]
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
            alertView.tag = kNightResult;
            
            break;
            
        default:
            NSLog(@"unknown alert type: %ld", (long)type);
            break;
    }
    
    
    [alertView show];
}




@end
