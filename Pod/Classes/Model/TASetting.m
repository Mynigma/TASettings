//
// Created by Jan on 20/08/15.
//

#import "TASetting.h"
#import "TASettingValue.h"
#import "TASettingValidator.h"


@implementation TASetting {

}
- (instancetype)initWithSettingType:(TASettingType)settingType title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.settingType = settingType;
        self.title = title;
    }

    return self;
}

#pragma mark - Factory Methods

+ (instancetype)settingWithSettingType:(TASettingType)settingType localizedTitle:(NSString *)localizedTitle
{
    return [[self alloc] initWithSettingType:settingType title:localizedTitle];
}

+ (instancetype)settingWithSettingType:(TASettingType)settingType
{
    return [[self class] settingWithSettingType:settingType localizedTitle:nil];
}

+ (instancetype)switchSettingWithTitle:(NSString *)title settingValue:(TASettingValue *) settingValue
{
    TASetting *setting = [[self alloc] initWithSettingType:TASettingTypeSwitch title:title];
    setting.settingValue = settingValue;

    return setting;
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"%@", self.title];
    [description appendString:@">"];
    return description;
}


@end