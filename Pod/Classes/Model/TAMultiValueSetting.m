//
// Created by Jan on 20/08/15.
//

#import "TAMultiValueSetting.h"
#import "TASettingValue.h"


static void *TAMultiValueSettingContext = &TAMultiValueSettingContext;

@implementation TAMultiValueSetting {

}
- (instancetype)initWithTitle:(NSString *)title values:(NSArray *)values
{
    self = [super initWithSettingType:TASettingTypeMultiValue title:title];
    if (self) {
        self.values = values;
        [self startObservingValues];
    }

    return self;
}

+ (instancetype)settingWithTitle:(NSString *)title values:(NSArray *)values
{
    return [[self alloc] initWithTitle:title values:values];
}

#pragma mark - KVO

- (void)startObservingValues
{
    [self.values enumerateObjectsUsingBlock:^(TASettingValue *settingValue, NSUInteger idx, BOOL *stop) {
        [settingValue addObserver:self forKeyPath:@"selected" options:0 context:TAMultiValueSettingContext];
    }];

}

- (void)stopObservingValues
{
    [self.values enumerateObjectsUsingBlock:^(TASettingValue *settingValue, NSUInteger idx, BOOL *stop) {
        [settingValue removeObserver:self forKeyPath:@"selected" context:TAMultiValueSettingContext];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == TAMultiValueSettingContext) {
        [self createSubtitle];
    }
}


- (void)createSubtitle
{
    __block NSString *subtitle = @"";
    [self.values enumerateObjectsUsingBlock:^(TASettingValue *obj, NSUInteger idx, BOOL *stop) {
        if (obj.selected) {
            subtitle = [subtitle stringByAppendingString:[NSString stringWithFormat:@"%@%@", subtitle.length == 0 ? @"" : @", ", obj.title]];
        }
    }];
    self.subtitle = subtitle;
}

#pragma mark - Accessors

- (void)setValues:(NSArray *)values
{
    _values = values;
    [values enumerateObjectsUsingBlock:^(TASettingValue *settingValue, NSUInteger idx, BOOL *stop) {
        settingValue.parent = self;
    }];

    [self createSubtitle];
}

- (void)dealloc
{
    [self stopObservingValues];
}


@end