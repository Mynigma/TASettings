//
// Created by Jan on 25/08/15.
//

#import "TASettingViewController+Keyboard.h"
#import <objc/runtime.h>

static char TAEditingIndexPathKey;

@implementation TASettingViewController (Keyboard)

#pragma mark - Notification Setup

- (void)startObservingKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)stopObservingKeyboard
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Notification Handling


- (void)keyboardWillHide:(NSNotification *)notification
{
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [self applyContentInset:UIEdgeInsetsZero withDuration:rate.floatValue];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[notification userInfo][UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets;
    CGFloat topLayoutGuideLength = self.topLayoutGuide.length;
//    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(topLayoutGuideLength, 0.0, (keyboardSize.height), 0.0);
//    } else {
//        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
//    }

    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [self applyContentInset:contentInsets withDuration:rate.floatValue];
}

- (void)applyContentInset:(UIEdgeInsets)contentInsets withDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.tableView.contentInset = contentInsets;
        self.tableView.scrollIndicatorInsets = contentInsets;
        [self.tableView scrollToRowAtIndexPath:self.ta_editingIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }];
}

#pragma mark - Associated Objects

- (NSIndexPath *)ta_editingIndexPath {
    NSIndexPath *indexPath = (NSIndexPath *)objc_getAssociatedObject(self, &TAEditingIndexPathKey);
    return indexPath;
}

- (void)ta_setEditingIndexPath:(NSIndexPath *)indexPath
{
   objc_setAssociatedObject(self, &TAEditingIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end