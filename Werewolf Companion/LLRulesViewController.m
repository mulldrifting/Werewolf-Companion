//
//  LLRulesViewController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLRulesViewController.h"

@interface LLRulesViewController ()

@end

@implementation LLRulesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add swipe to go back gesture
    UIScreenEdgePanGestureRecognizer *swipeToGoBack = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    swipeToGoBack.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:swipeToGoBack];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Show navigation bar on this screen
    [self.navigationController setNavigationBarHidden:NO];
    
    // Set style bar color to default = black
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
