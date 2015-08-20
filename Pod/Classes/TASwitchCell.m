//
// Created by Jan on 20/08/15.
//

#import "TASwitchCell.h"


@implementation TASwitchCell {

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.minimumScaleFactor = 0.3;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.numberOfLines = 0;

        self.valueSwitch = [[UISwitch alloc] init];


        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueSwitch];
        [self setupAutoLayout];

    }

    return self;
}

#pragma mark - Private

-(void) setupAutoLayout
{
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.valueSwitch.translatesAutoresizingMaskIntoConstraints = NO;


    NSDictionary *metrics = @{};
    NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel, _valueSwitch);


    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-[_valueSwitch]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];

    // vertical spacing to label
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];

    // vertical center
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.valueSwitch
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0 constant:0]];






}

@end