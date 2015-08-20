//
// Created by Jan on 20/08/15.
//

#import "TASettingValue.h"


@implementation TASettingValue {

}
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
    }

    return self;
}

+ (instancetype)valueWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}

@end