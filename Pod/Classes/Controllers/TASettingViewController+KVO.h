//
// Created by Jan on 08/09/15.
//

#import <Foundation/Foundation.h>
#import <TASettings/TASettingViewController.h>

@interface TASettingViewController (KVO)

/**
 *  Start observing recursively the changes in the settings.
 *  The properties of leaf settings
 *  The children (addition, removal) of node settings
 *
 *  @param settings The settings to be observed
 */
- (void)startObservingSettings:(TASetting *)settings;

/**
 *  Stop observing recursively all settings
 *
 *  @param settings The settings
 */
- (void)stopObservingSettings:(TASetting *)settings;
@end