//
// Created by Jan on 20/08/15.
//

#import "TASettingViewController.h"
#import "TATextFieldCell.h"
#import "TASwitchCell.h"
#import "TADetailValueCell.h"
#import "TAMultiValueSetting.h"
#import "TAMultiValueViewController.h"
#import "TAActionCell.h"
#import "TASettingViewController+CellConfiguration.h"


@interface TASettingViewController () <UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, strong) NSArray *sections;

@end

@implementation TASettingViewController {

}

#pragma mark - View Life Cycle

- (instancetype)initWithSettings:(TASettings *)settings
{
    self = [super init];
    if (self) {
        self.settings = settings;
    }
    return self;

}


- (void)viewDidLoad
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView registerClass:[TATextFieldCell class] forCellReuseIdentifier:[self cellIdentifierForSettingType:TASettingTypeTextField]];
    [self.tableView registerClass:[TASwitchCell class] forCellReuseIdentifier:[self cellIdentifierForSettingType:TASettingTypeSwitch]];
    [self.tableView registerClass:[TADetailValueCell class] forCellReuseIdentifier:[self cellIdentifierForSettingType:TASettingTypeMultiValue]];
    [self.tableView registerClass:[TADetailValueCell class] forCellReuseIdentifier:[self cellIdentifierForSettingType:TASettingTypeChild]];
    [self.tableView registerClass:[TAActionCell class] forCellReuseIdentifier:[self cellIdentifierForSettingType:TASettingTypeAction]];

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

    return settings.title;
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
            [self configureChildCell:cell withSetting:setting];
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
        case TASettingTypeAction:
            [self configureActionCell:cell withSetting:setting];
            break;
        case TASettingTypeGroup:
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

    if (setting.settingType == TASettingTypeChild) {
        // todo the casting is wrong here :(
        TASettingViewController *multiValueViewController = [[TASettingViewController alloc] initWithSettings:setting];
        multiValueViewController.delegate = self.delegate;
        [self.navigationController pushViewController:multiValueViewController animated:YES];
    }
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
                @(TASettingTypeMultiValue) : @"TASettingTypeDetailCellId",
                @(TASettingTypeChild) : @"TASettingTypeDetailCellId",
                @(TASettingTypeSwitch) : @"TASettingTypeSwitchCellId",
                @(TASettingTypeAction) : @"TASettingTypeActionCellId"
        };
    });

    NSString *cellId = mapping[@(settingType)];
    NSAssert(cellId, @"Must provide a mapping for setting type  %d", settingType);
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

    self.title = settings.title;

    self.sections = [settings.settings filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TASetting *setting, NSDictionary *bindings) {
        return setting.settingType == TASettingTypeGroup;
    }]];

}


@end