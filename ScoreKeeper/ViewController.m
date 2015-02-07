//
//  ViewController.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-06.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "ViewController.h"
#import "DataSource.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Add UITableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.title = @"Score Keeper";
    
    self.dataSource = [DataSource new];
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerTableView:self.tableView];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.leftBarButtonItem = self.editButtonItem;
    
    [self.view addSubview:self.tableView];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
