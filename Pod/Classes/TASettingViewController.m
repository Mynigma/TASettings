//
// Created by Jan on 20/08/15.
//

#import "TASettingViewController.h"
#import "TASettingGroup.h"


@interface TASettingViewController () <UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *sections;

@end

@implementation TASettingViewController {

}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];

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
    return  [self settingsForSection:section].settings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    TASettings *settings = [self settingsForSection:indexPath.section];
    TASetting *setting = settings.settings[indexPath.row];
    [self configureCell:cell withSetting:setting];

    return cell;
}

#pragma mark - Cell Configuration

- (void)configureCell:(UITableViewCell *)tableViewCell withSetting:(TASetting *)setting
{
   tableViewCell.textLabel.text = setting.localizedTitle;
}


#pragma mark - Actions

- (void)doneButtonPressed:(id)doneButton
{

}

#pragma mark - Helpers

- (TASettings *)settingsForSection:(NSInteger)section
{
    return self.sections ? self.sections[section] : self.settings;
}

- (void)addDoneButtonIfNecessary
{
    if (self.showDoneButton) {
        NSAssert(self.navigationController, @"If you sent the propery showDoneButton, you must embedd in a navigation controller");

        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(doneButtonPressed:)];

        self.navigationController.navigationItem.rightBarButtonItem = buttonItem;
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