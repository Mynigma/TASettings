//
// Created by Jan on 20/08/15.
//

#import "TASettingViewController+Delegates.h"
#import "TASettingValue.h"


@implementation TASettingViewController (Delegates)

- (void)handleChangedValue:(id)value inCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

    TASetting *setting = [self settingForIndexPath:indexPath];

    // todo call delegate for validation
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