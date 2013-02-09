//
//  Lanucher.m
//  Launcher
//
//  Created by Enrique W on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Launcher.h"

@implementation Launcher

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(void) createIcon:(float)x withY:(float)y withWidth:(float)width withHeight:(float) height withImg:(NSString *)img withSel:(NSString *)methodName{
    
    //create the button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //set the position of the button
    button.frame = CGRectMake(x, y, width, height);
    
    //set the button's image
    [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];

    
    //listen for clicks
    [button addTarget:self action:NSSelectorFromString(methodName) forControlEvents:UIControlEventTouchUpInside];
    
    //add the button to the view
    [self.view addSubview:button];
    
}

-(void)resButtonPressed {
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    
    viewController.view = view;
    [self.navigationController pushViewController:viewController animated:YES];

}
-(void)calButtonPressed {
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    
    viewController.view = view;
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)dirButtonPressed {
    NSLog(@"Directory Button Pressed!");
}
-(void)hourButtonPressed {
    NSLog(@"Hour Button Pressed!");
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Home";
    
    //Setup CusTom Navigation bar
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 20, 320, 30)];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed: 139.0/255.0 green: 39.0/255.0 blue: 73.0/255.0 alpha: 1.0]];


    [self createIcon:2 withY:150 withWidth:75 withHeight:75 withImg:@"resIcon.png" withSel:@"resButtonPressed"];
    [self createIcon:82 withY:150 withWidth:75 withHeight:75 withImg:@"calIcon.png" withSel:@"calButtonPressed"];
    [self createIcon:162 withY:150 withWidth:75 withHeight:75 withImg:@"dirIcon.png" withSel:@"dirButtonPressed"];
    [self createIcon:243 withY:150 withWidth:75 withHeight:75 withImg:@"hourIcon.png" withSel:@"hourButtonPressed"];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc{
    [super dealloc];
    
}

@end
