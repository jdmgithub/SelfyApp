//
//  SLFViewController.m
//  Selfy
//
//  Created by Jeffery Moulds on 4/22/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFViewController.h"
#import <Parse/Parse.h>


@interface SLFViewController () 
{
    UITextField * username;
    UITextField * password;
    UIButton * submit;
    UIView * newForm;
    
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
        [submit addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];

        
        [newForm addSubview:submit];
 
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






-(void)newUser

{
    PFUser * user = [PFUser currentUser];
    
    user.username = @"Jeffery Moulds";
    user.password = @"password";
    
    [user saveInBackground];


    
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
