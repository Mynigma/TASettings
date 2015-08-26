//
// Created by Jan on 24/08/15.
//

#import <Foundation/Foundation.h>
#import "TASetting.h"

@class TASettingViewController;


typedef void(^TAActionSettingBlock)(TASettingViewController *settingViewController, TASetting * setting);

@interface TAActionSetting : TASetting

@property (nonatomic, copy) TAActionSettingBlock actionBlock;


- (instancetype)initWithTitle:(NSString *)title actionBlock:(TAActionSettingBlock)actionBlock NS_DESIGNATED_INITIALIZER;

@end