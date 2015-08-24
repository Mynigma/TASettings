//
// Created by Jan on 20/08/15.
//

#import "TASettingViewController+Delegates.h"
#import "TASettingValue.h"
#import "TASettingValidator.h"


@implementation TASettingViewController (Delegates)

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