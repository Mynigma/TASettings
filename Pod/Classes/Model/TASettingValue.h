//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>

@class TASetting;


@interface TASettingValue : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) id value;  // TODO, use NSValueTransformer to conver to/from from human readable and model values
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) id defaultValue;
@property (nonatomic, weak) TASetting *parent;

@property(nonatomic, copy) NSString *valueTransformerName;
@property(nonatomic, readonly) NSString *transformedValue;

- (instancetype)initWithTitle:(NSString *)title value:(id)value defaultValue:(id)defaultValue;

#pragma mark - Factory Methods

+ (instancetype)valueWithValue:(id)value;

+ (instancetype)valueWithValue:(id)value defaultValue:(id)defaultValue;

- (instancetype)initWithTitle:(NSString *)title value:(id)value;

+ (instancetype)valueWithTitle:(NSString *)title value:(id)value;


- (void)setValueWithTransform:(id)value;


@end