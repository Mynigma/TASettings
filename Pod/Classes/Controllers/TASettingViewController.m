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
#import "TASetting.h"
#import "TASettingViewController+Keyboard.h"


static void *TAContext = &TAContext;

@interface TASettingViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *sections;

@end

@implementation TASettingViewController {

}

#pragma mark - View Life Cycle

- (instancetype)initWithSettings:(TASetting *)settings
{
    self = [super init];
    if (self) {
        _settings = settings;
        _showCancelButton = YES;
        _showDoneButton = YES;

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

    [self startObservingSettings];
    [self startObservingKeyboard];

    self.sections = [self.settings.children filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TASetting *setting, NSDictionary *bindings) {
        return setting.settingType == TASettingTypeGroup;
    }]];

    self.title = self.settings.title;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addDoneButtonIfNecessary];
    [self addCancelButtonIfNecessary];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TASetting *settings = [self settingsForSection:section];

    return settings.title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections ? self.sections.count : 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self settingsForSection:section].children.count;
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
    if (setting.settingType == TASettingTypeMultiValue) {
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
    TASetting *settings = [self settingsForSection:indexPath.section];
    TASetting *setting = settings.children[indexPath.row];
    return setting;
}


#pragma mark - Actions

- (void)doneButtonPressed:(id)doneButton
{
    [self.view endEditing:YES];
    if ([self.delegate respondsToSelector:@selector(settingViewController:didRequestSaveSettings:)]) {
        [self.delegate settingViewController:self didRequestSaveSettings:self.settings];
    }
}

-(void )cancelButtonPressed:(id) cancelButton
{
    [self.view endEditing:YES];
    if ([self.delegate respondsToSelector:@selector(settingViewController:willDismissSettings:)]) {
        [self.delegate settingViewController:self willDismissSettings:self.settings];
    }
}

#pragma mark - Helpers

- (TASetting *)settingsForSection:(NSInteger)section
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
    NSAssert(cellId, @"Must provide a mapping for setting type  %@", @(settingType));
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

- (void)addCancelButtonIfNecessary
{
    if (self.showCancelButton) {
        NSAssert(self.navigationController, @"If you sent the propery showCancelButton, you must embedd in a navigation controller");

        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                    target:self
                                                                                    action:@selector(cancelButtonPressed:)];

        self.navigationItem.leftBarButtonItem = buttonItem;
    }
}


#pragma mark - KVO

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

- (void)startObservingSettings
{
    [self traverseSettings:self.settings
      nodeBlock:^(TASetting *nodeSetting) {

          [nodeSetting addObserver:self forKeyPath:@"children" options:0 context:TAContext];

    } leafBlock:^(TASetting *leafSetting) {
        [@[ @"subtitle", @"title", @"settingValue", @"settingValue.value" ] enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL *stop) {
            [leafSetting addObserver:self
                          forKeyPath:keyPath
                             options:0 context:TAContext];
        }];
    }];
}

- (void)stopObservingSettings
{
    [self traverseSettings:self.settings
      nodeBlock:^(TASetting *nodeSetting) {
          [nodeSetting removeObserver:self forKeyPath:@"children" context:TAContext];

      } leafBlock:^(TASetting *leafSetting) {

        [@[ @"subtitle", @"title", @"settingValue", @"settingValue.value" ] enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL *stop) {
            [leafSetting removeObserver:self
                             forKeyPath:keyPath
                                context:TAContext];
        }];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == TAContext) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            if([keyPath isEqualToString:@"children"]) {
//                NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, (NSUInteger) [self.tableView numberOfSections])];
//                [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
//            } else {
                [self.tableView reloadData];
//            }
        }];
    }
}

- (void)dealloc
{
    [self stopObservingSettings];
    [self stopObservingKeyboard];
}

@end