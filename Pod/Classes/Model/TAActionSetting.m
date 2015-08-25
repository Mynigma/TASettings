//
// Created by Jan on 24/08/15.
//

#import "TAActionSetting.h"


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

@end