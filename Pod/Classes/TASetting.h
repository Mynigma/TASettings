//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>

@class TASettingValue;

typedef NS_ENUM(NSUInteger , TASettingType) {
    TASettingTypeGroup,
    TASettingTypeChild,
    TASettingTypeTextField,
    TASettingTypeSwitch,
    TASettingTypeMultiValue,
};

@interface TASetting : NSObject

@property (nonatomic, assign) TASettingType settingType;
@property (nonatomic, copy) NSString *localizedTitle;
@property (nonatomic, copy) NSString *localizedFooterText;

@property (nonatomic, strong) TASettingValue *settingValue;

- (instancetype)initWithSettingType:(TASettingType)settingType localizedTitle:(NSString *)localizedTitle;

#pragma mark - Factory Methods

+ (instancetype)settingWithSettingType:(TASettingType)settingType localizedTitle:(NSString *)localizedTitle;

+ (instancetype)switchSettingWithTitle:(NSString *)title settingValue:(TASettingValue *) settingValue;


@end