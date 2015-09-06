//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>

@class TASetting;


@interface TASettingValue : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) id value;
@property(nonatomic, assign) BOOL selected;
@property(nonatomic, strong) id defaultValue;
@property(nonatomic, weak) TASetting *parent;

@property(nonatomic, copy) NSString *valueTransformerName;
@property(nonatomic, readonly) NSString *transformedValue;

- (instancetype)initWithTitle:(NSString *)title value:(id)value selected:(BOOL)selected defaultValue:(id)defaultValue NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithValue:(id)value defaultValue:(id)defaultValue;

- (instancetype)initWithTitle:(NSString *)title value:(id)value;

- (instancetype)initWithTitle:(NSString *)title value:(id)value selected:(BOOL)selected;


#pragma mark - Factory Methods

+ (instancetype)valueWithValue:(id)value defaultValue:(id)defaultValue;

+ (instancetype)valueWithTitle:(NSString *)title value:(id)value;

+ (instancetype)valueWithTitle:(NSString *)title value:(id)value selected:(BOOL)selected;


- (void)setValueWithTransform:(id)value;


@end