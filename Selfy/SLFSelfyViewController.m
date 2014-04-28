//
//  SLFSelfyViewController.m
//  Selfy
//
//  Created by Jeffery Moulds on 4/22/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFSelfyViewController.h"
#import "Parse/Parse.h"


@interface SLFSelfyViewController ()

{

    UITextView * captionField;
    UIButton * submit;
    UIButton * cancel;
    UIImageView * cameraButton;   
    UIView * newForm;
    UIImageView * imageView;
}

@end

@implementation SLFSelfyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.view.backgroundColor = [UIColor whiteColor];

 
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
        
        UITapGestureRecognizer * cameraImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cameraTap)];
        [cameraButton addGestureRecognizer:cameraImageTap];
        
        
// shift up view with keyboard popup - makes a view of the screen with all its objects and shifts them.  So you dont have to shift up all the objects indivudially.
        
//  CGRectMake(20, 20, 280, self.view.frame.size.height -40)];

    }
    return self;
}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView
//{
//    [textView resignFirstResponder];
//    
//    return  YES;
//    
//}


-(void)createForm

{

    newForm = [[UIView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:newForm];
    
    
    // added to import image to parse
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 80, 250, 250)];
    
    imageView.image = [UIImage imageNamed:@"magicSquare"];
    
    imageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    [newForm addSubview:imageView];
    
    
    
    
    // used UITextview to wrap the text instead of UITextfield
    captionField = [[UITextView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 140, 350, 280, 50)];
    captionField.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    captionField.layer.cornerRadius = 6;
    //        captionField.placeholder = @"Enter pithy comments here...";  // placeholder text
    captionField.tintColor =[UIColor blackColor];  // changes cursor color
    captionField.keyboardType = UIKeyboardTypeTwitter;
    
    captionField.delegate = self;
    
    [newForm addSubview:captionField];
    
    
    submit = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH /2) - 80, 420, 160, 30)];
    submit.backgroundColor = [UIColor lightGrayColor];
    submit.layer.cornerRadius = 8;
    [submit setTitle:@"New Selfy" forState:normal];
    [submit addTarget:self action:@selector(newSelfy) forControlEvents:UIControlEventTouchUpInside];
    
    [newForm addSubview:submit];
    
    
    cancel = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 20, 30, 30)];
    cancel.backgroundColor = [UIColor lightGrayColor];
    cancel.layer.cornerRadius = 15;
    [cancel setTitle:@"X" forState:normal];
    
    [newForm addSubview:cancel];
    
// not used now.  Using imageview above now
    cameraButton = [[UIImageView alloc] initWithFrame:CGRectMake(35, 80, 250, 250)];
    cameraButton.backgroundColor = [UIColor lightGrayColor];
    cameraButton.layer.cornerRadius = 30;
    [cameraButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [cameraButton.layer setBorderWidth:2.0];
    cameraButton.userInteractionEnabled = YES;
    
    cameraButton.image = [UIImage imageNamed:@"cameraIcon"];
    
    
//    [newForm addSubview:cameraButton];
    
    

}


-(void)tapScreen
{
    [captionField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
     
     newForm.frame = self.view.frame;

    }];
}


-(void)newSelfy
{

    NSData * imageData = UIImagePNGRepresentation(imageView.image);
    
    
    // All from parse faq
    PFFile * imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    
    PFObject * newSelfy = [PFObject objectWithClassName:@"UserSelfy"];
    
    newSelfy[@"caption"] = captionField.text;
    
    newSelfy[@"image"] = imageFile;
    
 //   [newSelfy saveInBackground];
    
    [newSelfy saveInBackgroundWithBlock:^(BOOL succeed, NSError * error) {
        [self cancelNewSelfy];
    
    }];
    
// connect current user to newSefly as parent : Parse relational data to create a parent
    
    
}


-(void)cancelNewSelfy

{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
    
}





-(void)cameraTap

{
    NSLog(@"Camera Tap");
}


-(void)textViewDidBeginEditing:(UITextView *)textView

{
    NSLog(@"Keyboard");
 
    [UIView animateWithDuration:0.3 animations:^{
        
        newForm.frame = CGRectMake(0, -KB_HEIGHT, 320, self.view.frame.size.height);
        
    }];
    
}

- (void)viewDidLoad
{

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.


//    [self createForm];

    
    
    UIBarButtonItem * cancelNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelNewSelfy)];
    
    cancelNewSelfyButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelNewSelfyButton;

    [self setNeedsStatusBarAppearanceUpdate];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    // stuff will happen / appear and slide with animation.
    
    [super viewWillAppear:animated];
    
    [self createForm];


}


-(void)viewDidAppear:(BOOL)animated

{
// stuff wont happen/appear until animation is done.

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
