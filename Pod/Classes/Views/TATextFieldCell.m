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


        self.valueTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

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

    NSDictionary *metrics = @{ @"TAMinimumCellHeight" : @(TAMinimumCellHeight) };
    NSDictionary *views = @{
            @"titleLabel" : self.titleLabel,
            @"valueTextField" : self.valueTextField,
    };


    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-[valueTextField]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];

    // vertical spacing to label
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel(>=TAMinimumCellHeight)]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];

    // vertical spacing to label
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[valueTextField]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];


}

#pragma mark - UIAppearanceContainer


- (void)setValueTextFieldFont:(UIFont *)valueTextFieldFont
{
    _valueTextFieldFont = valueTextFieldFont;
    self.valueTextField.font = valueTextFieldFont;
}


@end