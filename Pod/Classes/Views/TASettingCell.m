//
// Created by Jan on 21/08/15.
//

#import "TASettingCell.h"
#import "UILabel+TALabel.h"


@implementation TASettingCell {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.titleLabel = [UILabel ta_settingTitleLabel];
        [self.contentView addSubview:self.titleLabel];

    }

    return self;
}

#pragma mark - UIAppearanceContainer

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    _titleLabelFont = titleLabelFont;
    self.titleLabel.font = titleLabelFont;
}


@end