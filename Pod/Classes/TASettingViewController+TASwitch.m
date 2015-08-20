//
// Created by Jan on 20/08/15.
//

#import "TASettingViewController+TASwitch.h"
#import "TASwitchCell.h"
#import "TASettingValue.h"
#import "TASettingViewController+Delegates.h"


@implementation TASettingViewController (TASwitch)

- (void)configureSwitchCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting
{
    NSAssert([tableViewCell isKindOfClass:[TASwitchCell class]], @"Must be a %@ class", NSStringFromClass([TASwitchCell class]));
    TASwitchCell *cell = (TASwitchCell *) tableViewCell;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.titleLabel.text = setting.localizedTitle;
    cell.valueSwitch.on = setting.settingValue.value != nil ? [setting.settingValue.value boolValue] : [setting.settingValue.defaultValue boolValue];

    [cell.valueSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Switch Changes

- (void)switchValueChanged:(UISwitch *)sender
{
    UITableViewCell *cell = (UITableViewCell *) sender.superview.superview; // context view then cell
    [self handleChangedValue:@(sender.on) inCell:cell];
}
@end