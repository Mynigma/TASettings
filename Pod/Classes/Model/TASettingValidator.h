//
// Created by Jan on 24/08/15.
//

#import <Foundation/Foundation.h>

@class TASetting;

@protocol TASettingValidator <NSObject>

- (BOOL)validateValue:(id)value forSetting:(TASetting *)setting error:(NSError **)error;

@end