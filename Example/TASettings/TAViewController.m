//
//  TAViewController.m
//  TASettings
//
//  Created by Jan Chaloupecky on 08/20/2015.
//  Copyright (c) 2015 Jan Chaloupecky. All rights reserved.
//

#import "TAViewController.h"
#import <TASettings/TASettingViewController.h>

@interface TAViewController ()

@end

@implementation TAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showSettings:(id)sender
{
    TASettingViewController *settingViewController = [[TASettingViewController alloc] init];

    settingViewController.showDoneButton = YES;
    
    UINavigationController *navigationController  = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
