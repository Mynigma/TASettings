//
// Created by Jan on 20/08/15.
//

#import "TATextFieldSetting.h"


@implementation TATextFieldSetting {

}
- (instancetype)initWithTitle:(NSString *)title placeholderValue:(NSString *)placeholderValue secure:(BOOL)secure keyboardType:(UIKeyboardType)keyboardType
{
    self = [super initWithSettingType:TASettingTypeTextField title:title];
    if (self) {
        self.secure = secure;
        self.keyboardType = keyboardType;
        self.placeholder = placeholderValue;
    }

    return self;
}



@end