//
//  AppDelegate+CoreDataContext.h
//  Werewolf
//
//  Created by Lauren Lee on 5/7/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLAppDelegate.h"

@interface LLAppDelegate (CoreDataContext)

- (void)createManagedObjectContext:(void (^)(NSManagedObjectContext *context))completion;

@end
