//
//  LLLoadSetupViewController.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/8/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLLoadSetupViewController.h"
#import "AppDelegate+CoreDataContext.h"
#import "GameSetup.h"

typedef NS_ENUM(NSInteger, gameSetupType)
{
    kCustomGameSetup,
    kDefaultGameSetup
};

@interface LLLoadSetupViewController () <UITableViewDataSource, UITableViewDelegate>

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
    
    
    // Add swipe to go back gesture
    UIScreenEdgePanGestureRecognizer *swipeToGoBack = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    swipeToGoBack.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:swipeToGoBack];
    
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

#pragma mark - Button Methods

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    //return number of game setups in shared data
//    switch (section) {
//            
//        case kCustomGameSetup:
//            //            NSLog(@"%lu",(unsigned long)[[[GameData sharedData] gameSetups] count]);
//            return [[[GameData sharedData] gameSetups] count];
//            
//        default:
//            //            NSLog(@"%lu",(unsigned long)[[[GameData sharedData] defaultGameSetups] count]);
//            return [[[GameData sharedData] defaultGameSetups] count];
//    }
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupCell" forIndexPath:indexPath];
//    
//    switch (indexPath.section) {
//            
//        case kCustomGameSetup:
//            cell.textLabel.text = [[[GameData sharedData] gameSetups][indexPath.row] name];
//            break;
//            
//        default:
//            cell.textLabel.text = [[[GameData sharedData] defaultGameSetups][indexPath.row] name];
//            break;
//    }
//    
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        // Delete the row from the data source
//        [[GameData sharedData] removeGameDataAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
//
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    switch (indexPath.section) {
//            
//        case kCustomGameSetup:
//            return YES;
//            
//        default:
//            return NO;
//    }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if ([[[GameData sharedData] gameSetups] count] == 0 && section == 0) {
//        return 0; //hide header if section is empty
//    }
//    return 50; //play around with this value
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    // create the parent view that will hold header Label
//    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(20.0, 10.0, 300.0, 40.0)];
//    [customView setBackgroundColor:[UIColor whiteColor]];
//    
//    // create a label object
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0,20.0,100.0,40.0)];
//    titleLabel.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
//    titleLabel.font = [titleLabel.font fontWithSize:(13.0)];
//    switch (section) {
//        case kCustomGameSetup:
//            titleLabel.text = @"CUSTOM";
//            break;
//        default:
//            titleLabel.text = @"DEFAULT";
//    }
//    
//    [customView addSubview:titleLabel];
//    
//    return customView;
//    
//}
//
//
//#pragma mark - Navigation
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//    NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
//    
//    if ([segue.identifier isEqualToString:@"showCreateGameSegue"]) {
//        
//        LLCreateGameViewController *destination = segue.destinationViewController;
//        
//        // use selected row to create new copy of Game Setup for editing
//        GameSetup *selectedSetup;
//        
//        if (indexPath.section == kCustomGameSetup) {
//            
//            selectedSetup = [[[GameData sharedData] gameSetups] objectAtIndex:[[_tableView indexPathForSelectedRow] row]];
//            
//        } else {
//            
//            selectedSetup = [[[GameData sharedData] defaultGameSetups] objectAtIndex:[[_tableView indexPathForSelectedRow] row]];
//        }
//        
//        destination.gameSetup = [selectedSetup copy];
//    }
//}

@end
