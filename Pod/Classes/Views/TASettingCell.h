//
// Created by Jan on 21/08/15.
//

#import <Foundation/Foundation.h>


@interface TASettingCell : UITableViewCell <UIAppearanceContainer>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;

@property (nonatomic, strong) UI_APPEARANCE_SELECTOR UIFont *titleLabelFont;
@property (nonatomic, strong) UI_APPEARANCE_SELECTOR UIFont *subtitleLabelFont;


@end