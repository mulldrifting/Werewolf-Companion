// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GameSetup.m instead.

#import "_GameSetup.h"

const struct GameSetupAttributes GameSetupAttributes = {
	.isDefault = @"isDefault",
	.name = @"name",
	.numHunter = @"numHunter",
	.numMinion = @"numMinion",
	.numNemesis = @"numNemesis",
	.numPriest = @"numPriest",
	.numSeer = @"numSeer",
	.numVigilante = @"numVigilante",
	.numVillager = @"numVillager",
	.numWerewolf = @"numWerewolf",
	.seerPeeksNightZero = @"seerPeeksNightZero",
};

const struct GameSetupRelationships GameSetupRelationships = {
};

const struct GameSetupFetchedProperties GameSetupFetchedProperties = {
};

@implementation GameSetupID
@end

@implementation _GameSetup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GameSetup";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GameSetup" inManagedObjectContext:moc_];
}

- (GameSetupID*)objectID {
	return (GameSetupID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isDefaultValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isDefault"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numHunterValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numHunter"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numMinionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numMinion"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numNemesisValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numNemesis"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numPriestValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numPriest"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numSeerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numSeer"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numVigilanteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numVigilante"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numVillagerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numVillager"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numWerewolfValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numWerewolf"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"seerPeeksNightZeroValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"seerPeeksNightZero"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic isDefault;



- (BOOL)isDefaultValue {
	NSNumber *result = [self isDefault];
	return [result boolValue];
}

- (void)setIsDefaultValue:(BOOL)value_ {
	[self setIsDefault:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsDefaultValue {
	NSNumber *result = [self primitiveIsDefault];
	return [result boolValue];
}

- (void)setPrimitiveIsDefaultValue:(BOOL)value_ {
	[self setPrimitiveIsDefault:[NSNumber numberWithBool:value_]];
}





@dynamic name;






@dynamic numHunter;



- (int16_t)numHunterValue {
	NSNumber *result = [self numHunter];
	return [result shortValue];
}

- (void)setNumHunterValue:(int16_t)value_ {
	[self setNumHunter:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumHunterValue {
	NSNumber *result = [self primitiveNumHunter];
	return [result shortValue];
}

- (void)setPrimitiveNumHunterValue:(int16_t)value_ {
	[self setPrimitiveNumHunter:[NSNumber numberWithShort:value_]];
}





@dynamic numMinion;



- (int16_t)numMinionValue {
	NSNumber *result = [self numMinion];
	return [result shortValue];
}

- (void)setNumMinionValue:(int16_t)value_ {
	[self setNumMinion:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumMinionValue {
	NSNumber *result = [self primitiveNumMinion];
	return [result shortValue];
}

- (void)setPrimitiveNumMinionValue:(int16_t)value_ {
	[self setPrimitiveNumMinion:[NSNumber numberWithShort:value_]];
}





@dynamic numNemesis;



- (int16_t)numNemesisValue {
	NSNumber *result = [self numNemesis];
	return [result shortValue];
}

- (void)setNumNemesisValue:(int16_t)value_ {
	[self setNumNemesis:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumNemesisValue {
	NSNumber *result = [self primitiveNumNemesis];
	return [result shortValue];
}

- (void)setPrimitiveNumNemesisValue:(int16_t)value_ {
	[self setPrimitiveNumNemesis:[NSNumber numberWithShort:value_]];
}





@dynamic numPriest;



- (int16_t)numPriestValue {
	NSNumber *result = [self numPriest];
	return [result shortValue];
}

- (void)setNumPriestValue:(int16_t)value_ {
	[self setNumPriest:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumPriestValue {
	NSNumber *result = [self primitiveNumPriest];
	return [result shortValue];
}

- (void)setPrimitiveNumPriestValue:(int16_t)value_ {
	[self setPrimitiveNumPriest:[NSNumber numberWithShort:value_]];
}





@dynamic numSeer;



- (int16_t)numSeerValue {
	NSNumber *result = [self numSeer];
	return [result shortValue];
}

- (void)setNumSeerValue:(int16_t)value_ {
	[self setNumSeer:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumSeerValue {
	NSNumber *result = [self primitiveNumSeer];
	return [result shortValue];
}

- (void)setPrimitiveNumSeerValue:(int16_t)value_ {
	[self setPrimitiveNumSeer:[NSNumber numberWithShort:value_]];
}





@dynamic numVigilante;



- (int16_t)numVigilanteValue {
	NSNumber *result = [self numVigilante];
	return [result shortValue];
}

- (void)setNumVigilanteValue:(int16_t)value_ {
	[self setNumVigilante:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumVigilanteValue {
	NSNumber *result = [self primitiveNumVigilante];
	return [result shortValue];
}

- (void)setPrimitiveNumVigilanteValue:(int16_t)value_ {
	[self setPrimitiveNumVigilante:[NSNumber numberWithShort:value_]];
}





@dynamic numVillager;



- (int16_t)numVillagerValue {
	NSNumber *result = [self numVillager];
	return [result shortValue];
}

- (void)setNumVillagerValue:(int16_t)value_ {
	[self setNumVillager:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumVillagerValue {
	NSNumber *result = [self primitiveNumVillager];
	return [result shortValue];
}

- (void)setPrimitiveNumVillagerValue:(int16_t)value_ {
	[self setPrimitiveNumVillager:[NSNumber numberWithShort:value_]];
}





@dynamic numWerewolf;



- (int16_t)numWerewolfValue {
	NSNumber *result = [self numWerewolf];
	return [result shortValue];
}

- (void)setNumWerewolfValue:(int16_t)value_ {
	[self setNumWerewolf:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumWerewolfValue {
	NSNumber *result = [self primitiveNumWerewolf];
	return [result shortValue];
}

- (void)setPrimitiveNumWerewolfValue:(int16_t)value_ {
	[self setPrimitiveNumWerewolf:[NSNumber numberWithShort:value_]];
}





@dynamic seerPeeksNightZero;



- (BOOL)seerPeeksNightZeroValue {
	NSNumber *result = [self seerPeeksNightZero];
	return [result boolValue];
}

- (void)setSeerPeeksNightZeroValue:(BOOL)value_ {
	[self setSeerPeeksNightZero:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveSeerPeeksNightZeroValue {
	NSNumber *result = [self primitiveSeerPeeksNightZero];
	return [result boolValue];
}

- (void)setPrimitiveSeerPeeksNightZeroValue:(BOOL)value_ {
	[self setPrimitiveSeerPeeksNightZero:[NSNumber numberWithBool:value_]];
}










@end
