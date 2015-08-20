//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>
#import "TASetting.h"


@interface TAMultiValueSetting : TASetting

@property (nonatomic, strong) NSArray *values;  // TASettingValue

- (instancetype)initWithValues:(NSArray *)values;
+ (instancetype)settingWithValues:(NSArray *)values;


@end