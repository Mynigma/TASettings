//
// Created by Jan on 20/08/15.
//

#import "TASetting.h"
#import "TASettingValue.h"
#import "TASettingValidator.h"


@interface TASetting ()
@property(nonatomic, strong, readwrite) TASettingValue *settingValue;
@end

@implementation TASetting {

}
- (instancetype)initWithSettingType:(TASettingType)settingType title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.settingType = settingType;
        self.title = title;
        self.enabled = YES;
    }

    return self;
}

-(instancetype) init
{
    self = [self initWithSettingType:TASettingTypeGroup title:@""];
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

- (TASettingValue *)settingValue
{
    if(!_settingValue) {
        _settingValue = [[TASettingValue alloc] init];
    }
    return _settingValue;
}


- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"%@", self.title];
    [description appendFormat:@"%@", self.settingValue.value];
    [description appendString:@">"];
    return description;
}


@end