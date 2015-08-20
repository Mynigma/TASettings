//
//  TAViewController.m
//  TASettings
//
//  Created by Jan Chaloupecky on 08/20/2015.
//  Copyright (c) 2015 Jan Chaloupecky. All rights reserved.
//

#import "TAViewController.h"
#import "TASettingTextField.h"
#import <TASettings/TASettingViewController.h>
#import <TASettings/TASettingTextField.h>

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

#pragma mark - Actions

- (IBAction)showSettings:(id)sender
{
    TASettingViewController *settingViewController = [[TASettingViewController alloc] init];


    UINavigationController *navigationController  = [[UINavigationController alloc] initWithRootViewController:settingViewController];


    settingViewController.showDoneButton = YES;
    settingViewController.settings = [self settings];

    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Helper

-(TASettings *) settings {
    TASettings *settings = [[TASettings alloc] init];
    settings.localizedTitle = @"Account Setting";

    TASettings *generalSection = [TASettings settingWithSettingType:TASettingTypeGroup localizedTitle:@"General"];
    generalSection.settings = @[
            [TASetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"Account Name"],
            [TASetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"Sender Name"],
    ];

    TASettings *incomingSection = [TASettings settingWithSettingType:TASettingTypeGroup localizedTitle:@"Incoming"];
    incomingSection.settings = @[
            [TASetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"User Name"],
            [TASetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"Password"],
            [TASetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"Host"],
    ];

    TASettings *outgoingSection = [TASettings settingWithSettingType:TASettingTypeGroup localizedTitle:@"OUtgoing"];
    incomingSection.settings = @[
            [TASettingTextField settingWithSettingType:TASettingTypeTextField localizedTitle:@"User Name"],
            [TASetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"Password"],
            [TASetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"Host"],
    ];

    settings.settings = @[ generalSection, incomingSection, outgoingSection ];

    return settings;
}


@end
