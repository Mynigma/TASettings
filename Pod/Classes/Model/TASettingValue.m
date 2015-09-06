//
// Created by Jan on 20/08/15.
//

#import "TASettingValue.h"
#import "TASetting.h"


@implementation TASettingValue {

}


- (instancetype)initWithTitle:(NSString *)title value:(id)value selected:(BOOL)selected defaultValue:(id)defaultValue
{
    self = [super init];
    if (self) {
        self.title = title;
        self.value = value;
        self.selected = selected;
        self.defaultValue = defaultValue;
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title value:(id)value selected:(BOOL)selected
{
    self = [self initWithTitle:title value:value selected:selected defaultValue:nil];
    return self;
}

+ (instancetype)valueWithTitle:(NSString *)title value:(id)value selected:(BOOL)selected
{
    return [[self alloc] initWithTitle:title value:value selected:selected];
}


- (instancetype)initWithTitle:(NSString *)title value:(id)value
{
    self = [self initWithTitle:title value:value selected:NO defaultValue:nil];
    return self;
}

+ (instancetype)valueWithTitle:(NSString *)title value:(id)value
{
    return [[self alloc] initWithTitle:title value:value];
}


- (instancetype)initWithValue:(id)value defaultValue:(id)defaultValue
{
    self = [self initWithTitle:nil value:value selected:NO defaultValue:defaultValue];
    return self;
}


+ (instancetype)valueWithValue:(id)value defaultValue:(id)defaultValue
{
    return [[self alloc] initWithValue:value defaultValue:defaultValue];
}


#pragma mark - Accessors

- (NSString *)transformedValue
{
    NSString *value = self.value;
    if(self.valueTransformerName) {
        NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:self.valueTransformerName];
        value = [transformer transformedValue:self.value];
    }
    return value;
}

- (void)setValueWithTransform:(id)value
{
    if (self.valueTransformerName) {
        NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:self.valueTransformerName];
        value = [transformer reverseTransformedValue:value];
    }
    self.value = value;
}


@end