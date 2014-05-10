//
//  LLCarouselController.h
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCarousel.h"

@class Game;

@protocol CarouselControllerProtocol <NSObject>

- (void)createAlertViewOfType:(NSInteger)type;

@end

@interface LLCarouselController : NSObject <iCarouselDataSource, iCarouselDelegate>

@property (unsafe_unretained, nonatomic) id<CarouselControllerProtocol> delegate;

@property (weak, nonatomic) Game *game;

@end
