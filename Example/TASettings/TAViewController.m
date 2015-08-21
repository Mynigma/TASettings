//
//  TAViewController.m
//  TASettings
//
//  Created by Jan Chaloupecky on 08/20/2015.
//  Copyright (c) 2015 Jan Chaloupecky. All rights reserved.
//

#import "TAViewController.h"
#import <TASettings/TATextFieldSetting.h>
#import <TASettings/TASettingValue.h>
#import <TASettings/TAMultiValueSetting.h>

@interface TAViewController () <TASettingViewControllerDelegate>

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
    settingViewController.delegate = self;


    UINavigationController *navigationController  = [[UINavigationController alloc] initWithRootViewController:settingViewController];


    settingViewController.showDoneButton = YES;
    settingViewController.settings = [self settings];

    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Helper

-(TASettings *) settings {
    TASettings *settings = [[TASettings alloc] init];
    settings.localizedTitle = @"Account Setting";

    NSArray *sslValues = @[
    [TASettingValue valueWithTitle:@"Auto" value:@NO],
    [TASettingValue valueWithTitle:@"Clear" value:@NO],
    [TASettingValue valueWithTitle:@"START TLS" value:@YES],
    [TASettingValue valueWithTitle:@"SSL" value:@NO]];



    TASettings *generalSection = [TASettings settingWithSettingType:TASettingTypeGroup localizedTitle:@"General"];
    generalSection.settings = @[
            [[TATextFieldSetting alloc] initWithTitle:@"Account Name" placeholderValue:@"Gmail" secure:NO keyboardType:UIKeyboardTypeAlphabet],
            [[TATextFieldSetting alloc] initWithTitle:@"Sender Name" placeholderValue:@"John Doe" secure:NO keyboardType:UIKeyboardTypeAlphabet],
            [TASetting switchSettingWithTitle:@"Copy to sent messages" settingValue:[TASettingValue valueWithValue:nil defaultValue:@YES]],
    ];

    TASettings *incomingSection = [TASettings settingWithSettingType:TASettingTypeGroup localizedTitle:@"Incoming"];
    incomingSection.settings = @[
            [TATextFieldSetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"User Name"],
            [[TATextFieldSetting alloc] initWithTitle:@"Password" placeholderValue:nil secure:YES keyboardType:UIKeyboardTypeAlphabet],
            [[TATextFieldSetting alloc] initWithTitle:@"Host" placeholderValue:@"imap.google.com" secure:NO keyboardType:UIKeyboardTypeAlphabet],
            [[TATextFieldSetting alloc] initWithTitle:@"Port" placeholderValue:@"993" secure:NO keyboardType:UIKeyboardTypeNamePhonePad],
            [TAMultiValueSetting settingWithTitle:@"SSL" values:sslValues],
    ];

    TASettings *outgoingSection = [TASettings settingWithSettingType:TASettingTypeGroup localizedTitle:@"Outgoing"];
    outgoingSection.settings = @[
            [TATextFieldSetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"User Name"],
            [[TATextFieldSetting alloc] initWithTitle:@"Password" placeholderValue:nil secure:YES keyboardType:UIKeyboardTypeAlphabet],
            [[TATextFieldSetting alloc] initWithTitle:@"Host" placeholderValue:@"smtp.google.com" secure:NO keyboardType:UIKeyboardTypeAlphabet],
            [[TATextFieldSetting alloc] initWithTitle:@"Port" placeholderValue:@"587" secure:NO keyboardType:UIKeyboardTypeNamePhonePad],
            [TAMultiValueSetting settingWithTitle:@"SSL" values:sslValues],
    ];



    settings.settings = @[ generalSection, incomingSection, outgoingSection ];

    return settings;
}

#pragma mark - TASettingViewControllerDelegate

- (void)settingViewController:(TASettingViewController *)controller didChangeSetting:(TASetting *)setting
{
    NSLog(@"Setting value changed: %@", setting);
}


@end
