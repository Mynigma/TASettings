//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>


@interface TASettingValue : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) id defaultValue;

- (instancetype)initWithTitle:(NSString *)title value:(id)value defaultValue:(id)defaultValue;

#pragma mark - Factory Methods

+ (instancetype)valueWithValue:(id)value;

- (instancetype)initWithValue:(id)value defaultValue:(id)defaultValue;

+ (instancetype)valueWithValue:(id)value defaultValue:(id)defaultValue;


@end