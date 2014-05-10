//
//  LLAlphaView.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLAlphaView.h"

@implementation LLAlphaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    }
    return self;
}

- (void)reset
{
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    
    for (UIGestureRecognizer *gestureRecognizer in self.gestureRecognizers) {
        [self removeGestureRecognizer:gestureRecognizer];
    }
    
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (void)maxAlpha
{
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:1.0]];
}

- (void)addBigText:(NSString *)bigText
{
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
    firstLabel.text = bigText;
    firstLabel.textColor = [UIColor whiteColor];
    [firstLabel setFont:[UIFont boldSystemFontOfSize:90]];
    [firstLabel setLineBreakMode:NSLineBreakByWordWrapping];
    firstLabel.numberOfLines = 0;
    [firstLabel sizeToFit];
    
    UILabel *arrowLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 280, 300, 90)];
    arrowLabel.text = @">>>";
    arrowLabel.textColor = [UIColor whiteColor];
    [arrowLabel setFont:[UIFont systemFontOfSize:90]];
    
    [self addSubview:firstLabel];
    [self addSubview:arrowLabel];
}

- (void)addBoxView
{
    UIView *boxView = [[UIView alloc] initWithFrame:CGRectMake(20, 235, 160, 40)];
    [boxView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.1]];
    [boxView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [boxView.layer setBorderWidth:1];
    
    [self addSubview:boxView];
}

- (void)addExplanationViewWithMessage:(NSString*)message
{
    UIView *explanationView = [[UIView alloc] initWithFrame:CGRectMake(35, 100, 250, 350)];
    [explanationView setBackgroundColor:[UIColor whiteColor]];
    [explanationView setAlpha:1];
    explanationView.layer.cornerRadius = 5;
    explanationView.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 230, 300)];
    label.text = message;
    label.font = [label.font fontWithSize:15];
    label.numberOfLines = 0;
    [label sizeToFit];
    [explanationView addSubview:label];
    
    //    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(180, 210, 50, 30)];
    //    [button setTitle:@"OK" forState:UIControlStateNormal];
    //    [button setTitleColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    //    [button setTitleColor:[UIColor colorWithWhite:0.600 alpha:1.000] forState:UIControlStateHighlighted];
    //    [button addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    //    [explanationView addSubview:button];
    
    [self addSubview:explanationView];
}

@end
