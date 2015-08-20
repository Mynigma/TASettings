//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger , TASettingType) {
    TASettingTypeGroup,
    TASettingTypeChild,
    TASettingTypeTextField,
};

@interface TASetting : NSObject

@property (nonatomic, assign) TASettingType settingType;
@property (nonatomic, copy) NSString *localizedTitle;
@property (nonatomic, copy) NSString *localizedFooterText;

- (instancetype)initWithSettingType:(TASettingType)settingType localizedTitle:(NSString *)localizedTitle;

+ (instancetype)settingWithSettingType:(TASettingType)settingType localizedTitle:(NSString *)localizedTitle;


@end