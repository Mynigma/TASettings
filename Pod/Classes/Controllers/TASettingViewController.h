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

/**
 *  Called when the user changes a setting. For text fields, it's when the editing ends.
 *
 *  @param controller The setting view controller
 *  @param setting    The setting that was changed
 */
- (void)settingViewController:(TASettingViewController *)controller didChangeSetting:(TASetting *)setting;

/**
 *  Called when the user selects a value in the multi-value setting.
 *
 *  @param controller   The setting view controler
 *  @param settingValue The value that the user tapped on. Its selected value is set to YES
 *  @param setting      The multi-value setting the value belongs to
 */
- (void)settingViewController:(TASettingViewController *)controller didSelectValue:(TASettingValue *)settingValue inSettings:(TAMultiValueSetting *)setting;

#pragma mark - Saving

/**
 *  Called when the setting view controller will be dismissed. This happens when
 *  - the user pops a child setting view controller
 *  - the user cancels the root setting view controller
 *
 *  @param controller The setting view controller
 *  @param setting    The main setting object associated to this view controller
 */
- (void)settingViewController:(TASettingViewController *)controller willDismissSettings:(TASetting *)setting;

/**
 *  Called when the user taps on the save button of the setting view controller
 *
 *  @param controller The setting view controller
 *  @param setting    The main setting object associated to this view controller
 */
- (void)settingViewController:(TASettingViewController *)controller didRequestSaveSettings:(TASetting *)setting;

@end


@interface TASettingViewController : UIViewController

// If YES, a Done button will be put in the right bar menu item
@property(nonatomic, assign) BOOL showDoneButton;

// If YES, a Cancel button will be put in the left bar menu item
@property(nonatomic, assign) BOOL showCancelButton;

// A fixed background image shown behind the table view, if non-nil
@property UIImage* backgroundImage;

// The colour of the section headers
@property UIColor* sectionHeaderTint;

@property(nonatomic, strong, readonly) TASetting *settings;
@property(nonatomic, strong) UITableView *tableView;


@property(nonatomic, weak) id <TASettingViewControllerDelegate> delegate;

- (instancetype)initWithSettings:(TASetting * )settings NS_DESIGNATED_INITIALIZER;



- (TASetting *)settingForIndexPath:(NSIndexPath *)indexPath;

@end