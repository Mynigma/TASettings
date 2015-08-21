//
// Created by Jan on 20/08/15.
//

#import "TASettingValue.h"


@implementation TASettingValue {

}

- (instancetype)initWithTitle:(NSString *)title value:(id)value defaultValue:(id)defaultValue
{
    self = [super init];
    if (self) {
        self.title = title;
        self.value = value;
        self.defaultValue = defaultValue;
    }

    return self;
}

+ (instancetype)valueWithTitle:(NSString *)title value:(id)value defaultValue:(id)defaultValue
{
    return [[self alloc] initWithTitle:title value:value defaultValue:defaultValue];
}

- (instancetype)initWithValue:(id)value
{
    self = [super init];
    if (self) {
        self.value = value;
    }

    return self;
}

- (instancetype)initWithValue:(id)value defaultValue:(id)defaultValue
{
    self = [super init];
    if (self) {
        self.value = value;
        self.defaultValue = defaultValue;
    }

    return self;
}

+ (instancetype)valueWithValue:(id)value defaultValue:(id)defaultValue
{
    return [[self alloc] initWithValue:value defaultValue:defaultValue];
}


+ (instancetype)valueWithValue:(id)value
{
    return [[self alloc] initWithValue:value];
}


@end