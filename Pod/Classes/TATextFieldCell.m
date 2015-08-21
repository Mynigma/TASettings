//
// Created by Jan on 20/08/15.
//

#import "TATextFieldCell.h"
#import "UILabel+TALabel.h"


@implementation TATextFieldCell {

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.titleLabel = [UILabel ta_settingTitleLabel];

        self.valueTextField = [[UITextField alloc] initWithFrame:CGRectZero];

        self.selectionStyle = UITableViewCellSelectionStyleNone;


        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueTextField];
        [self setupAutoLayout];

    }

    return self;
}

#pragma mark - Private

-(void) setupAutoLayout
{
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.valueTextField.translatesAutoresizingMaskIntoConstraints = NO;


    // 1/3rd width
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:0.3 constant:0]];

    NSDictionary *metrics = @{};
    NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel, _valueTextField);


    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-[_valueTextField]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];

    // vertical spacing to label
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];

    // vertical spacing to label
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_valueTextField]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];


}

#pragma mark - UIAppearanceContainer

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    _titleLabelFont = titleLabelFont;
    self.titleLabel.font = titleLabelFont;
}

- (void)setValueTextFieldFont:(UIFont *)valueTextFieldFont
{
    _valueTextFieldFont = valueTextFieldFont;
    self.valueTextField.font = valueTextFieldFont;
}


@end