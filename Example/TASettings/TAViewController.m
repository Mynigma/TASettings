//
//  TAViewController.m
//  TASetting
//
//  Created by Jan Chaloupecky on 08/20/2015.
//  Copyright (c) 2015 Jan Chaloupecky. All rights reserved.
//

#import "TAViewController.h"
#import "TADateTransformer.h"
#import "TAActionSetting.h"

#import <TASettings/TASettings.h>


@interface TAViewController () <TASettingViewControllerDelegate>

@property(nonatomic, strong) TASettingViewController *settingViewController;
@property(nonatomic, strong) TASetting *incomingPassword;
@property(nonatomic, strong) TATextFieldSetting *incomingHost;
@property(nonatomic, strong) TASetting *outgoingPassword;
@property(nonatomic, strong) TATextFieldSetting *outgoingHost;

@property(nonatomic) BOOL oauthConnected;
@property(nonatomic, strong) TASetting *incomingSection;
@property(nonatomic, strong) TASetting *outgoingSection;
@end

@implementation TAViewController


#pragma mark - Actions

- (IBAction)showSettings:(id)sender
{

    self.settingViewController = [[TASettingViewController alloc] initWithSettings:[self settings]];

    self.settingViewController.delegate = self;
    self.settingViewController.showDoneButton = YES;
    self.settingViewController.showCancelButton = YES;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.settingViewController];


    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Helper

- (TASetting *)settings
{
    TASetting *settings = [[TASetting alloc] initWithSettingType:TASettingTypeChild title:@"Account Setting"];


    NSArray *sslValues = @[
            [TASettingValue valueWithTitle:@"Auto" value:@1 selected:NO],
            [TASettingValue valueWithTitle:@"Clear" value:@2 selected:NO],
            [TASettingValue valueWithTitle:@"START TLS" value:@3 selected:YES],
            [TASettingValue valueWithTitle:@"SSL" value:@4 selected:NO] ];


    // General Section
    TASetting *generalSection = [TASetting settingWithSettingType:TASettingTypeGroup localizedTitle:@"General"];

    TASetting *settingGeneralAccountName = [[TATextFieldSetting alloc] initWithTitle:@"Account Name" placeholderValue:@"Gmail" secure:NO keyboardType:UIKeyboardTypeAlphabet];
    settingGeneralAccountName.settingValue.value = @"Steve Jobs";
    generalSection.children = @[
            settingGeneralAccountName,
            [[TATextFieldSetting alloc] initWithTitle:@"Sender Name" placeholderValue:@"John Doe" secure:NO keyboardType:UIKeyboardTypeAlphabet],
            [TASetting switchSettingWithTitle:@"Copy to sent messages" settingValue:[TASettingValue valueWithValue:nil defaultValue:@YES]],
    ];


    // Oauth Section
    TASetting *oauthSection = [TASetting settingWithSettingType:TASettingTypeGroup localizedTitle:@"OAuth"];
    oauthSection.footerText = @"";
    oauthSection.children = @[
            [[TAActionSetting alloc] initWithTitle:@"Connect" actionBlock:self.oauthActionBlock style:TAActionSettingStyleDefault]
    ];
    self.oauthConnected = NO;


    TASetting *portSetting = [[TATextFieldSetting alloc] initWithTitle:@"Port" placeholderValue:@"993" secure:NO keyboardType:UIKeyboardTypeNamePhonePad];
    portSetting.validator = [[TANumberValidator alloc] init];

    // Incoming section

    self.incomingSection = [TASetting settingWithSettingType:TASettingTypeGroup localizedTitle:@"Incoming"];

    TASetting *dateSetting = [[TATextFieldSetting alloc] initWithTitle:@"Date" placeholderValue:nil secure:NO keyboardType:UIKeyboardTypeAlphabet];
    dateSetting.settingValue.value = [NSDate date];

    [NSValueTransformer setValueTransformer:[[TADateTransformer alloc] init] forName:@"TADateTransformer"];
    dateSetting.settingValue.valueTransformerName = @"TADateTransformer";


    self.incomingPassword = [[TATextFieldSetting alloc] initWithTitle:@"Password" placeholderValue:nil secure:NO keyboardType:UIKeyboardTypeAlphabet];
    self.incomingHost = [[TATextFieldSetting alloc] initWithTitle:@"Host" placeholderValue:@"imap.google.com" secure:NO keyboardType:UIKeyboardTypeAlphabet];

    NSArray *incomingSettings = [@[
            [TATextFieldSetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"User Name"],
            self.incomingPassword,
            self.incomingHost,
            portSetting,
            dateSetting,
            [TAMultiValueSetting settingWithTitle:@"SSL" values:sslValues],
    ] mutableCopy];


    self.incomingSection.children = incomingSettings;

    // Outgoing Section

    self.outgoingPassword = [[TATextFieldSetting alloc] initWithTitle:@"Password" placeholderValue:nil secure:NO keyboardType:UIKeyboardTypeAlphabet];
    self.outgoingHost = [[TATextFieldSetting alloc] initWithTitle:@"Host" placeholderValue:@"smtp.google.com" secure:NO keyboardType:UIKeyboardTypeAlphabet];

    self.outgoingSection = [TASetting settingWithSettingType:TASettingTypeGroup localizedTitle:@"Outgoing"];
    self.outgoingSection.children = @[
            [TATextFieldSetting settingWithSettingType:TASettingTypeTextField localizedTitle:@"User Name"],
            self.outgoingPassword,
            self.outgoingHost,
            [[TATextFieldSetting alloc] initWithTitle:@"Port" placeholderValue:@"587" secure:NO keyboardType:UIKeyboardTypeNamePhonePad],
            [TAMultiValueSetting settingWithTitle:@"SSL" values:sslValues],
    ];


    TASetting *deleteSection = [TASetting settingWithSettingType:TASettingTypeGroup];
    deleteSection.children = @[
            [[TAActionSetting alloc] initWithTitle:@"Delete Account" actionBlock:self.deleteActionBlock style:TAActionSettingStyleDestructive]
    ];

    TASetting *childSection = [TASetting settingWithSettingType:TASettingTypeGroup];
    childSection.children = @[ settings ];


    TASetting *signatureSection = [TASetting settingWithSettingType:TASettingTypeGroup localizedTitle:@"Signature"];
    TASetting *signatureSetting =[[TASetting alloc] initWithSettingType:TASettingTypeTextView title:nil];
    signatureSetting.settingValue.value = @"--\nSent with Mynigma";
    signatureSection.children = @[
            signatureSetting
    ];

    settings.children = @[generalSection, oauthSection, self.incomingSection, self.outgoingSection, signatureSection, deleteSection ];

    return settings;
}

- (TAActionSettingBlock)oauthActionBlock
{
    return ^(TASettingViewController *controller, TASetting *setting) {

        self.oauthConnected = !self.oauthConnected;

        if(self.oauthConnected) {
            [self.incomingSection removeSetting:self.incomingPassword];
            [self.incomingSection removeSetting:self.incomingHost];

            [self.outgoingSection removeSetting:self.outgoingPassword];
            [self.outgoingSection removeSetting:self.outgoingHost];
        } else {
            [self.incomingSection insertSetting:self.incomingPassword atIndex:1];
            [self.incomingSection insertSetting:self.incomingHost atIndex:2];

            [self.outgoingSection insertSetting:self.outgoingPassword atIndex:1];
            [self.outgoingSection insertSetting:self.outgoingHost atIndex:2];
        }

        setting.title = self.oauthConnected ? @"Disconnect" : @"Connect";
    };

}

- (TAActionSettingBlock)deleteActionBlock
{
    return ^(TASettingViewController *controller, TASetting *setting) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Account" message:@"Are you sure you want to continue? All account information will be deleted." preferredStyle:UIAlertControllerStyleActionSheet];

        [alertController addAction:[UIAlertAction actionWithTitle:@"Delete Account" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"action %@", action.title);
        }]];

        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"action %@", action.title);
        }]];

        [controller presentViewController:alertController animated:YES completion:nil];
    };

}

#pragma mark - TASettingViewControllerDelegate

- (void)settingViewController:(TASettingViewController *)controller didChangeSetting:(TASetting *)setting
{

    NSLog(@"Setting value changed: %@", setting);

    [self reusePasswordIfNecessaryForSetting:setting];

}

#pragma mark - Private

- (void)reusePasswordIfNecessaryForSetting:(TASetting *)setting
{
    if ([self shouldAskForPasswordReuse:setting]) {

        NSString *message = [NSString stringWithFormat:@"Use the same password for %@?", setting == self.incomingPassword ? @"outgoing" : @"icoming"];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Reuse password?" message:message preferredStyle:UIAlertControllerStyleAlert];


        [alertController addAction:[UIAlertAction actionWithTitle:@"No thanks" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

        }]];

        [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            if (setting == self.outgoingPassword) {
                self.incomingPassword.settingValue.value = setting.settingValue.value;
            }

            if (setting == self.incomingPassword) {
                self.outgoingPassword.settingValue.value = setting.settingValue.value;
            }

        }]];

        [self.settingViewController presentViewController:alertController animated:YES completion:nil];
    }
}

- (BOOL)shouldAskForPasswordReuse:(TASetting *)setting
{
    TASetting *otherPasswordSetting = setting == self.incomingPassword ? self.outgoingPassword : self.incomingPassword;
    return (setting == self.incomingPassword || setting == self.outgoingPassword) // is a password value
            && setting.settingValue.transformedValue.length > 0 // not empty
            && ![setting.settingValue.transformedValue isEqualToString:otherPasswordSetting.settingValue.transformedValue]; // different from the other password value
}

- (void)settingViewController:(TASettingViewController *)controller didRequestSaveSettings:(TASetting *)setting
{
    NSLog(@"%s", sel_getName(_cmd));
    self.settingViewController = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)settingViewController:(TASettingViewController *)controller willDismissSettings:(TASetting *)setting
{
    self.settingViewController = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)settingViewController:(TASettingViewController *)controller didSelectValue:(TASettingValue *)settingValue inSettings:(TAMultiValueSetting *)setting
{
    NSLog(@"%s %@", sel_getName(_cmd), settingValue.title);
    // deselect the previously selected
    [setting.values enumerateObjectsUsingBlock:^(TASettingValue *currentSettingValue, NSUInteger idx, BOOL *stop) {
        if (currentSettingValue != settingValue && currentSettingValue.selected) {
            currentSettingValue.selected = NO;
        }
    }];

    [controller.navigationController popViewControllerAnimated:YES];
}


@end
