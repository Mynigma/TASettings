//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>
#import "TASettingViewController.h"

@interface TASettingViewController (TATextField) <UITextFieldDelegate>

- (void)configureTextFieldCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting;

@end