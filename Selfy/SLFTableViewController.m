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

@interface SLFTableViewController ()

@end

@implementation SLFTableViewController


{
    UIButton * settingsButton;
    UIButton * editButton;
    NSMutableArray * selfies;
    
    UIView * selfyView;
    UIImage * selfyImage;
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

        // header

        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        header.backgroundColor = [UIColor lightGrayColor];
        
        [self.view addSubview:header];
        
 //       [settingsButton = [UIButtonTypeContactAdd];
        
        
        
        
        settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        settingsButton.backgroundColor = [UIColor darkGrayColor];
        settingsButton.layer.cornerRadius = 15;
        [settingsButton setTitle:@"S" forState:UIControlStateNormal];
        settingsButton.titleLabel.font = [UIFont systemFontOfSize:18];


        
        [header addSubview:settingsButton];
        
        editButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 30, 30)];
        editButton.backgroundColor = [UIColor darkGrayColor];
        editButton.layer.cornerRadius = 15;
        [editButton setTitle:@"+" forState:UIControlStateNormal];
        editButton.titleLabel.font = [UIFont systemFontOfSize:18];

        
        [header addSubview:editButton];
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        

        UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 60, 70)];
        titleHeader.text = @"Selfy";
        titleHeader.textColor = [UIColor blackColor];
        titleHeader.font = [UIFont systemFontOfSize:24];
        
        [header addSubview:titleHeader];


        
        selfies = [@[
                       
 
                   @{
                       
                       @"image" : @"http://distilleryimage7.ak.instagram.com/6756ea06a44b11e2b62722000a1fbc10_7.jpg",
                       @"caption" : @"This is a selfy!",
                       @"user_id" : @"3n2mb23bnm",
                       @"avatar" : @"https://media.licdn.com/mpr/mpr/shrink_200_200/p/4/005/036/354/393842f.jpg",
                       @"selfy_id" : @"hjk2l32bn1"
                       
                       }
  
  
  
//  
//  @{@"image"   : [UIImage imageNamed:@"JohnYam"],
//                         @"caption" : @"IOS Programmer TO BE",
//                         @"user_id" : @"Jeffery Moulds",
//                         @"avatar"  : @"url",
//                         @"selfy_id" : @"hfdskl;fjds;l"
//                         }
                   
                       ] mutableCopy];


// Move to SelfyViewController
//        PFObject *testObject = [PFObject objectWithClassName:@"UserSelfy"];
//        testObject[@"image"] = @"";
//        testObject[@"caption"] = @"Test Caption";
//        [testObject saveInBackground];
        
//        PFUser * user = [PFUser currentUser];
        
//        user.username = @"jefferymoulds";
//        user.password = @"password";
//        
//        [user saveInBackground];
        
        self.tableView.rowHeight = self.tableView.frame.size.width + 100;

      
        selfyView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 180)];
        selfyView.backgroundColor = [UIColor lightGrayColor];
        
//        [self.contentView addSubview:selfyView];

        
        
        
    }
    return self;
}










- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SLFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    
        cell = [[SLFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

        cell.selfyInfo = selfies[indexPath.row];   //calls the selfies method (setSelfyInfo:(NSDictionary *)selfyInfo) in the tvcell.m
    
    
    
//        NSDictionary * listItem = selfy[indexPath.row];
//        cell.textLabel.text = listItem[@"user_id"];
//        cell.detailTextLabel.text = listItem[@"caption"];
//        cell.imageView.image = listItem[@"image"];
    
//      UIImage * testImage = [UIImage imageNamed:@"JohnYam"];
//      cell.imageView.image = testImage;
    
        
    return cell;
    
}
    



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (BOOL)prefersStatusBarHidden { return YES; }


@end
