//
// Created by Jan on 24/08/15.
//

#import "TASettingViewController+CellConfiguration.h"
#import "TASettingValue.h"
#import "TASwitchCell.h"
#import "TATextFieldSetting.h"
#import "TATextFieldCell.h"
#import "TAMultiValueSetting.h"
#import "TADetailValueCell.h"
#import "TASettingValidator.h"
#import "TAActionCell.h"
#import "TAActionSetting.h"


@implementation TASettingViewController (CellConfiguration)

- (void)configureSwitchCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting
{
    NSAssert([tableViewCell isKindOfClass:[TASwitchCell class]], @"Must be a %@ class", NSStringFromClass([TASwitchCell class]));
    TASwitchCell *cell = (TASwitchCell *) tableViewCell;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.titleLabel.text = setting.title;
    cell.valueSwitch.on = setting.settingValue.value != nil ? [setting.settingValue.value boolValue] : [setting.settingValue.defaultValue boolValue];

    [cell.valueSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)configureTextFieldCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting
{
    NSAssert([tableViewCell isKindOfClass:[TATextFieldCell class]], @"Must be a %@ class", NSStringFromClass([TATextFieldCell class]));
    TATextFieldCell *cell = (TATextFieldCell *) tableViewCell;
    TATextFieldSetting *textSetting = (TATextFieldSetting *) setting;


    cell.titleLabel.text = textSetting.title;
    cell.valueTextField.text = textSetting.settingValue.value;
    cell.valueTextField.placeholder = textSetting.placeholder;
    cell.valueTextField.keyboardType = textSetting.keyboardType;
    cell.valueTextField.secureTextEntry = textSetting.secure;

    cell.valueTextField.delegate = self;
}

- (void)configureMultiValueCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting
{
    NSAssert([tableViewCell isKindOfClass:[TADetailValueCell class]], @"Must be a %@ class", NSStringFromClass([TADetailValueCell class]));
    TADetailValueCell *cell = (TADetailValueCell *) tableViewCell;

    TAMultiValueSetting *multiValueSetting = (TAMultiValueSetting *) setting;
    cell.titleLabel.text = setting.title;
    cell.subtitleLabel.text = multiValueSetting.selectedSubtitle;

}

- (void)configureChildCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting
{
    NSAssert([tableViewCell isKindOfClass:[TADetailValueCell class]], @"Must be a %@ class", NSStringFromClass([TADetailValueCell class]));
    TADetailValueCell *cell = (TADetailValueCell *) tableViewCell;
    cell.titleLabel.text = setting.title;
    cell.subtitleLabel.text = nil;
}

- (void)configureActionCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting
{
    NSAssert([tableViewCell isKindOfClass:[TAActionCell class]], @"Must be a %@ class", NSStringFromClass([TAActionCell class]));
    TAActionCell *cell = (TAActionCell *) tableViewCell;
    TAActionSetting *actionSetting = (TAActionSetting *) setting;

    [cell.button setTitle:setting.title forState:UIControlStateNormal];
    [cell.button addTarget:self action:@selector(actionCellButtonPressed:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - Switch Changes

- (void)switchValueChanged:(UISwitch *)sender
{
    UITableViewCell *cell = (UITableViewCell *) sender.superview.superview; // context view then cell
    [self handleChangedValue:@(sender.on) inCell:cell];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITableViewCell *cell = textField.superview.superview; // context view then cell
    [self handleChangedValue:textField.text inCell:cell];
}

#pragma mark - Button Action

-(void) actionCellButtonPressed:(UIButton *) button
{
    UITableViewCell *cell = (UITableViewCell *) button.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    TAActionSetting *setting = (TAActionSetting *)[self settingForIndexPath:indexPath];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [setting.target performSelector:setting.action withObject:setting];
#pragma clang diagnostic pop


}

- (void)handleChangedValue:(id)value inCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    TASetting *setting = [self settingForIndexPath:indexPath];

    if ([setting.validator respondsToSelector:@selector(validateValue:forSetting:error:)]) {
        NSError *validationError;
        if (![setting.validator validateValue:value forSetting:setting error:&validationError]) {
            NSLog(@"Validation failed for setting %@: %@", setting, validationError);
            return;
        }
    }

    if (!setting.settingValue) {
        setting.settingValue = [[TASettingValue alloc] init];
    }

    setting.settingValue.value = value;

    id <TASettingViewControllerDelegate> o = self.delegate;
    if ([o respondsToSelector:@selector(settingViewController:didChangeSetting:)]) {
        [o settingViewController:self didChangeSetting:setting];
    }
}

@end