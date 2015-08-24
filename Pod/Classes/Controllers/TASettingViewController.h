//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>
#import "TASettings.h"

@class TASettingViewController;
@class TASettingValue;
@class TAMultiValueSetting;


@protocol TASettingViewControllerDelegate <NSObject>

@optional

#pragma mark - Value Changes

- (void)settingViewController:(TASettingViewController *)controller didChangeSetting:(TASetting *)setting;
- (void)settingViewController:(TASettingViewController *)controller didSelectValue:(TASettingValue *)settingValue inSettings:(TAMultiValueSetting *)setting;

#pragma mark - Saving

- (void)settingViewController:(TASettingViewController *)controller willDismissSettings:(TASettings *)setting;

- (void)settingViewController:(TASettingViewController *)controller didRequestSaveSettings:(TASettings *)setting;

@end


@interface TASettingViewController : UIViewController

@property(nonatomic, assign) BOOL showDoneButton;
@property(nonatomic, strong, readonly) TASettings *settings;
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) id <TASettingViewControllerDelegate> delegate;

- (instancetype)initWithSettings:(TASettings *)settings NS_DESIGNATED_INITIALIZER;



- (TASetting *)settingForIndexPath:(NSIndexPath *)indexPath;

@end