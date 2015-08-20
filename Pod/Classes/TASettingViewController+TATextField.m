//
// Created by Jan on 20/08/15.
//

#import "TASettingViewController+TATextField.h"
#import "TATextFieldSetting.h"
#import "TATextFieldCell.h"
#import "TASettingValue.h"


@implementation TASettingViewController (TATextField)

#pragma mark - Cell Configuration

- (void)configureCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting
{
    NSAssert([tableViewCell isKindOfClass:[TATextFieldCell class]], @"Must be a %@ class",NSStringFromClass([TATextFieldCell class]));
    TATextFieldCell *cell = (TATextFieldCell *) tableViewCell;
    TATextFieldSetting *textSetting = (TATextFieldSetting *) setting;

    cell.titleLabel.text = textSetting.localizedTitle;
    cell.valueTextField.text = textSetting.settingValue.value;
    cell.valueTextField.placeholder = textSetting.placeholder;
    cell.valueTextField.keyboardType = textSetting.keyboardType;
    cell.valueTextField.secureTextEntry = textSetting.secure;

    cell.valueTextField.delegate = self;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITableViewCell *cell = textField.superview.superview; // context view then cell
    NSIndexPath *indexPath =  [self.tableView indexPathForCell:cell];
    TASetting *setting = [self settingForIndexPath:indexPath];

    // todo call delegate for validation
    if(!setting.settingValue) {
        setting.settingValue = [[TASettingValue alloc] init];
    }

    setting.settingValue.value = textField.text;

    id <TASettingViewControllerDelegate> o = self.delegate;
    if ([o respondsToSelector:@selector(settingViewController:didChangeSetting:)]) {
        [o settingViewController:self didChangeSetting:setting];
    }

}


@end