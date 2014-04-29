//
//  SLFViewController.m
//  Selfy
//
//  Created by Jeffery Moulds on 4/22/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFLoginViewController.h"
#import <Parse/Parse.h>
#import "SLFTableViewController.h"
#import "SLFNewNavigationController.h"
#import "SLFSignUpViewController.h"


@interface SLFLoginViewController () 
{
    UITextField * usernameField;
    UITextField * passwordField;
    UIButton * signInButton;
    UIButton * signupButton;
    UIView * newForm;
    
}


@end

@implementation SLFLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        newForm = [[UIView alloc] initWithFrame:self.view.frame];
 
        [self.view addSubview:newForm];
        
        usernameField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 90, 160, 30)];
        usernameField.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        usernameField.layer.cornerRadius = 6;
        usernameField.placeholder = @"Enter User Name";  // placeholder text
        usernameField.tintColor =[UIColor blackColor];  // changes cursor color
        
        // size of spacing for left justification
        usernameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        // must do to show spacing for left justification
        usernameField.leftViewMode = UITextFieldViewModeAlways;
   
        usernameField.keyboardType = UIKeyboardTypeTwitter;

        usernameField.autocapitalizationType = NO;
        
        usernameField.delegate = self;
        
        [newForm addSubview:usernameField];
 
        
        passwordField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 150, 160, 30)];
        passwordField.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        passwordField.layer.cornerRadius = 6;
        passwordField.placeholder = @"Enter Password";  // placeholder text
        passwordField.tintColor =[UIColor blackColor];  // changes cursor color

        // size of spacing for left justification
        passwordField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        // must do to show spacing for left justification
        passwordField.leftViewMode = UITextFieldViewModeAlways;
        
        passwordField.secureTextEntry = YES;
        passwordField.keyboardType = UIKeyboardTypeTwitter;
        
        passwordField.delegate = self;

        [newForm addSubview:passwordField];
        
        signInButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 210, 160, 30)];
        signInButton.backgroundColor = [UIColor lightGrayColor];
        signInButton.layer.cornerRadius = 10;
        [signInButton setTitle:@" Sign In" forState:normal];
        [signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];

        
        [newForm addSubview:signInButton];

        
        signupButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 250, 160, 30)];
        signupButton.backgroundColor = [UIColor lightGrayColor];
        signupButton.layer.cornerRadius = 10;
        [signupButton setTitle:@" Sign Up" forState:normal];
        [signupButton addTarget:self action:@selector(showSignUp) forControlEvents:UIControlEventTouchUpInside];
        
        
        [newForm addSubview:signupButton];
        
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
    
    }
    return self;
}

-(void)showSignUp

{

    SLFSignUpViewController * signUpVC = [[SLFSignUpViewController alloc] initWithNibName:nil bundle:nil];
    
    // created a new navigation controller to slide up
    SLFNewNavigationController * nc = [[SLFNewNavigationController alloc] initWithRootViewController:signUpVC];
    
    nc.navigationBar.barTintColor = BLUE_COLOR;
    nc.navigationBar.translucent = NO;
    
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
        
    }];

}


-(void)tapScreen
{
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        
        newForm.frame = self.view.frame;
        
    }];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"Keyboard");
    
    [UIView animateWithDuration:0.3 animations:^{
        
        newForm.frame = CGRectMake(0, -50, 320, self.view.frame.size.height);
        
    }];
    
}






-(void)signIn
// turn off auto cap prompt   fixed above?
// make it animate up with keyboard

{
//    PFUser * user = [PFUser currentUser];
//    
//    user.username = username.text;
//    user.password = password.text;
//    
//    username.text = nil;
//    password.text = nil;


    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.color = [UIColor orangeColor];
    
    activityIndicator.frame = CGRectMake(0, 150, 50, 50);
    
    
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    
    [PFUser logInWithUsernameInBackground:usernameField.text password:passwordField.text block:^(PFUser *user, NSError *error) {
        
        if (error == nil)
        {
            
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStyleGrouped]];
            
        } else {
            
            [activityIndicator removeFromSuperview];
            
            NSString * errorDescription = error.userInfo[@"error"];
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:errorDescription delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
            
            [activityIndicator removeFromSuperview];
            
            [alertView show];
        
     
     
     }

    }];

    
    
}




// this method, along with the delegate in .h and the password.delegate = self drops the keyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
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



@end
