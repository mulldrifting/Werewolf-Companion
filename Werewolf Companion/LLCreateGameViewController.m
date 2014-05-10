//
//  LLCreateGameViewController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//
//  Expanding Table View Cell code from:
//  https://github.com/aberger/ABMExpandingTableViewCells
//

#import "LLCreateGameViewController.h"
#import "LLStepperTableViewCell.h"
#import "GameSetup.h"

@interface LLCreateGameViewController () <UITableViewDataSource, UITableViewDelegate, LLStepperTableViewCellProtocol>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSIndexPath *expandingIndexPath;
@property (nonatomic) NSIndexPath *expandedIndexPath;

@property (strong, nonatomic) NSMutableDictionary *setupAttributes;
@end

@implementation LLCreateGameViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set up table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Set up gesture recognizers
    UIScreenEdgePanGestureRecognizer *swipeToGoBack = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    swipeToGoBack.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:swipeToGoBack];

    [self createAttributesDictionary];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Show navigation bar in edit game setup screen
    [self.navigationController setNavigationBarHidden:NO];
    
    // Set style bar to default color = black
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

// change dictionary value for role in roleNumbers
// sent from Stepper Table View Cell
- (void)setValue:(int)value forRole:(NSString*)role
{
    NSString *key = [@"num" stringByAppendingString:role];
    [self.gameSetup setValue:[NSNumber numberWithInt:value] forKey:key];
}

#pragma mark - Attributes Dictionary Methods

- (void)createAttributesDictionary
{
    NSMutableDictionary *tempDict = [NSMutableDictionary new];
    
    for (NSString *attribute in [[self.gameSetup entity] attributesByName]) {
        [tempDict setObject:[self.gameSetup valueForKey:attribute] forKey:attribute];
    }
    
    self.setupAttributes = tempDict;
}



#pragma mark - Index Path Table View Methods

- (NSIndexPath *)actualIndexPathForTappedIndexPath:(NSIndexPath *)indexPath
{
	if (self.expandedIndexPath && [indexPath row] > [self.expandedIndexPath row]) {
		return [NSIndexPath indexPathForRow:[indexPath row] - 1
								  inSection:[indexPath section]];
	}
	
	return indexPath;
}

#pragma mark - Table View Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // if a cell is expanded, take into account
    if (self.expandedIndexPath) {
        return [[LLConstants listOfDefinedRoles] count] + 1;
    }
    // number of defined roles
    return [[LLConstants listOfDefinedRoles] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    // init expanded cell
	if ([indexPath isEqual:self.expandedIndexPath]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DescCell"
                                                                forIndexPath:indexPath];
        
        if (cell == nil) {
            NSLog(@"Desc Cell is nil");
            //            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
            //                                          reuseIdentifier:cellIdentifier];
        }
        
        NSIndexPath *theIndexPath = [self actualIndexPathForTappedIndexPath:indexPath];
		[cell.textLabel setText:[[LLConstants listOfRoleDescriptions] objectAtIndex:[theIndexPath row] - 1]];
        cell.textLabel.font = [[cell.textLabel font] fontWithSize:14.0];
        
        return cell;
	}
    
    // init expanding cell
	else {
        
        LLStepperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoleCell" forIndexPath:indexPath];
        
        if (cell == nil) {
            NSLog(@"Role Cell is nil");
            //            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
            //                                          reuseIdentifier:cellIdentifier];
        }
        
        // set cell's delegate to self
        cell.delegate = self;
        
        // set cell's values using the list of defined roles and the game setup dictionary roleNumbers
        NSIndexPath *theIndexPath = [self actualIndexPathForTappedIndexPath:indexPath];
        NSString *roleString = [LLConstants listOfDefinedRoles][theIndexPath.row];
        cell.roleLabel.text = roleString;
        cell.stepper.value = [[self.setupAttributes valueForKey:[@"num" stringByAppendingString:roleString]] doubleValue];
        cell.numberLabel.text = [NSString stringWithFormat:@"%d",(int)cell.stepper.value];
        
        return cell;
        
	}
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // disable touch on expanded cell
	UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
	if ([[cell reuseIdentifier] isEqualToString:@"DescCell"]) {
		return;
	}
	
    // deselect row
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	
    // get the actual index path
	indexPath = [self actualIndexPathForTappedIndexPath:indexPath];
	
    // save the expanded cell to delete it later
	NSIndexPath *theExpandedIndexPath = self.expandedIndexPath;
	
    // same row tapped twice - get rid of the expanded cell
	if ([indexPath isEqual:self.expandingIndexPath]) {
		self.expandingIndexPath = nil;
		self.expandedIndexPath = nil;
	}
    
    // add the expanded cell
	else {
		self.expandingIndexPath = indexPath;
		self.expandedIndexPath = [NSIndexPath indexPathForRow:[indexPath row] + 1
													inSection:[indexPath section]];
	}
	
	[tableView beginUpdates];
	
	if (theExpandedIndexPath) {
		[_tableView deleteRowsAtIndexPaths:@[theExpandedIndexPath]
                          withRowAnimation:UITableViewRowAnimationNone];
	}
	if (self.expandedIndexPath) {
		[_tableView insertRowsAtIndexPaths:@[self.expandedIndexPath]
                          withRowAnimation:UITableViewRowAnimationNone];
	}
	
	[tableView endUpdates];
	
    // scroll to the expanded cell
	[_tableView scrollToRowAtIndexPath:indexPath
                      atScrollPosition:UITableViewScrollPositionMiddle
                              animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:self.expandedIndexPath]) {
        return 90.0;
    }
    else {
        return 50.0;
    }
}

#pragma mark - Button Methods

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)openSettings:(id)sender {
}

- (IBAction)startPressed:(id)sender {
    
    if (![self.gameSetup hasSameAttributesAs:self.setupAttributes]) {
        
        // create a new Game Setup object and save as a custom
        self.gameSetup = [self createGameSetup];
    }
    
    [self performSegueWithIdentifier:@"showGameViewSegue" sender:self];
}

- (GameSetup *)createGameSetup
{
    GameSetup *newGameSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup"
                                                            inManagedObjectContext:self.gameSetup.managedObjectContext];
    NSDictionary *attributes = [[self.gameSetup entity] attributesByName];
    
    for (NSString *attribute in attributes) {
        [newGameSetup setValue:[self.setupAttributes valueForKey:attribute] forKey:attribute];
    }
    
    newGameSetup.name = [NSString stringWithFormat:@"%ld %@", (long)[newGameSetup numPlayers], [NSDate date]];
    NSLog(@"%@", newGameSetup.name);
    
    return newGameSetup;
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showGameViewSegue"]) {
        
//        GameViewController *destination = segue.destinationViewController;
//        
//        Game *newGame = [[Game alloc] initWithGameSetup:self.gameSetup];
//        destination.game = newGame;
    }
}





@end
