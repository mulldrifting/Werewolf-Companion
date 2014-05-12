//
//  GameSetup.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//


#import "GameSetup.h"


@interface GameSetup ()

// Private interface goes here.

@end


@implementation GameSetup


- (NSInteger)numPlayers
{
    NSInteger total = 0;
    NSDictionary *attributes = [[self entity] attributesByName];
    
    for (NSString *attribute in attributes) {
        if ([[attribute substringToIndex:3] isEqualToString:@"num"]) {
            id value = [self valueForKey:attribute];
            total += [value integerValue];
        }
    }
    
    return total;
}

- (BOOL)hasSameAttributesAs:(NSDictionary *)dictionary
{
    NSDictionary *attributes = [[self entity] attributesByName];

    for (NSString *attribute in attributes) {
        if ([self valueForKey:attribute] != [dictionary valueForKey:attribute]) {
            return NO;
        }
    }
    
    return YES;
}

@end
