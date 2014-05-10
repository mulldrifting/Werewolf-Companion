//
//  AppDelegate+CoreDataContext.h
//  Werewolf
//
//  Created by Brad
//

#import "LLAppDelegate.h"

@interface LLAppDelegate (CoreDataContext)

- (void)createManagedObjectContext:(void (^)(NSManagedObjectContext *context))completion;

@end
