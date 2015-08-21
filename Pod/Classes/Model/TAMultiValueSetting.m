//
// Created by Jan on 20/08/15.
//

#import "TAMultiValueSetting.h"
#import "TASettingValue.h"


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

#pragma mark - Accessors

- (NSString *)selectedSubtitle
{
    __block NSString *subtitle = @"";
    [self.values enumerateObjectsUsingBlock:^(TASettingValue * obj, NSUInteger idx, BOOL *stop) {

        if([obj.value boolValue]) {
            subtitle = [subtitle stringByAppendingString:[NSString stringWithFormat:@"%@%@", subtitle.length == 0 ? @"" : @",", obj.title]];
        }
    }];
    return subtitle;
}


@end