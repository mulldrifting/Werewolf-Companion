//
//  LLAlphaView.h
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLAlphaView : UIView

- (void)reset;
- (void)maxAlpha;
- (void)addBigText:(NSString *)bigText;
- (void)addBoxView;
- (void)addExplanationViewWithMessage:(NSString*)message;

@end
