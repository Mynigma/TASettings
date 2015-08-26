//
// Created by Jan on 25/08/15.
//

#import <Foundation/Foundation.h>
#import "TASettingViewController.h"

@interface TASettingViewController (Keyboard)

@property (nonatomic, strong, setter = ta_setEditingIndexPath:) NSIndexPath *ta_editingIndexPath;

- (void)startObservingKeyboard;
- (void)stopObservingKeyboard;
@end