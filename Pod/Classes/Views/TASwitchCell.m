//
// Created by Jan on 20/08/15.
//

#import "TASwitchCell.h"
#import "UILabel+TALabel.h"


@implementation TASwitchCell {

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.valueSwitch = [[UISwitch alloc] init];
        [self.valueSwitch setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
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


    NSDictionary *metrics = @{ @"TAMinimumCellHeight" : @(TAMinimumCellHeight) };
    NSDictionary *views = @{ 
            @"titleLabel" : self.titleLabel,
            @"valueSwitch" : self.valueSwitch
    };


    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-[valueSwitch]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];

    // vertical spacing to label
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel(>=TAMinimumCellHeight)]-|"
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






};


@end