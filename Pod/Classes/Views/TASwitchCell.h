//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>
#import "TASettingCell.h"


@interface TASwitchCell : TASettingCell

@property (nonatomic, strong) UISwitch *valueSwitch;


-(void) setupAutoLayout;
@end