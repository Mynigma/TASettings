//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>
#import "TASettingCell.h"


@interface TATextFieldCell : TASettingCell <UIAppearanceContainer>

@property (nonatomic, strong) UITextField *valueTextField;

@property (nonatomic, strong) UI_APPEARANCE_SELECTOR UIFont *valueTextFieldFont;


@end