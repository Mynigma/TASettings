//
// Created by Jan on 24/08/15.
//

#import "TAActionSetting.h"
#import "TASettingViewController.h"

@interface TAActionSetting()

@property (nonatomic, readwrite) TAActionSettingStyle style;

@end

@implementation TAActionSetting {

}

- (instancetype)initWithTitle:(NSString *)title actionBlock:(TAActionSettingBlock)actionBlock style:(TAActionSettingStyle)style
{
    self = [super initWithSettingType:TASettingTypeAction title:title];
    if (self) {
        self.actionBlock = actionBlock;
        self.style = style;

    }
    return self;
}

- (instancetype)initWithSettingType:(TASettingType)settingType title:(NSString *)title
{
    self = [self initWithTitle:title actionBlock:nil style:TAActionSettingStyleDefault];
    return self;
}

@end