//
//  LLTimerViewController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLTimerViewController.h"
#import "Game.h"

@interface LLTimerViewController ()

<TTCounterLabelDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *clearLabel;

@property (weak, nonatomic) IBOutlet UIButton *plusOneMinButton;
@property (weak, nonatomic) IBOutlet UIButton *minusOneMinButton;
@property (weak, nonatomic) IBOutlet UIButton *readyToKillButton;


@end

@implementation LLTimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapToStartPause = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleTimerStartPause)];
    tapToStartPause.numberOfTapsRequired = 1;
    
    [_clearLabel.layer setBorderColor:[UIColor blackColor].CGColor];
    [_clearLabel.layer setBorderWidth:1.0];
    _clearLabel.userInteractionEnabled = YES;
    [_clearLabel addGestureRecognizer:tapToStartPause];
    
    //    [_counterLabel setFrame:CGRectMake(_clearLabel.frame.origin.x, _clearLabel.frame.origin.y + 20, _counterLabel.frame.size.width, _counterLabel.frame.size.height)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupCounter];
    
    _titleLabel.text = [NSString stringWithFormat:@"Day %d", _game.currentRound];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

- (void)setupCounter
{
    _counterLabel.countDirection = kCountDirectionDown;
    [_counterLabel setStartValue:600000];
}

#pragma mark - Button Methods

- (void)toggleTimerStartPause
{
    if ([_counterLabel isRunning]) {
        [_counterLabel stop];
    }
    else {
        [_counterLabel start];
    }
}

- (IBAction)addMinute:(id)sender {
    unsigned long long newTime = _counterLabel.currentValue + 60000;
    [_counterLabel setStartValue:newTime];
}

- (IBAction)subtractMinute:(id)sender {
    unsigned long long newTime = _counterLabel.currentValue - 60000;
    if (newTime <= 0) {
        [_counterLabel setStartValue:0];
    }
    else {
        [_counterLabel setStartValue:newTime];
    }
}

- (IBAction)readyToKillPressed:(id)sender {
    [self.delegate beginKillSelection];
}


@end
