//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>
#import "TASetting.h"


@interface TATextFieldSetting : TASetting

@property (nonatomic, assign) BOOL secure;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, copy) NSString *placeholder;

- (instancetype)initWithTitle:(NSString *)title placeholderValue:(NSString *)placeholderValue secure:(BOOL)secure keyboardType:(UIKeyboardType)keyboardType;




@end