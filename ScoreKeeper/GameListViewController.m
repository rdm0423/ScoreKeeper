//
//  GameListViewController.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-13.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "GameListViewController.h"
#import "GameListDataSource.h"
#import "ViewController.h"

@interface GameListViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GameListDataSource *dataSource;

@end

@implementation GameListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // change status bar style
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // change attributes of navigation bar title
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Futura" size:20];
    titleView.textColor = [UIColor whiteColor];
    titleView.text = @"Score Keeper";
    self.navigationItem.titleView = titleView;
    [titleView sizeToFit];
    
    // set navigation bar background color
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    // add table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    // data source stuff
    self.dataSource = [GameListDataSource new];
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerTableView:self.tableView];
    
    // delegate stuff
    self.tableView.delegate = self;
    
    // set navigation bar items
    UINavigationItem *navItem = self.navigationItem;
    navItem.leftBarButtonItem = self.editButtonItem;
    navItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    navItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

// enable editing mode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

// deselect row when row is selected and push view controller to top of navigation stack
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ViewController *viewController = [[ViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

// method for adding new table view cells
- (IBAction)addItem:(id)sender {
    NSIndexPath *indexPath = [self.dataSource addNewCell:self.tableView];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
