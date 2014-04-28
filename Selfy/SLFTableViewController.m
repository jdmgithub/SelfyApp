//
//  SLFTableViewController.m
//  Selfy
//
//  Created by Jeffery Moulds on 4/21/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFTableViewController.h"
#import "SLFTableViewCell.h"
#import <Parse/Parse.h>
#import "SLFSelfyViewController.h"
#import "SLFNewNavigationController.h"

@interface SLFTableViewController ()

@end

@implementation SLFTableViewController


{
    UIButton * settingsButton;
    UIButton * editButton;
    NSArray * selfies;
    
    UIView * selfyView;
    UIImage * selfyImage;
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

      
        
 //       [self refreshSelfies];
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        
        self.tableView.rowHeight = self.tableView.frame.size.width + 100;

      
        selfyView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 180)];
        selfyView.backgroundColor = [UIColor lightGrayColor];
        
        
        
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

    UIBarButtonItem * addNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(openNewSelfy)];
    
    self.navigationItem.rightBarButtonItem = addNewSelfyButton;
    
}



-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"Did Appear");
    [self refreshSelfies];

}




-(void)openNewSelfy

{

    SLFSelfyViewController * newSelfyVC = [[SLFSelfyViewController alloc] initWithNibName:nil bundle:nil];

// created a new navigation controller to slide up
    SLFNewNavigationController * nc = [[SLFNewNavigationController alloc] initWithRootViewController:newSelfyVC];

    nc.navigationBar.barTintColor = BLUE_COLOR;
//    nc.navigationBar.translucent = NO;
    



    
    [self.navigationController presentViewController:nc animated:YES completion:^{
    
        
    }];
    

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.


    
    return [selfies count];
    
}

-(void)refreshSelfies
{
    PFQuery * query = [PFQuery queryWithClassName:@"UserSelfy"];
    
//    selfies = [query findObjects];  // syncronous and everything must wait for this to complete before more code runs.  The below makes things asyncronous.

 // filtering and ordering
    
    [query orderByDescending:@"createdAT"];
    
    [query whereKey:@"parent" equalTo:[PFUser currentUser]];
    
    
// saving
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError *error){

        selfies = objects;
        
        [self.tableView reloadData];
        
    }];

    
//  Change Order By Created Date : newest first
//  after user conntected to selfy : filter only your user's selfies
    
    
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SLFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    
        cell = [[SLFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

  

    cell.selfyInfo = selfies[indexPath.row];   //calls the selfies method (setSelfyInfo:(NSDictionary *)selfyInfo) in the tvcell.m

    
        
    return cell;
    
}
    



@end
