//
// Created by Jan on 24/08/15.
//

#import <Foundation/Foundation.h>
#import "TASetting.h"


@interface TAActionSetting : TASetting

@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL action;


- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action NS_DESIGNATED_INITIALIZER;

@end