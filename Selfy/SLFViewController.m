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
    UITextField * newUserDisplayName;
    UITextField * newUserName;
    UITextField * newUserPassword;
    UITextField * newUserEmail;
    UIImage * newUserAvatar;
    UIButton * newSignUpButton;
    


    
    
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



-(void)signUpForm

{
    
    signUpForm = [[UIView alloc] initWithFrame:self.view.frame];
    signUpForm.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:signUpForm];


//    UIImage * newUserAvatar;

    
    newUserDisplayName = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 80, 160, 30)];
    newUserDisplayName.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    newUserDisplayName.layer.cornerRadius = 6;
    newUserDisplayName.placeholder = @"Enter A Display Name";  // placeholder text
    newUserDisplayName.tintColor =[UIColor blackColor];  // changes cursor color
    newUserDisplayName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    newUserDisplayName.leftViewMode = UITextFieldViewModeAlways;
    newUserDisplayName.keyboardType = UIKeyboardTypeTwitter;
    newUserDisplayName.autocapitalizationType = NO;
    [signUpForm addSubview:newUserDisplayName];

    newUserName = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 130, 160, 30)];
    newUserName.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    newUserName.layer.cornerRadius = 6;
    newUserName.placeholder = @"Enter A User Name";  // placeholder text
    newUserName.tintColor =[UIColor blackColor];  // changes cursor color
    newUserName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    newUserName.leftViewMode = UITextFieldViewModeAlways;
    newUserName.keyboardType = UIKeyboardTypeTwitter;
    newUserName.autocapitalizationType = NO;
    [signUpForm addSubview:newUserName];

    newUserPassword = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 180, 160, 30)];
    newUserPassword.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    newUserPassword.layer.cornerRadius = 6;
    newUserPassword.placeholder = @"Enter A Password";  // placeholder text
    newUserPassword.tintColor =[UIColor blackColor];  // changes cursor color
    newUserPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    newUserPassword.leftViewMode = UITextFieldViewModeAlways;
    newUserPassword.keyboardType = UIKeyboardTypeTwitter;
    newUserPassword.secureTextEntry = YES;
    newUserPassword.autocapitalizationType = NO;
    [signUpForm addSubview:newUserPassword];

    newUserEmail = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 230, 160, 30)];
    newUserEmail.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    newUserEmail.layer.cornerRadius = 6;
    newUserEmail.placeholder = @"Enter Email";  // placeholder text
    newUserEmail.tintColor =[UIColor blackColor];  // changes cursor color
    newUserEmail.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    newUserEmail.leftViewMode = UITextFieldViewModeAlways;
    newUserEmail.keyboardType = UIKeyboardTypeTwitter;
    newUserEmail.autocapitalizationType = NO;
    [signUpForm addSubview:newUserEmail];
    
    newUserDisplayName.delegate = self;
    newUserName.delegate = self;
    newUserPassword.delegate = self;
    newUserEmail.delegate = self;


    newSignUpButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 280, 160, 30)];
    newSignUpButton.backgroundColor = [UIColor lightGrayColor];
    newSignUpButton.layer.cornerRadius = 10;
    [newSignUpButton setTitle:@" Sign Up" forState:normal];
    [newSignUpButton addTarget:self action:@selector(newUserCreation) forControlEvents:UIControlEventTouchUpInside];
    [signUpForm addSubview:newSignUpButton];
    
    
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signUpTapScreen)];
    [self.view addGestureRecognizer:tap];

    signUpForm.frame = CGRectMake(0, -50, 320, self.view.frame.size.height);

}



-(void)newUserCreation
{
//    NSData * avatarData = UIImagePNGRepresentation(imageView.image);

//    PFFile * imageFile = [PFFile fileWithName:@"image.png" data:avatarData];
    

    PFUser * newUserCreation = [PFUser objectWithClassName:@"UserSelfy"];
    
    newUserCreation[@"displayName"] = newUserDisplayName.text;
    newUserCreation[@"user"] = newUserName.text;
    newUserCreation[@"password"] = newUserPassword.text;
    newUserCreation[@"email"] = newUserEmail.text;
    
//    newUserCreation[@"image"] = imageFile;

    [newUserCreation signUp];
    
//    [newUserCreation signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
//    }];
    
//    [newUserCreation saveInBackgroundWithBlock:^(BOOL succeed, NSError * error) {
//        [self cancelNewSelfy];

}






-(void)signUpTapScreen
{
    [newUserDisplayName resignFirstResponder];
    [newUserName resignFirstResponder];
    [newUserPassword resignFirstResponder];
    [newUserEmail resignFirstResponder];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        signUpForm.frame = self.view.frame;
        
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
