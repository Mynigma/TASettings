//
// Created by Jan on 14/09/15.
//

#import <UIKit/UIKit.h>
#import "TASettingCell.h"


@interface TATextViewCell : TASettingCell

@property (nonatomic, strong) UITextView *valueTextView;

@property (nonatomic, strong) UI_APPEARANCE_SELECTOR UIFont *valueTextFieldFont;

@end