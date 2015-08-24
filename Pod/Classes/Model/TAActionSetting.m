//
// Created by Jan on 24/08/15.
//

#import "TAActionSetting.h"


@implementation TAActionSetting {

}

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    self = [super initWithSettingType:TASettingTypeAction title:title];
    if (self) {
        self.target = target;
        self.action = action;
    }
    return self;
}

@end