//
// Created by Jan on 20/08/15.
//

#import <UIKit/UIKit.h>

@class TASettingViewController;
@class TASettingValue;
@class TAMultiValueSetting;
@class TASetting;


@protocol TASettingViewControllerDelegate <NSObject>

@optional

#pragma mark - Value Changes

- (void)settingViewController:(TASettingViewController *)controller didChangeSetting:(TASetting *)setting;
- (void)settingViewController:(TASettingViewController *)controller didSelectValue:(TASettingValue *)settingValue inSettings:(TAMultiValueSetting *)setting;

#pragma mark - Saving

- (void)settingViewController:(TASettingViewController *)controller willDismissSettings:(TASetting *)setting;

- (void)settingViewController:(TASettingViewController *)controller didRequestSaveSettings:(TASetting *)setting;

@end


@interface TASettingViewController : UIViewController

@property(nonatomic, assign) BOOL showDoneButton;
@property(nonatomic, strong, readonly) TASetting *settings;
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, weak) id <TASettingViewControllerDelegate> delegate;

- (instancetype)initWithSettings:(TASetting * )settings NS_DESIGNATED_INITIALIZER;



- (TASetting *)settingForIndexPath:(NSIndexPath *)indexPath;

@end