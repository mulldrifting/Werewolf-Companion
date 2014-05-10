//
//  NSManagedObject+DeepCopying.h
//  Werewolf Companion
//
//  https://gist.github.com/robrix/162745#file-nsmanagedobject-deepcopying-m
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (DeepCopying)

-(void)setRelationshipsToObjectsByIDs:(id)objects;

-(id)deepCopyWithZone:(NSZone *)zone;
-(NSDictionary *)ownedIDs;

@end
