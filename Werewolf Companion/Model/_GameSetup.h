// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GameSetup.h instead.

#import <CoreData/CoreData.h>


extern const struct GameSetupAttributes {
	__unsafe_unretained NSString *isDefault;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *numAssassin;
	__unsafe_unretained NSString *numHunter;
	__unsafe_unretained NSString *numMinion;
	__unsafe_unretained NSString *numPlayers;
	__unsafe_unretained NSString *numPriest;
	__unsafe_unretained NSString *numSeer;
	__unsafe_unretained NSString *numVigilante;
	__unsafe_unretained NSString *numVillager;
	__unsafe_unretained NSString *numWerewolf;
	__unsafe_unretained NSString *wolvesSeeRoleOfKill;
} GameSetupAttributes;

extern const struct GameSetupRelationships {
} GameSetupRelationships;

extern const struct GameSetupFetchedProperties {
} GameSetupFetchedProperties;















@interface GameSetupID : NSManagedObjectID {}
@end

@interface _GameSetup : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GameSetupID*)objectID;





@property (nonatomic, strong) NSNumber* isDefault;



@property BOOL isDefaultValue;
- (BOOL)isDefaultValue;
- (void)setIsDefaultValue:(BOOL)value_;

//- (BOOL)validateIsDefault:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numAssassin;



@property int16_t numAssassinValue;
- (int16_t)numAssassinValue;
- (void)setNumAssassinValue:(int16_t)value_;

//- (BOOL)validateNumAssassin:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numHunter;



@property int16_t numHunterValue;
- (int16_t)numHunterValue;
- (void)setNumHunterValue:(int16_t)value_;

//- (BOOL)validateNumHunter:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numMinion;



@property int16_t numMinionValue;
- (int16_t)numMinionValue;
- (void)setNumMinionValue:(int16_t)value_;

//- (BOOL)validateNumMinion:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numPlayers;



@property int16_t numPlayersValue;
- (int16_t)numPlayersValue;
- (void)setNumPlayersValue:(int16_t)value_;

//- (BOOL)validateNumPlayers:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numPriest;



@property int16_t numPriestValue;
- (int16_t)numPriestValue;
- (void)setNumPriestValue:(int16_t)value_;

//- (BOOL)validateNumPriest:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numSeer;



@property int16_t numSeerValue;
- (int16_t)numSeerValue;
- (void)setNumSeerValue:(int16_t)value_;

//- (BOOL)validateNumSeer:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numVigilante;



@property int16_t numVigilanteValue;
- (int16_t)numVigilanteValue;
- (void)setNumVigilanteValue:(int16_t)value_;

//- (BOOL)validateNumVigilante:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numVillager;



@property int16_t numVillagerValue;
- (int16_t)numVillagerValue;
- (void)setNumVillagerValue:(int16_t)value_;

//- (BOOL)validateNumVillager:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numWerewolf;



@property int16_t numWerewolfValue;
- (int16_t)numWerewolfValue;
- (void)setNumWerewolfValue:(int16_t)value_;

//- (BOOL)validateNumWerewolf:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* wolvesSeeRoleOfKill;



@property BOOL wolvesSeeRoleOfKillValue;
- (BOOL)wolvesSeeRoleOfKillValue;
- (void)setWolvesSeeRoleOfKillValue:(BOOL)value_;

//- (BOOL)validateWolvesSeeRoleOfKill:(id*)value_ error:(NSError**)error_;






@end

@interface _GameSetup (CoreDataGeneratedAccessors)

@end

@interface _GameSetup (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveIsDefault;
- (void)setPrimitiveIsDefault:(NSNumber*)value;

- (BOOL)primitiveIsDefaultValue;
- (void)setPrimitiveIsDefaultValue:(BOOL)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveNumAssassin;
- (void)setPrimitiveNumAssassin:(NSNumber*)value;

- (int16_t)primitiveNumAssassinValue;
- (void)setPrimitiveNumAssassinValue:(int16_t)value_;




- (NSNumber*)primitiveNumHunter;
- (void)setPrimitiveNumHunter:(NSNumber*)value;

- (int16_t)primitiveNumHunterValue;
- (void)setPrimitiveNumHunterValue:(int16_t)value_;




- (NSNumber*)primitiveNumMinion;
- (void)setPrimitiveNumMinion:(NSNumber*)value;

- (int16_t)primitiveNumMinionValue;
- (void)setPrimitiveNumMinionValue:(int16_t)value_;




- (NSNumber*)primitiveNumPlayers;
- (void)setPrimitiveNumPlayers:(NSNumber*)value;

- (int16_t)primitiveNumPlayersValue;
- (void)setPrimitiveNumPlayersValue:(int16_t)value_;




- (NSNumber*)primitiveNumPriest;
- (void)setPrimitiveNumPriest:(NSNumber*)value;

- (int16_t)primitiveNumPriestValue;
- (void)setPrimitiveNumPriestValue:(int16_t)value_;




- (NSNumber*)primitiveNumSeer;
- (void)setPrimitiveNumSeer:(NSNumber*)value;

- (int16_t)primitiveNumSeerValue;
- (void)setPrimitiveNumSeerValue:(int16_t)value_;




- (NSNumber*)primitiveNumVigilante;
- (void)setPrimitiveNumVigilante:(NSNumber*)value;

- (int16_t)primitiveNumVigilanteValue;
- (void)setPrimitiveNumVigilanteValue:(int16_t)value_;




- (NSNumber*)primitiveNumVillager;
- (void)setPrimitiveNumVillager:(NSNumber*)value;

- (int16_t)primitiveNumVillagerValue;
- (void)setPrimitiveNumVillagerValue:(int16_t)value_;




- (NSNumber*)primitiveNumWerewolf;
- (void)setPrimitiveNumWerewolf:(NSNumber*)value;

- (int16_t)primitiveNumWerewolfValue;
- (void)setPrimitiveNumWerewolfValue:(int16_t)value_;




- (NSNumber*)primitiveWolvesSeeRoleOfKill;
- (void)setPrimitiveWolvesSeeRoleOfKill:(NSNumber*)value;

- (BOOL)primitiveWolvesSeeRoleOfKillValue;
- (void)setPrimitiveWolvesSeeRoleOfKillValue:(BOOL)value_;




@end
