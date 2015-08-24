//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>

@class TASetting;


@interface TASettingValue : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) id defaultValue;
@property (nonatomic, weak) TASetting *parent;

- (instancetype)initWithTitle:(NSString *)title value:(id)value defaultValue:(id)defaultValue;

#pragma mark - Factory Methods

+ (instancetype)valueWithValue:(id)value;

+ (instancetype)valueWithValue:(id)value defaultValue:(id)defaultValue;

- (instancetype)initWithTitle:(NSString *)title value:(id)value;

+ (instancetype)valueWithTitle:(NSString *)title value:(id)value;


@end