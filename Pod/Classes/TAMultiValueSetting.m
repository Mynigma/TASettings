//
// Created by Jan on 20/08/15.
//

#import "TAMultiValueSetting.h"


@implementation TAMultiValueSetting {

}
- (instancetype)initWithValues:(NSArray *)values
{
    self = [super init];
    if (self) {
        self.values = values;
    }

    return self;
}

+ (instancetype)settingWithValues:(NSArray *)values
{
    return [[self alloc] initWithValues:values];
}

@end