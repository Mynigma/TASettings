//
// Created by Jan on 24/08/15.
//

#import <Foundation/Foundation.h>
#import "TASetting.h"

@class TASettingViewController;

typedef NS_ENUM(NSUInteger , TAActionSettingStyle) {
    TAActionSettingStyleDefault = 0,
    TAActionSettingStyleDestructive
};
typedef void(^TAActionSettingBlock)(TASettingViewController *settingViewController, TASetting * setting);

@interface TAActionSetting : TASetting

@property (nonatomic, copy) TAActionSettingBlock actionBlock;
@property (nonatomic, readonly) TAActionSettingStyle style;


- (instancetype)initWithTitle:(NSString *)title actionBlock:(TAActionSettingBlock)actionBlock style:(TAActionSettingStyle)style;

@end