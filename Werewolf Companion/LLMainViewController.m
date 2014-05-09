//
//  LLMainViewController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLMainViewController.h"
#import "LLTitleViewController.h"

@interface LLMainViewController ()

@end

@implementation LLMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSettingsGesture];
    
    LLTitleViewController *titleViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"title"];
    //    [self presentViewController:titleViewController animated:NO completion:nil];
    UINavigationController *titleNav = [[UINavigationController alloc] initWithRootViewController:titleViewController];
    
    [self addChildViewController:titleNav];
    [self.view addSubview:titleNav.view];
    [titleNav didMoveToParentViewController:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)setupSettingsGesture
{
    UILongPressGestureRecognizer *openSettingsGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showSettingsView)];
    
    [openSettingsGesture setMinimumPressDuration:.8];
    [openSettingsGesture setNumberOfTouchesRequired:3];
    
    [self.view addGestureRecognizer:openSettingsGesture];
}

- (void)showSettingsView
{
    
    // This isn't working with a dismiss view controller completion - find out why
    NSLog(@"start show settings");
    
    
    UIViewController *settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
    [settingsViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:settingsViewController animated:YES completion:nil];
    
    
    
    
}

- (IBAction)closeSettingsView:(id)sender
{
    // set the new values in NSUserDefaults
    
    [self dismissViewControllerAnimated:YES completion:^{
        // post an NSNotifcation for "SettingsChanged"
    }];
}

@end
