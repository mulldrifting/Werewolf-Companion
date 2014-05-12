//
//  LLLoadSetupViewController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLLoadSetupViewController.h"
#import "LLCreateGameViewController.h"
#import "AppDelegate+CoreDataContext.h"
#import "NSManagedObject+DeepCopying.h"
#import "GameSetup.h"

typedef NS_ENUM(NSInteger, gameSetupType)
{
    kDefaultGameSetup,
    kCustomGameSetup
};

@interface LLLoadSetupViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSManagedObjectContext *objectContext;
@property (strong, nonatomic) NSFetchedResultsController *resultsController;

@end

@implementation LLLoadSetupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup table view
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    LLAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.objectContext = appDelegate.objectContext;
    
    // Add swipe to go back gesture
    UIScreenEdgePanGestureRecognizer *swipeToGoBack = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    swipeToGoBack.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:swipeToGoBack];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:kDefaultGameSetupsInitialized]) {
        [self addInitialGameSetups];
        NSLog(@"add initial game setups");
        [defaults setValue:[NSNumber numberWithBool:YES] forKey:kDefaultGameSetupsInitialized];
        [defaults synchronize];
    }
    
    [self fetchResults];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Show navigation bar on load game setup screen
    [self.navigationController setNavigationBarHidden:NO];
    
    // Set style bar color to default = black
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [_tableView reloadData];
    
}

- (void)deleteSetupWithIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.resultsController objectAtIndexPath:indexPath];
    [self.objectContext deleteObject:object];
}

- (void)fetchResults
{
    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"GameSetup"];
    NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *defaultSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"isDefault" ascending:YES];
    [fetchRequest setSortDescriptors:@[nameSortDescriptor, defaultSortDescriptor]];
    
//    NSArray *setups = [self.objectContext executeFetchRequest:fetchRequest error:&error];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                 managedObjectContext:self.objectContext
                                                                   sectionNameKeyPath:@"isDefault"
                                                                            cacheName:@"SetupCache"];
    self.resultsController.delegate = self;
    [self.resultsController performFetch:&error];
    
    [self.tableView reloadData];
}

- (void)addInitialGameSetups
{
    
    GameSetup *nemesisSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup"
                                                             inManagedObjectContext:self.objectContext];
    nemesisSetup.name = @"5P Nemesis";
    nemesisSetup.numWerewolf = @1;
    nemesisSetup.numVillager = @3;
    nemesisSetup.numNemesis = @1;
    nemesisSetup.isDefault = @YES;
    
    GameSetup *fivesSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup"
                                                          inManagedObjectContext:self.objectContext];
    fivesSetup.name = @"5P Special";
    fivesSetup.numWerewolf = @1;
    fivesSetup.numVillager = @1;
    fivesSetup.numHunter = @1;
    fivesSetup.numSeer = @1;
    fivesSetup.numMinion = @1;
    fivesSetup.isDefault = @YES;
    
    GameSetup *sevensSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup"
                                                           inManagedObjectContext:self.objectContext];
    sevensSetup.name = @"7P Classic";
    sevensSetup.numWerewolf = @2;
    sevensSetup.numVillager = @4;
    sevensSetup.numSeer = @1;
    sevensSetup.isDefault = @YES;
    
    GameSetup *ninesSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup"
                                                          inManagedObjectContext:self.objectContext];
    ninesSetup.name = @"9P Classic";
    ninesSetup.numWerewolf = @2;
    ninesSetup.numVillager = @6;
    ninesSetup.numSeer = @1;
    ninesSetup.isDefault = @YES;
}


#pragma mark - Button Methods

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.resultsController sections] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([[self.resultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.resultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self deleteSetupWithIndexPath:indexPath];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case kCustomGameSetup:
            return YES;
            
        default:
            return NO;
    }
}

#pragma mark - Table View Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([[self.resultsController sections] count] == 2) {
        return 50; //hide header if section is empty
    }
    else if (section == kCustomGameSetup) {
        return 0;
    }
    else {
        return 50;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(20.0, 10.0, 300.0, 40.0)];
    [customView setBackgroundColor:[UIColor whiteColor]];
    
    // create a label object
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0,20.0,100.0,40.0)];
    titleLabel.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
    titleLabel.font = [titleLabel.font fontWithSize:(13.0)];
    switch (section) {
        case kCustomGameSetup:
            titleLabel.text = @"CUSTOM";
            break;
        default:
            titleLabel.text = @"DEFAULT";
    }
    
    [customView addSubview:titleLabel];
    
    return customView;
    
}



#pragma mark - NSFetchedResultsController Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void) configureCell:(UITableViewCell *)cell
           atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.resultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [object valueForKey:@"name"];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"showCreateGameSegue"]) {
        
        LLCreateGameViewController *destination = segue.destinationViewController;
        
        // use selected row to create new copy of Game Setup for editing
        GameSetup *selectedSetup;
        selectedSetup = [self.resultsController objectAtIndexPath:indexPath];
        
        destination.gameSetup = selectedSetup;
    }
}

@end
