//
// Created by Jan on 24/08/15.
//

#import <UIKit/UIKit.h>
#import "TAActionSetting.h"
#import "TASettingCell.h"


@interface TAActionCell : TASettingCell

@property(nonatomic, strong, readonly) UIButton *button;
@property(nonatomic, assign) TAActionSettingStyle style;

- (void)setTitleColor:(UIColor *)color forStyle:(TAActionSettingStyle)style UI_APPEARANCE_SELECTOR;
- (void)setTitleFont:(UIFont *)font forStyle:(TAActionSettingStyle)style UI_APPEARANCE_SELECTOR;

@end