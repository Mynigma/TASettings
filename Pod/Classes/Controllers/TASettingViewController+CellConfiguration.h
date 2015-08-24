//
// Created by Jan on 24/08/15.
//

#import <Foundation/Foundation.h>
#import "TASettingViewController.h"

@interface TASettingViewController (CellConfiguration) <UITextFieldDelegate>

- (void)configureSwitchCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting;
- (void)configureTextFieldCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting;
- (void)configureMultiValueCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting;
- (void)configureChildCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting;
- (void)configureActionCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting;

@end