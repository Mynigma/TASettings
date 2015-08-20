//
// Created by Jan on 20/08/15.
//

#import "TASettingViewController.h"


@interface TASettingViewController ()

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation TASettingViewController {

}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    self.tableView = [[UITableView alloc] init];
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

#pragma mark - Actions

- (void)doneButtonPressed:(id)doneButton
{

}

#pragma mark - Helpers

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


@end