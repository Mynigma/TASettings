//
// Created by Jan on 24/08/15.
//

#import <Foundation/Foundation.h>

@class TAMultiValueSetting;
@protocol TASettingViewControllerDelegate;


@interface TAMultiValueViewController : UIViewController

@property (nonatomic, strong, readonly) TAMultiValueSetting *setting;
@property(nonatomic, strong) id <TASettingViewControllerDelegate> delegate;

- (instancetype)initWithSetting:(TAMultiValueSetting *)setting;


@end