//
//  SLFSettingsViewController.m
//  Selfy
//
//  Created by Jeffery Moulds on 4/29/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFSettingsViewController.h"
#import <Parse/Parse.h>
#import "SLFTableViewController.h"

@interface SLFSettingsViewController ()

{
 
    NSArray * fieldNames;
    NSMutableArray * fields;

    float signupOrigY;

}

@end

@implementation SLFSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated

{
    UIBarButtonItem * cancelSettingsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSettings)];
    
    cancelSettingsButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelSettingsButton;
    
    signupOrigY = (self.view.frame.size.height - 240) / 2;
    
//    signupForm = [[UIView alloc] initWithFrame:CGRectMake(20, signupOrigY, 280, 240)];
//    
//    [self.view addSubview:signupForm];
    
    fieldNames = @[@"Username", @"Password", @"Display Name", @"Email"];
    
    fields = [@[] mutableCopy];
    
    
    for (NSString * name in fieldNames)
        
    {
        
        NSInteger index = [fieldNames indexOfObject:name];
        
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(20, index * 50 + 40, 280, 40)];
        textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        textField.layer.cornerRadius = 6;
        textField.placeholder = name;
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        textField.leftViewMode = UITextFieldViewModeAlways;
  //      textField.delegate = self;
        textField.autocapitalizationType = NO;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [fields addObject:textField];

        [self.view addSubview:textField];
        
    }

    
    UIButton * saveChangesButton = [[UIButton alloc] initWithFrame:CGRectMake(20, ([fieldNames count] * 50) + 40, 280, 40)];
    saveChangesButton.backgroundColor = BLUE_COLOR;
    saveChangesButton.layer.cornerRadius = 6;
    
    [saveChangesButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [saveChangesButton addTarget:self action:@selector(saveChanges) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveChangesButton];

    
    
    
};


-(void)saveChanges

{

    PFUser * user = [PFUser user];
    
    
    //    UITextField * username = (UITextField *)fields[0];
    user.username = ((UITextField *)fields[0]).text;     // objects from array typically an ID. This casts it to a textfield.
    user.password = ((UITextField *)fields[1]).text;
    user.email = ((UITextField *)fields[3]).text;
    
    user[@"dislplay"] = ((UITextField *)fields[2]).text;
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (error == nil)
            
        {
            
            // brings us all the way back to the 1st navigtion controller (table view)  cancelSignUp puts back at login (its presenter)
            UINavigationController * pnc = (UINavigationController *)self.presentingViewController;
            
            pnc.navigationBarHidden = NO;
            pnc.viewControllers =  @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
            
            // show tableview
            [self cancelSettings];
            
            
        } else {
            
            NSString * errorDescription = error.userInfo[@"error"];
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Username Taken" message:errorDescription delegate:self cancelButtonTitle:@"Try Another Username" otherButtonTitles:nil];
            
            
            [alertView show];
            
        }
        
    }];
    
    
    
    
}


-(void)cancelSettings

{

    
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
