//
// Created by Jan on 24/08/15.
//

#import "TAActionSetting.h"
#import "TASettingViewController.h"


@implementation TAActionSetting {

}

- (instancetype)initWithTitle:(NSString *)title actionBlock:(TAActionSettingBlock)actionBlock
{
    self = [super initWithSettingType:TASettingTypeAction title:title];
    if (self) {
        self.actionBlock = actionBlock;
    }
    return self;
}

- (instancetype)initWithSettingType:(TASettingType)settingType title:(NSString *)title
{
    self = [self initWithTitle:title actionBlock:nil];
    return self;
    
}

@end