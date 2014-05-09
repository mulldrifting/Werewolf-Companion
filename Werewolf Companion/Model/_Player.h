// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Player.h instead.

#import <CoreData/CoreData.h>


extern const struct PlayerAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *townWinRate;
	__unsafe_unretained NSString *wolfWinRate;
} PlayerAttributes;

extern const struct PlayerRelationships {
} PlayerRelationships;

extern const struct PlayerFetchedProperties {
} PlayerFetchedProperties;






@interface PlayerID : NSManagedObjectID {}
@end

@interface _Player : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PlayerID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* townWinRate;



@property double townWinRateValue;
- (double)townWinRateValue;
- (void)setTownWinRateValue:(double)value_;

//- (BOOL)validateTownWinRate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* wolfWinRate;



@property double wolfWinRateValue;
- (double)wolfWinRateValue;
- (void)setWolfWinRateValue:(double)value_;

//- (BOOL)validateWolfWinRate:(id*)value_ error:(NSError**)error_;






@end

@interface _Player (CoreDataGeneratedAccessors)

@end

@interface _Player (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveTownWinRate;
- (void)setPrimitiveTownWinRate:(NSNumber*)value;

- (double)primitiveTownWinRateValue;
- (void)setPrimitiveTownWinRateValue:(double)value_;




- (NSNumber*)primitiveWolfWinRate;
- (void)setPrimitiveWolfWinRate:(NSNumber*)value;

- (double)primitiveWolfWinRateValue;
- (void)setPrimitiveWolfWinRateValue:(double)value_;




@end
