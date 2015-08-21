//
// Created by Jan on 20/08/15.
//

#import "UILabel+TALabel.h"


@implementation UILabel (TALabel)

+ (instancetype)ta_settingTitleLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.minimumScaleFactor = 0.3;
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 0;
    return label;
}
@end