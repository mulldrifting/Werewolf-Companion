//
//  LLEndGameViewController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLEndGameViewController.h"
#import "Game.h"

@interface LLEndGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *gameOverLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameSummaryLabel;



@end

@implementation LLEndGameViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.game.winningFaction == kWerewolfFaction) {
        self.gameOverLabel.text = @"Wolves Win!";
    }
    else if (self.game.winningFaction == kTownFaction) {
        self.gameOverLabel.text = @"Town Wins!";
    }
    else if (self.game.winningFaction == kNemesisFaction)
    {
        self.gameOverLabel.text = @"Nemesis Wins!";
    }
    
    self.gameSummaryLabel.numberOfLines = 0;
    [self.gameSummaryLabel sizeToFit];
    

    
    self.gameSummaryLabel.text = [self.game gameSummary];

    
}

- (IBAction)replayButtonPressed:(id)sender {
    
    
}



@end
