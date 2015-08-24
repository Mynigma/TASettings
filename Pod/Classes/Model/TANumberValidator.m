//
// Created by Jan on 24/08/15.
//

#import "TANumberValidator.h"
#import "TASetting.h"


@implementation TANumberValidator {

}
- (BOOL)validateValue:(id)value forSetting:(TASetting *)setting error:(NSError **)error
{
    NSString *stringValue = value;
    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([stringValue rangeOfCharacterFromSet:notDigits].location == NSNotFound) {
        return YES;
    } else {
        if(error != NULL) *error = [NSError errorWithDomain:@"" code:0 userInfo:@{
                    NSLocalizedDescriptionKey : @"Must contain only numbers",
            }];
        return NO;
    }
}

@end