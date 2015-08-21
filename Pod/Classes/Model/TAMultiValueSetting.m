//
// Created by Jan on 20/08/15.
//

#import "TAMultiValueSetting.h"


@implementation TAMultiValueSetting {

}
- (instancetype)initWithTitle:(NSString *)title values:(NSArray *)values
{
    self = [super initWithSettingType:TASettingTypeMultiValue localizedTitle:title];
    if (self) {
        self.values = values;
    }

    return self;
}

+ (instancetype)settingWithTitle:(NSString *)title values:(NSArray *)values
{
    return [[self alloc] initWithTitle:title values:values];
}

@end