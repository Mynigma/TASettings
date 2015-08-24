//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>
#import "TASettings.h"

@class TASettingViewController;
@class TASettingValue;


@protocol TASettingViewControllerDelegate <NSObject>

@optional
- (void)settingViewController:(TASettingViewController *)controller didChangeSetting:(TASetting *)setting;
- (void)settingViewController:(TASettingViewController *)controller willDismissSetting:(TASetting *)setting;
- (void)settingViewController:(TASettingViewController *)controller didRequestSaveSettings:(TASetting *)setting;

@end


@interface TASettingViewController : UIViewController

@property(nonatomic, assign) BOOL showDoneButton;
@property(nonatomic, strong) TASettings *settings;
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) id <TASettingViewControllerDelegate> delegate;


- (TASetting *)settingForIndexPath:(NSIndexPath *)indexPath;

@end