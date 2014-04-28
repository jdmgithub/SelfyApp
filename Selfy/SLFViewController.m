//
//  SLFViewController.m
//  Selfy
//
//  Created by Jeffery Moulds on 4/22/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFViewController.h"
#import <Parse/Parse.h>
#import "SLFTableViewController.h"


@interface SLFViewController () 
{
    UITextField * username;
    UITextField * password;
    UIButton * submit;
    UIButton * signUpButton;
    UIView * newForm;
    UIView * signUpForm;
    
}


@end

@implementation SLFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        newForm = [[UIView alloc] initWithFrame:self.view.frame];
 
        [self.view addSubview:newForm];
        
        
        username = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 90, 160, 30)];
        username.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        username.layer.cornerRadius = 6;
        username.placeholder = @"Enter User Name";  // placeholder text
        username.tintColor =[UIColor blackColor];  // changes cursor color
        
        // size of spacing for left justification
        username.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        // must do to show spacing for left justification
        username.leftViewMode = UITextFieldViewModeAlways;
   
        username.keyboardType = UIKeyboardTypeTwitter;

        ///////////////   ????????? did this fix autocap?
        username.autocapitalizationType = NO;
        
        
        username.delegate = self;
        
        [newForm addSubview:username];

        
        password = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 150, 160, 30)];
        password.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        password.layer.cornerRadius = 6;
        password.placeholder = @"Enter Password";  // placeholder text
        password.tintColor =[UIColor blackColor];  // changes cursor color

        // size of spacing for left justification
        password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        // must do to show spacing for left justification
        password.leftViewMode = UITextFieldViewModeAlways;
        
        password.secureTextEntry = YES;
        password.keyboardType = UIKeyboardTypeTwitter;
        
        password.delegate = self;

        [newForm addSubview:password];
        
        submit = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 210, 160, 30)];
        submit.backgroundColor = [UIColor lightGrayColor];
        submit.layer.cornerRadius = 10;
        [submit setTitle:@" Sign In" forState:normal];
        [submit addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];

        
        [newForm addSubview:submit];
        
        
     

        
        signUpButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 260, 160, 30)];
        signUpButton.backgroundColor = [UIColor lightGrayColor];
        signUpButton.layer.cornerRadius = 10;
        [signUpButton setTitle:@" Sign Up" forState:normal];
        [signUpButton addTarget:self action:@selector(signUpForm) forControlEvents:UIControlEventTouchUpInside];
        
        
        [newForm addSubview:signUpButton];

        
        
        
 
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
    
    }
    return self;
}


-(void)tapScreen
{
    [username resignFirstResponder];
    [password resignFirstResponder];
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
    PFUser * user = [PFUser currentUser];
    
    user.username = username.text;
    user.password = password.text;
    
    username.text = nil;
    password.text = nil;


    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.color = [UIColor orangeColor];
    
    activityIndicator.frame = CGRectMake(0, 150, 50, 50);
    
    
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    

//  UIActivityIndicatorView
    
    // method begins with Start.
    
  //  Add to subview somewhere.
    
    
//    [user saveInBackground];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
   
        // login errors at parse
     if (error == nil)
     {
     
         
         
         self.navigationController.navigationBarHidden = NO;
         self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStyleGrouped]];
         
     } else {

         [activityIndicator removeFromSuperview];
        
         NSString * errorDescription = error.userInfo[@"error"];
         
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:errorDescription delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
         
         
         [alertView show];
         
         //  error.userinfo[@"error"]
         //  UIAlertView with message
 
         // acitivy inidiator remove if error i.e. from superview.  
     }
        
        
    }];

    
}




// this method, along with the delegate in .h and the password.delegate = self drops the keyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



-(void)signUpForm

{
    

    
    signUpForm = [[UIView alloc] initWithFrame:self.view.frame];
    signUpForm.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:signUpForm];

    
    
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
