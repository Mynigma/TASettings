//
// Created by Jan on 20/08/15.
//

#import "TASettingViewController.h"
#import "TATextFieldCell.h"
#import "TATextFieldSetting.h"
#import "TASettingViewController+TATextField.h"
#import "TASettingValue.h"
#import "TASwitchCell.h"
#import "TASettingViewController+TASwitch.h"
#import "TAMultiValueCell.h"
#import "TAMultiValueSetting.h"
#import "TAMultiValueViewController.h"


@interface TASettingViewController () <UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, strong) NSArray *sections;

@end

@implementation TASettingViewController {

}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView registerClass:[TATextFieldCell class] forCellReuseIdentifier:[self cellIdentifierForSettingType:TASettingTypeTextField]];
    [self.tableView registerClass:[TASwitchCell class] forCellReuseIdentifier:[self cellIdentifierForSettingType:TASettingTypeSwitch]];
    [self.tableView registerClass:[TAMultiValueCell class] forCellReuseIdentifier:[self cellIdentifierForSettingType:TASettingTypeMultiValue]];

    [self.view addSubview:self.tableView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addDoneButtonIfNecessary];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.frame;
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TASettings *settings = [self settingsForSection:section];

    return settings.localizedTitle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections ? self.sections.count : 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self settingsForSection:section].settings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TASetting *setting = [self settingForIndexPath:indexPath];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForSettingType:setting.settingType] forIndexPath:indexPath];

    switch (setting.settingType) {
        case TASettingTypeChild:
            break;
        case TASettingTypeTextField:
            [self configureTextFieldCell:cell withSetting:setting];
            break;
        case TASettingTypeMultiValue:
            [self configureMultiValueCell:cell withSetting:setting];
            break;
        case TASettingTypeSwitch:
            [self configureSwitchCell:cell withSetting:setting];
            break;
    }

    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TASetting *setting = [self settingForIndexPath:indexPath];
    if(setting.settingType == TASettingTypeMultiValue) {
        TAMultiValueViewController *multiValueViewController = [[TAMultiValueViewController alloc] initWithSetting:(TAMultiValueSetting *) setting];
        multiValueViewController.delegate = self.delegate;
        [self.navigationController pushViewController:multiValueViewController animated:YES];
    }
}


- (void)configureMultiValueCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting
{

    NSAssert([tableViewCell isKindOfClass:[TAMultiValueCell class]], @"Must be a %@ class", NSStringFromClass([TAMultiValueCell class]));
    TAMultiValueCell *cell = (TAMultiValueCell *) tableViewCell;

    TAMultiValueSetting *multiValueSetting = (TAMultiValueSetting *) setting;
    cell.titleLabel.text = setting.localizedTitle;
    cell.subtitleLabel.text = multiValueSetting.selectedSubtitle;

}

#pragma mark - Public

- (TASetting *)settingForIndexPath:(NSIndexPath *)indexPath
{
    TASettings *settings = [self settingsForSection:indexPath.section];
    TASetting *setting = settings.settings[indexPath.row];
    return setting;
}


#pragma mark - Actions

- (void)doneButtonPressed:(id)doneButton
{
    [self.delegate settingViewController:self didRequestSaveSettings:self.settings];

}

#pragma mark - Helpers

- (TASettings *)settingsForSection:(NSInteger)section
{
    return self.sections ? self.sections[section] : self.settings;
}

- (NSString *)cellIdentifierForSettingType:(TASettingType)settingType
{
    static NSDictionary *mapping;
    static dispatch_once_t token;

    dispatch_once(&token, ^{
        mapping = @{
                @(TASettingTypeTextField) : @"TASettingTypeTextFieldCellId",
                @(TASettingTypeMultiValue) : @"TASettingTypeMultiValueCellId",
                @(TASettingTypeSwitch) : @"TASettingTypeSwitchCellId"
        };
    });

    NSString *cellId = mapping[@(settingType)];
    NSAssert(cellId, @"Must provide a mapping for cell id");
    return cellId;
}

- (void)addDoneButtonIfNecessary
{
    if (self.showDoneButton) {
        NSAssert(self.navigationController, @"If you sent the propery showDoneButton, you must embedd in a navigation controller");

        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(doneButtonPressed:)];

        self.navigationItem.rightBarButtonItem = buttonItem;
    }
}

#pragma mark - Accessors

- (void)setSettings:(TASettings *)settings
{
    _settings = settings;

    self.title = settings.localizedTitle;

    self.sections = [settings.settings filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TASetting *setting, NSDictionary *bindings) {
        return setting.settingType == TASettingTypeGroup;
    }]];

}


@end