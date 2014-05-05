//
//  SLFFilterViewController.m
//  Selfy
//
//  Created by Jeffery Moulds on 5/5/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFFilterViewController.h"

@interface SLFFilterViewController ()

@property (nonatomic) NSString * currentFilter;


@end

@implementation SLFFilterViewController

{
    UIScrollView * scrollView;
    NSArray * filterNames;
    NSMutableArray * filterButtons;
    UIButton * button;

    
    float wh;


}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        filterButtons = [@[] mutableCopy];
        filterNames = @[
                        @"CIColorInvert",
                        @"CIColorMonochrome",
                        @"CIColorPosterize",
                        @"CIFalseColor",
                        @"CIMaximumComponent",
                        @"CIMinimumComponent",
                        @"CIPhotoEffectChrome",
                        @"CIPhotoEffectFade",
                        @"CIPhotoEffectInstant",
                        @"CIPhotoEffectMono",
                        @"CIPhotoEffectNoir",
                        @"CIPhotoEffectProcess",
                        @"CIPhotoEffectTonal",
                        @"CIPhotoEffectTransfer",
                        @"CISepiaTone",
                        @"CIVignette",
                        // pasted from color image filter reference.
                        //blurr effects
                        //                        @"CIBoxBlur",
                        //                        @"CIDiscBlur",
                        //                        @"CIGaussianBlur",
                        //                        @"CIMedianFilter",
                        //                        @"CIMotionBlur",
                        //                        @"CINoiseReduction",
                        //                        @"CIZoomBlur"
                        
                        ];
        
        
        scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:scrollView];

        
        
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    // Do any additional setup after loading the view.

    wh = self.view.frame.size.height - 20;
    
    NSLog(@"create button");
    
    
    int numButtons = (int) [scrollView.subviews count];
    NSLog(@"currently scrollview has %d buttons", numButtons);
    
    
    for (NSString * filterName in filterNames)
    {
        int i = (int)[filterNames indexOfObject:filterName];
        int x = (wh + 10) * i + 10;
        
        UIButton * filterButton = [[UIButton alloc] initWithFrame:CGRectMake(x, 10, wh, wh)];
        filterButton.tag = i;
        filterButton.backgroundColor = [UIColor whiteColor];
        
        [filterButton addTarget:self action:@selector(switchFilter:) forControlEvents:UIControlEventTouchUpInside];
        [filterButtons addObject:filterButton];
        
        [scrollView addSubview:filterButton];
    }
    
    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    scrollView.contentSize = CGSizeMake((wh + 10) * [filterNames count] + 10, self.view.frame.size.height);
    
    
    
    
    UIScrollView * imageScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 100)];
    imageScroller.pagingEnabled = YES;
    [imageScroller setAlwaysBounceVertical:NO];
    imageScroller.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    
    NSInteger numberofViews = 20;
    for (int i = 0; i < numberofViews; i++) {
        button = [[UIButton alloc] initWithFrame:CGRectMake((i*90), 10, 80, 80)]; // X adds pad each alloc/init
        button.backgroundColor = [UIColor whiteColor];
        [imageScroller addSubview:button];
    }
    
    imageScroller.contentSize = CGSizeMake((button.frame.size.width) * numberofViews, 100);
    [self.view addSubview:imageScroller];
    
    
    UIView * viewAboveScroller = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 140, SCREEN_WIDTH, 40)];
    
    
    
    
    viewAboveScroller.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:viewAboveScroller];



}



-(UIImage *)filterImage:(UIImage *)image filterName:(NSString *)filterName

{
    CIImage * ciImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter * filter = [CIFilter filterWithName:filterName];
    
    [filter setValue:ciImage forKeyPath:kCIInputImageKey];
    
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    
    CIImage * ciResult = [filter valueForKeyPath:kCIOutputImageKey];
    
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
    
}

-(void)switchFilter:(UIButton *)filterButton;

{
    self.currentFilter = [filterNames objectAtIndex:filterButton.tag];
    
    UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    

//    [self.delegate updateCurrentImageWithFilteredImage:image];
    
    
    
    //    [self filterImage:[self shrinkImage:self.imageToFilter maxWH:SCREEN_WIDTH * 2]
    //
    //           [filterName:self.currentFilter];
    
    
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
