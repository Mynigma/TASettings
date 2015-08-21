//
// Created by Jan on 20/08/15.
//

#import "TASetting.h"
#import "TASettingValue.h"


@implementation TASetting {

}
- (instancetype)initWithSettingType:(TASettingType)settingType localizedTitle:(NSString *)localizedTitle
{
    self = [super init];
    if (self) {
        self.settingType = settingType;
        self.localizedTitle = localizedTitle;
    }

    return self;
}

#pragma mark - Factory Methods

+ (instancetype)settingWithSettingType:(TASettingType)settingType localizedTitle:(NSString *)localizedTitle
{
    return [[self alloc] initWithSettingType:settingType localizedTitle:localizedTitle];
}

+ (instancetype)switchSettingWithTitle:(NSString *)title settingValue:(TASettingValue *) settingValue
{
    TASetting *setting = [[self alloc] initWithSettingType:TASettingTypeSwitch localizedTitle:title];
    setting.settingValue = settingValue;

    return setting;
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"%@", self.localizedTitle];
    [description appendString:@">"];
    return description;
}


@end