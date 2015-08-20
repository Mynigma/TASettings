//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>
#import "TASettings.h"


@interface TASettingViewController : UIViewController

@property(nonatomic, assign) BOOL showDoneButton;

@property(nonatomic, strong) TASettings *settings;

@property(nonatomic, strong) UITableView *tableView;


- (TASetting *)settingForIndexPath:(NSIndexPath *)indexPath;

@end