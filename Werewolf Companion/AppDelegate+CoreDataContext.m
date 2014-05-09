//
//  AppDelegate+CoreDataContext.m
//  Werewolf
//
//  Created by Lauren Lee on 5/7/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "AppDelegate+CoreDataContext.h"

@implementation LLAppDelegate (CoreDataContext)

- (void)createManagedObjectContext:(void (^)(NSManagedObjectContext *))completion
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory
                                                         inDomains:NSUserDomainMask] lastObject];
    
    url = [url URLByAppendingPathComponent:@"LabelDocument"];
    
    self.managedDocument = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        
        [self.managedDocument saveToURL:url
                       forSaveOperation:UIDocumentSaveForCreating
                      completionHandler:^(BOOL success) {
                          
                          self.objectContext = [self.managedDocument managedObjectContext];
                          completion(self.objectContext);
                      }];
    }
    else if (self.managedDocument.documentState == UIDocumentStateClosed) {
        
        [self.managedDocument openWithCompletionHandler:^(BOOL success) {
            
            self.objectContext = [self.managedDocument managedObjectContext];
            completion(self.objectContext);
        }];
    }
    else {
        
        self.objectContext = [self.managedDocument managedObjectContext];
        completion(self.objectContext);
    }
}


@end
