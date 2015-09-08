//
// Created by Jan on 08/09/15.
//

#import "TASettingViewController+KVO.h"
#import "TASetting.h"

static void *TAContext = &TAContext;


@implementation TASettingViewController (KVO)


#pragma mark - Public

- (void)startObservingSettings:(TASetting *)settings
{
    [self traverseSettings:settings
                 nodeBlock:^(TASetting *nodeSetting) {
                     [nodeSetting addObserver:self forKeyPath:@"children" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:TAContext];

                 } leafBlock:^(TASetting *leafSetting) {
                [self startObservingLeafSetting:leafSetting];
            }];
}

- (void)stopObservingSettings:(TASetting *)settings
{
    [self traverseSettings:settings
                 nodeBlock:^(TASetting *nodeSetting) {
                     [nodeSetting removeObserver:self forKeyPath:@"children" context:TAContext];

                 } leafBlock:^(TASetting *leafSetting) {
                [self stopObservingLeafSetting:leafSetting];
            }];
}

#pragma mark - Private

/**
 *  Traverses recursively the settings and calls the blocks on the settings
 *
 *  @param setting   The root setting where the recursion starts
 *  @param nodeBlock The block called on setting which have children
 *  @param leafBlock The block called on setting without children
 */
- (void)traverseSettings:(TASetting *)setting nodeBlock:(void (^)(TASetting *leafSetting))nodeBlock leafBlock:(void (^)(TASetting *leafSetting))leafBlock
{
    if (setting.children.count > 0) {
        nodeBlock(setting);
        [setting.children enumerateObjectsUsingBlock:^(TASetting *childSetting, NSUInteger idx2, BOOL *stop2) {
            [self traverseSettings:childSetting nodeBlock:nodeBlock leafBlock:leafBlock];
        }];
    } else {
        leafBlock(setting);
    }
}



- (void)startObservingLeafSetting:(TASetting *)leafSetting
{
    [@[ @"subtitle", @"title", @"settingValue", @"settingValue.value" ] enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL *stop) {
        [leafSetting addObserver:self
                      forKeyPath:keyPath
                         options:0 context:TAContext];
    }];
}

- (void)stopObservingLeafSetting:(TASetting *)leafSetting
{
    [@[ @"subtitle", @"title", @"settingValue", @"settingValue.value" ] enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL *stop) {
        [leafSetting removeObserver:self
                         forKeyPath:keyPath
                            context:TAContext];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == TAContext) {

        if ([keyPath isEqualToString:@"children"]) {
            NSArray *removedSettings = change[NSKeyValueChangeOldKey];
            [removedSettings enumerateObjectsUsingBlock:^(TASetting *setting, NSUInteger idx, BOOL *stop) {
                [self stopObservingSettings:setting];
            }];

            NSArray *addedSettings = change[NSKeyValueChangeNewKey];
            [addedSettings enumerateObjectsUsingBlock:^(TASetting *setting, NSUInteger idx, BOOL *stop) {
                [self startObservingSettings:setting];
            }];
        }

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }
}

@end