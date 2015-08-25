//
//  TAViewController.m
//  TASetting
//
//  Created by Jan Chaloupecky on 08/20/2015.
//  Copyright (c) 2015 Jan Chaloupecky. All rights reserved.
//

#import "TAViewController.h"
#import <TASettings/TATextFieldSetting.h>
#import <TASettings/TASettingValue.h>
#import <TASettings/TAMultiValueSetting.h>
#import <TASettings/TANumberValidator.h>
#import <TASettings/TAActionSetting.h>

@interface TAViewController () <TASettingViewControllerDelegate>

@property(nonatomic, strong) TASettingViewController *settingViewController;
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

    self.settingViewController = [[TASettingViewController alloc] initWithSettings:[self settings]];

    self.settingViewController.delegate = self;
    self.settingViewController.showDoneButton = YES;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.settingViewController];


    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Helper

- (TASetting *)settings
{
    TASetting *settings = [[TASetting alloc] initWithSettingType:TASettingTypeChild title:@"Account Setting"];


    NSArray *sslValues = @[
            [TASettingValue valueWithTitle:@"Auto" value:@NO],
            [TASettingValue valueWithTitle:@"Clear" value:@NO],
            [TASettingValue valueWithTitle:@"START TLS" value:@YES],
            [TASettingValue valueWithTitle:@"SSL" value:@NO] ];


    TASetting *generalSection = [TASetting settingWithSettingType:TASettingTypeGroup localizedTitle:@"General"];
    generalSection.settings = @[
            [[TATextFieldSetting alloc] initWithTitle:@"Account Name" placeholderValue:@"Gmail" secure:NO keyboardType:UIKeyboardTypeAlphabet],
            [[TATextFieldSetting alloc] initWithTitle:@"Sender Name" placeholderValue:@"John Doe" secure:NO keyboardType:UIKeyboardTypeAlphabet],
            [TASetting switchSettingWithTitle:@"Copy to sent messages" settingValue:[TASettingValue valueWithValue:nil defaultValue:@YES]],
    ];

    TASetting *oauthSection = [TASetting settingWithSettingType:TASettingTypeGroup localizedTitle:@"OAuth"];
    oauthSection.footerText = @"";
    oauthSection.settings = @[
            [[TAActionSetting alloc] initWithTitle:@"Disconnect" actionBlock:self.oauthActionBlock]
    ];


    TASetting *portSetting = [[TATextFieldSetting alloc] initWithTitle:@"Port" placeholderValue:@"993" secure:NO keyboardType:UIKeyboardTypeNamePhonePad];
    portSetting.validator = [[TANumberValidator alloc] init];

    TASetting *incomingSection = [TASetting settingWithSettingType:TASettingTypeGroup localizedTitle:@"Incoming"];
    incomingSection.settings = @[
            [TATextFieldSetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"User Name"],
            [[TATextFieldSetting alloc] initWithTitle:@"Password" placeholderValue:nil secure:YES keyboardType:UIKeyboardTypeAlphabet],
            [[TATextFieldSetting alloc] initWithTitle:@"Host" placeholderValue:@"imap.google.com" secure:NO keyboardType:UIKeyboardTypeAlphabet],
            portSetting,
            [TAMultiValueSetting settingWithTitle:@"SSL" values:sslValues],
    ];

    TASetting *outgoingSection = [TASetting settingWithSettingType:TASettingTypeGroup localizedTitle:@"Outgoing"];
    outgoingSection.settings = @[
            [TATextFieldSetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"User Name"],
            [[TATextFieldSetting alloc] initWithTitle:@"Password" placeholderValue:nil secure:YES keyboardType:UIKeyboardTypeAlphabet],
            [[TATextFieldSetting alloc] initWithTitle:@"Host" placeholderValue:@"smtp.google.com" secure:NO keyboardType:UIKeyboardTypeAlphabet],
            [[TATextFieldSetting alloc] initWithTitle:@"Port" placeholderValue:@"587" secure:NO keyboardType:UIKeyboardTypeNamePhonePad],
            [TAMultiValueSetting settingWithTitle:@"SSL" values:sslValues],
    ];


    TASetting *deleteSection = [TASetting settingWithSettingType:TASettingTypeGroup];
    deleteSection.footerText = @"";
    deleteSection.settings = @[
            [[TAActionSetting alloc] initWithTitle:@"Delete Account" actionBlock:self.deleteActionBlock]
    ];

    TASetting *childSection = [TASetting settingWithSettingType:TASettingTypeGroup];
    childSection.settings = @[ settings ];


    settings.settings = @[ generalSection, oauthSection, incomingSection, outgoingSection, deleteSection ];

    return settings;
}

- (TAActionSettingBlock)oauthActionBlock
{
    return ^(TASetting *setting) {
        setting.title = [setting.title isEqualToString:@"Connect"] ? @"Disconnect" : @"Connect";
    };

}

- (TAActionSettingBlock)deleteActionBlock
{
    return ^(TASetting *setting) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Account" message:@"Are you sure you want to continue? All account information will be deleted." preferredStyle:UIAlertControllerStyleActionSheet];

        [alertController addAction:[UIAlertAction actionWithTitle:@"Delete Account" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"action %@", action.title);
        }]];

        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"action %@", action.title);
        }]];

        [self.settingViewController presentViewController:alertController animated:YES completion:nil];


        NSLog(@"%s", sel_getName(_cmd));
    };

}

#pragma mark - TASettingViewControllerDelegate

- (void)settingViewController:(TASettingViewController *)controller didChangeSetting:(TASetting *)setting
{
    NSLog(@"Setting value changed: %@", setting);
}

- (void)settingViewController:(TASettingViewController *)controller didRequestSaveSettings:(TASetting *)setting
{
    NSLog(@"%s", sel_getName(_cmd));
    self.settingViewController = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)settingViewController:(TASettingViewController *)controller didSelectValue:(TASettingValue *)settingValue inSettings:(TAMultiValueSetting *)setting
{
    NSLog(@"%s %@", sel_getName(_cmd), settingValue.title);
    // deselect the previously selected
    [setting.values enumerateObjectsUsingBlock:^(TASettingValue *currentSettingValue, NSUInteger idx, BOOL *stop) {
        if (currentSettingValue != settingValue && [currentSettingValue.value boolValue]) {
            currentSettingValue.value = @NO;
        }
    }];
}


@end
