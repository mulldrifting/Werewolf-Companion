// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Player.m instead.

#import "_Player.h"

const struct PlayerAttributes PlayerAttributes = {
	.name = @"name",
	.townWinRate = @"townWinRate",
	.wolfWinRate = @"wolfWinRate",
};

const struct PlayerRelationships PlayerRelationships = {
};

const struct PlayerFetchedProperties PlayerFetchedProperties = {
};

@implementation PlayerID
@end

@implementation _Player

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Player";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Player" inManagedObjectContext:moc_];
}

- (PlayerID*)objectID {
	return (PlayerID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"townWinRateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"townWinRate"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"wolfWinRateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"wolfWinRate"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic name;






@dynamic townWinRate;



- (double)townWinRateValue {
	NSNumber *result = [self townWinRate];
	return [result doubleValue];
}

- (void)setTownWinRateValue:(double)value_ {
	[self setTownWinRate:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveTownWinRateValue {
	NSNumber *result = [self primitiveTownWinRate];
	return [result doubleValue];
}

- (void)setPrimitiveTownWinRateValue:(double)value_ {
	[self setPrimitiveTownWinRate:[NSNumber numberWithDouble:value_]];
}





@dynamic wolfWinRate;



- (double)wolfWinRateValue {
	NSNumber *result = [self wolfWinRate];
	return [result doubleValue];
}

- (void)setWolfWinRateValue:(double)value_ {
	[self setWolfWinRate:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveWolfWinRateValue {
	NSNumber *result = [self primitiveWolfWinRate];
	return [result doubleValue];
}

- (void)setPrimitiveWolfWinRateValue:(double)value_ {
	[self setPrimitiveWolfWinRate:[NSNumber numberWithDouble:value_]];
}










@end
