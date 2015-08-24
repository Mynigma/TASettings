//
// Created by Jan on 24/08/15.
//

#import "TAMultiValueViewController.h"
#import "TAMultiValueSetting.h"
#import "TALabelCell.h"
#import "TASettingValue.h"
#import "TASettingViewController.h"


NSString *const TALabelCellId = @"LabelCellId";

static void *TAMultiContext = &TAMultiContext;

@interface TAMultiValueViewController () <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation TAMultiValueViewController {

}

- (instancetype)initWithSetting:(TAMultiValueSetting *)setting
{
    self = [super init];
    if (self) {
        _setting = setting;
    }

    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView registerClass:[TALabelCell class] forCellReuseIdentifier:TALabelCellId];

    [self.view addSubview:self.tableView];

    self.title = self.setting.title;
    [self.setting.values enumerateObjectsUsingBlock:^(TASettingValue *settingValue, NSUInteger idx, BOOL *stop) {
        [settingValue addObserver:self
                       forKeyPath:@"value"
                          options:0 context:TAMultiContext];

    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.frame;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.setting.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TALabelCell *cell = [tableView dequeueReusableCellWithIdentifier:TALabelCellId forIndexPath:indexPath];
    [self configureValueCell:cell withSettingValue:self.setting.values[(NSUInteger) indexPath.row]];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TASettingValue *settingValue = self.setting.values[(NSUInteger) indexPath.row];
    settingValue.value = @(![settingValue.value boolValue]);

    [self.delegate settingViewController:(TASettingViewController *) self.parentViewController didSelectValue:settingValue inSettings:(TAMultiValueSetting *) settingValue.parent];
}


#pragma mark - Cell Configuration

- (void)configureValueCell:(TALabelCell *)cell withSettingValue:(TASettingValue *)settingValue
{
    cell.titleLabel.text = settingValue.title;
    cell.accessoryType = [settingValue.value boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == TAMultiContext && [keyPath isEqualToString:@"value"]) {
        TASettingValue *settingValue = object;
        NSUInteger index = [self.setting.values indexOfObject:settingValue];
        [self.tableView reloadRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:index inSection:0] ] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)dealloc
{
    [self.setting.values enumerateObjectsUsingBlock:^(TASettingValue *settingValue, NSUInteger idx, BOOL *stop) {
        [settingValue removeObserver:self forKeyPath:@"value" context:TAMultiContext];
    }];
}


@end