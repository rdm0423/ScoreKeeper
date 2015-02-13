//
//  ViewController.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-06.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "ViewController.h"
#import "DataSource.h"
#import "Player.h"
#import "PlayerController.h"
#import "IBScoreKeeperTableViewCell.h"

@interface ViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    
    // Add UITableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    // data source stuff
    self.dataSource = [DataSource new];
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerTableView:self.tableView];
    [self.dataSource registerNib:self.tableView];
    self.dataSource.allCells = [[NSMutableArray alloc] init];
    
    // delegate stuff
    self.tableView.delegate = self;
    
    // set navigation bar items
    UINavigationItem *navItem = self.navigationItem;
    navItem.leftBarButtonItem = self.editButtonItem;
    navItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    navItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

// enable editing mode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];

}

// method to add new cells
- (IBAction)addItem:(id)sender {
    NSIndexPath *indexPath = [self.dataSource addNewCell:self.tableView];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

// deselect row when selecting row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
