//
//  SLFSignUpViewController.m
//  Selfy
//
//  Created by Jeffery Moulds on 4/29/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFSignUpViewController.h"
#import <Parse/Parse.h>
#import "SLFTableViewController.h"

@interface SLFSignUpViewController () <UITextFieldDelegate>

@end

@implementation SLFSignUpViewController


{
    UIView * signupForm;
//    UITextField * usernameField;
//    UITextField * displayNameField;
//    UITextField * passwordField;
//    UITextField * emailField;
//    UIImageView * avatar;

    float signupOrigY;
    
    float signupOrigX;

    NSArray * fieldNames;
    NSMutableArray * fields;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor whiteColor];
        
 //       UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated

{
    UIBarButtonItem * cancelSignUpButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSignUp)];

    cancelSignUpButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelSignUpButton;
    
    signupOrigY = (self.view.frame.size.height - 240) / 2;
    
    signupForm = [[UIView alloc] initWithFrame:CGRectMake(20, signupOrigY, 280, 240)];
    
    [self.view addSubview:signupForm];
 
    fieldNames = @[@"Username", @"Password", @"Display Name", @"Email"];
    
    fields = [@[] mutableCopy];
    
    
    for (NSString * name in fieldNames)

    {
    
    NSInteger index = [fieldNames indexOfObject:name];

    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, index * 50, 280, 40)];
    textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    textField.layer.cornerRadius = 6;
    textField.placeholder = name;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    textField.autocapitalizationType = NO;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [fields addObject:textField];
    [signupForm addSubview:textField];
    
    }

    UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, [fieldNames count] * 50, 280, 40)];
    submitButton.backgroundColor = BLUE_COLOR;
    submitButton.layer.cornerRadius = 6;
        
    [submitButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(signUP) forControlEvents:UIControlEventTouchUpInside];
        
    [signupForm addSubview:submitButton];

    
    

}


-(void)signUP

{
    [self hideKeyboard];
    
    PFUser * user = [PFUser user];
    
    UIImage * avatarImage = [UIImage imageNamed:@"JefferyMoulds"];
    
    NSData * imageData = UIImagePNGRepresentation(avatarImage);
    
    PFFile * imageFile = [PFFile fileWithName:@"avatar.png" data:imageData];
    
    
//    UITextField * username = (UITextField *)fields[0];
    user.username = ((UITextField *)fields[0]).text;     // objects from array typically an ID. This casts it to a textfield.
    user.password = ((UITextField *)fields[1]).text;
    user.email = ((UITextField *)fields[3]).text;

    user[@"dislplay"] = ((UITextField *)fields[2]).text;
    user[@"avatar"] = imageFile;
    
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
       if (error == nil)
           
       {

           // brings us all the way back to the 1st navigtion controller (table view)  cancelSignUp puts back at login (its presenter)
           UINavigationController * pnc = (UINavigationController *)self.presentingViewController;
           
           pnc.navigationBarHidden = NO;
           pnc.viewControllers =  @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];

           // show tableview
           [self cancelSignUp];
           
           
       } else {
       
           NSString * errorDescription = error.userInfo[@"error"];
           
           UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Username Taken" message:errorDescription delegate:self cancelButtonTitle:@"Try Another Username" otherButtonTitles:nil];
           
           
           [alertView show];
           
       }
        
    }];
    
}




-(void)cancelSignUp

{
 [self.navigationController dismissViewControllerAnimated:YES completion:^{
     
 }];
    

}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField  // lets you specify which textField can be edited, will mandate completion order
//
//{
//    NSInteger index = [fields indexOfObject:textField];
//    NSInteger emptyIndex = [fields count];
//    
//    for (UITextField * textFieldItem in fields)
//    
//    {
//        NSInteger fieldIndex = [fields indexOfObject:textFieldItem];
//        if(emptyIndex == [fields count])
//        {
//            if([textFieldItem.text isEqual:@""])
//            {
//                emptyIndex = fieldIndex;
//            }
//        }
//        
//    }
//    
//    if(index <= emptyIndex) return YES;
//    
//    return NO;
//
//}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{

//    NSInteger index = [fields indexOfObject:textField];  lost of stuff to have slide position based on 3.5 vs 4 inch screens
    

    NSLog(@"%.00f", self.view.frame.size.height);
    
    // 504 height for 4 inch
    // 416 height for 3.5 inch

    int extraSlide = 0;
    
    if(self.view.frame.size.height >500)
    
    {
        extraSlide = 107;
 
    } else {
    
        NSInteger index = [fields indexOfObject:textField];
        extraSlide = index * 25 + 65;
    }
    
    
    //    int extraSlide = index * 25 + 65;   adjusting to move fiels so they fit within 3.5 inch screens.
//    int extraSlide = 107;
    
    [UIView animateWithDuration:0.3 animations:^{
    signupForm.frame = CGRectMake(20, signupOrigY - extraSlide, 280, 240);
//    signupForm.frame = CGRectMake(20, -107, 280, 240);
    
    }];


}


-(void)hideKeyboard
{
    for (UITextField * textFieldItem in fields)
    {
        [textFieldItem resignFirstResponder];
    
    }
    
    [UIView animateWithDuration:0.3 animations:^{
     signupForm.frame = CGRectMake(20, signupOrigY, 280, 240);
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
