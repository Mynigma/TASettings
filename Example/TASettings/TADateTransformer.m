//
// Created by Jan on 05/09/15.
// Copyright (c) 2015 Jan Chaloupecky. All rights reserved.
//

#import "TADateTransformer.h"


@implementation TADateTransformer {

}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

+ (Class)transformedValueClass
{
    return [super transformedValueClass];
}

- (id)transformedValue:(id)value
{
    return [super transformedValue:value];
}

- (id)reverseTransformedValue:(id)value
{
    return [super reverseTransformedValue:value];
}


@end