//
//  LLSettingsViewController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLSettingsViewController.h"

@interface LLSettingsViewController ()

@end

@implementation LLSettingsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Hide navigation bar on this screen
    [self.navigationController setNavigationBarHidden:YES];
    
    // Set status bar color to default = black
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
