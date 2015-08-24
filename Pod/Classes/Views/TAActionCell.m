//
// Created by Jan on 24/08/15.
//

#import "TAActionCell.h"


@interface TAActionCell ()
@property(nonatomic, strong) UIButton *button;
@end

@implementation TAActionCell {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];

        [self.contentView addSubview:self.button];

        [self setupAutoLayout];
    }

    return self;
}

#pragma mark - Auto Layout


- (void)setupAutoLayout
{
    self.button.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *metrics = @{ };
    NSDictionary *views = @{
            @"titleLabel" : self.button,
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

#pragma mark - Accessors


@end