//
// Created by Jan on 24/08/15.
//

#import "TALabelCell.h"


@implementation TALabelCell {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupAutoLayout];
    }

    return self;
}

#pragma mark - Auto Layout


- (void)setupAutoLayout
{
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *metrics = @{ };
    NSDictionary *views = @{
            @"titleLabel" : self.titleLabel,
    };


    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];

    // vertical spacing to label
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];


}

@end