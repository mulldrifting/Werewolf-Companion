//
//  LLCarouselController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLCarouselController.h"
#import "LLGameViewController.h"
#import "Game.h"
#import "Player.h"

@implementation LLCarouselController

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if (carousel.currentItemIndex == index && ![_game.players[index] isDead])
    {
        if (_game.isNight) {
            
            if (_game.currentRound >= 1) {
                
                // Night 1: night-time action phase
                [_delegate createAlertViewOfType:kNightAction];
            }
            else
            {
                NSLog(@"Carousel item selected in night 0");
            }
            
        }
        else {
            
            if (_game.currentRound == 0) {
                
                // Day 0: pre-game, player entry phase
                [_delegate createAlertViewOfType:kNameEntry];
                
            }
            else {
                
                // Day 1+: vote to kill phase
                [_delegate createAlertViewOfType:kKillPlayer];
            }
        }
        
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_game.players count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 30.0f)];
        view.contentMode = UIViewContentModeCenter;
        //        view.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        view.backgroundColor = [UIColor clearColor];
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [label.font fontWithSize:20];
        label.tag = 1;
        label.adjustsFontSizeToFitWidth = YES;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    Player *currentPlayer = _game.players[index];
    
    if (currentPlayer.isDead) {
        label.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
    }
    else {
        if (_game.isNight) {
            label.textColor = [UIColor whiteColor];
        }
        else {
            label.textColor = [UIColor blackColor];
            
        }
    }
    
    label.text = [_game.players[index] name];
    
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 6;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80.0f, 30.0f)];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.font = [label.font fontWithSize:20];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = (index == 0)? @"[": @"]";
    
    return view;
}

-(CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 150;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 0.9;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionVisibleItems:
        {
            return 9;
        }
        default:
        {
            return value;
        }
    }
}


@end
