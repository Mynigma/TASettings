//
// Created by Jan on 05/09/15.
// Copyright (c) 2015 Jan Chaloupecky. All rights reserved.
//

#import "TADateTransformer.h"


@interface TADateTransformer ()
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation TADateTransformer {

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.timeStyle = NSDateFormatterNoStyle;
        _dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    }

    return self;
}


+ (BOOL)allowsReverseTransformation
{
    return YES;
}

+ (Class)transformedValueClass
{
    return [NSString class];
}

- (id)transformedValue:(id)value
{

    return  [self.dateFormatter stringFromDate:value];
}

- (id)reverseTransformedValue:(id)value
{
    NSDate *date = [self.dateFormatter dateFromString:value];
    return date;
}


@end