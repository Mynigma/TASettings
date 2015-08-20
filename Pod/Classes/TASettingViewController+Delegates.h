//
// Created by Jan on 20/08/15.
//

#import <Foundation/Foundation.h>
#import "TASettingViewController.h"

@interface TASettingViewController (Delegates)

- (void)handleChangedValue:(id)value inCell:(UITableViewCell *)cell;

@end