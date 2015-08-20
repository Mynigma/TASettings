//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>


@interface TATextFieldCell : UITableViewCell <UIAppearanceContainer>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *valueTextField;

@property (nonatomic, strong) UI_APPEARANCE_SELECTOR UIFont *titleLabelFont;

@end