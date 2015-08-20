//
// Created by Jan on 20/08/15.
//

#import "TASetting.h"


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

+ (instancetype)settingWithSettingType:(TASettingType)settingType localizedTitle:(NSString *)localizedTitle
{
    return [[self alloc] initWithSettingType:settingType localizedTitle:localizedTitle];
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"%@", self.localizedTitle];
    [description appendString:@">"];
    return description;
}


@end