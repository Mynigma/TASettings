//
// Created by Jan on 24/08/15.
//

#import "TAActionCell.h"


@interface TAActionCell ()
@property(nonatomic, strong) UIButton *button;

@property (nonatomic, strong) NSMutableDictionary *fontsByStyle;
@property (nonatomic, strong) NSMutableDictionary *colorsByStyle;
@end

@implementation TAActionCell {

}

+ (void)initialize {
    // this sets the default appearance before the user customizes it
    if (self == [TAActionCell class]) {

        // todo get those colors programatically

        [[TAActionCell appearance] setTitleColor:[UIColor colorWithRed:0.19 green:0.48 blue:1 alpha:1] forStyle:TAActionSettingStyleDefault];
        [[TAActionCell appearance] setTitleColor:[UIColor colorWithRed:0.96 green:0.23 blue:0.19 alpha:1] forStyle:TAActionSettingStyleDestructive];

        [[TAActionCell appearance] setTitleFont:[UIFont systemFontOfSize:[UIFont buttonFontSize]] forStyle:TAActionSettingStyleDefault];
        [[TAActionCell appearance] setTitleFont:[UIFont systemFontOfSize:[UIFont buttonFontSize]] forStyle:TAActionSettingStyleDestructive];

    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];

        [self.contentView addSubview:self.button];
        self.fontsByStyle = [[NSMutableDictionary alloc] init];
        self.colorsByStyle = [[NSMutableDictionary alloc] init];


        [self setupAutoLayout];
    }

    return self;
}

#pragma mark - Auto Layout


- (void)setupAutoLayout
{
    self.button.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *metrics = @{ @"TAMinimumCellHeight" : @(TAMinimumCellHeight) };
    NSDictionary *views = @{
            @"titleLabel" : self.button,
    };


    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];

    // vertical spacing to label
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel(>=TAMinimumCellHeight)]-|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:metrics
                                                                               views:views]];

}

#pragma mark - Accessors

- (void)setStyle:(TAActionSettingStyle)style
{
    _style = style;
    [self updateWithCurrentStyle];
}


#pragma mark - Appearance

- (void)setTitleColor:(UIColor *)color forStyle:(TAActionSettingStyle)style
{
    self.colorsByStyle[@(style)] = color;
    [self updateWithCurrentStyle];
}

- (void)setTitleFont:(UIFont *)font forStyle:(TAActionSettingStyle)style
{
    self.fontsByStyle[@(style)] = font;
    [self updateWithCurrentStyle];
}

#pragma mark - Helpers

-(void) updateWithCurrentStyle
{
    UIColor *color = self.colorsByStyle[@(self.style)];
    if(color) {
        [self.button setTitleColor:color forState:UIControlStateNormal];
    }

    UIFont *font = self.fontsByStyle[@(self.style)];
    if(font) {
        self.button.titleLabel.font = font;
    }
}


@end