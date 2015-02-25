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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, IBScoreKeeperTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataSource *dataSource;

@end

static NSString * const cellIdentifier = @"identifier";
static NSString * const nameKey = @"name";
static NSString * const scoreKey = @"score";

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
    titleView.text = self.game.name;
    self.navigationItem.titleView = titleView;
    [titleView sizeToFit];
    
    // set navigation bar background color
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.19 green:0.6 blue:0.87 alpha:1];
    
    // Add UITableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 44;
    
    // data source stuff
//    self.dataSource = [DataSource new];
//    self.tableView.dataSource = self.dataSource;
//    [self.dataSource registerTableView:self.tableView];
//    [self.dataSource registerNib:self.tableView];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[IBScoreKeeperTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"IBScoreKeeperTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    // delegate stuff
    self.tableView.delegate = self;
    
    // set navigation bar items
    UINavigationItem *navItem = self.navigationItem;
//    navItem.leftBarButtonItem = self.editButtonItem;
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(done)];
    navItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    navItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IBScoreKeeperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // update player info for the table view cell
    cell.playerDictionary = self.game.players[indexPath.row];
    cell.textField.text = cell.playerDictionary[nameKey];
    cell.scoreLabel.text = cell.playerDictionary[scoreKey];
    cell.stepper.value = [cell.playerDictionary[scoreKey] doubleValue];
    
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.game.players.count;
}

- (void)done {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// enable editing mode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];

}

// method to ensure table view commit a delete command
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Game *game = [[Game alloc] init];
        game.name = [NSString stringWithFormat:@"%@", self.game.name];
        game.players = [[NSMutableArray alloc] initWithArray:self.game.players];
        
        NSDictionary *playerDictionary = game.players[indexPath.row];
        
        [game.players removeObjectIdenticalTo:playerDictionary];
        [[GameController sharedInstance] replaceGame:self.game withGame:game];
        self.game = game;
        
        // remove the cell from the table view with an animation
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

// method to add new cells
- (IBAction)addItem:(id)sender {
    
    Player *player = [[Player alloc] init];
    NSDictionary *playerDictionary = [player playerDictionary];
    
    Game *game = [[Game alloc] init];
    game.name = [NSString stringWithFormat:@"%@", self.game.name];
    game.players = [[NSMutableArray alloc] initWithArray:self.game.players];
    [game.players addObject:playerDictionary];
    [[GameController sharedInstance] replaceGame:self.game withGame:game];
    self.game = game;
    
    NSInteger lastRow = [game.players indexOfObject:playerDictionary];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
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

#pragma custom delegate method

- (void)valueChangedForCellStepper:(UIStepper *)stepper cell:(IBScoreKeeperTableViewCell *)cell {

    double stepperValue = stepper.value;
    cell.scoreLabel.text = [NSString stringWithFormat:@"%d", (int) stepperValue];
    
    NSDictionary *playerDictionary = @{nameKey: cell.textField.text, scoreKey: cell.scoreLabel.text};
    
    Game *game = [[Game alloc] init];
    game.name = [NSString stringWithFormat:@"%@", self.game.name];
    game.players = [[NSMutableArray alloc] initWithArray:self.game.players];
    NSUInteger index = [game.players indexOfObject:cell.playerDictionary];
    [game.players insertObject:playerDictionary atIndex:index];
    [game.players removeObjectIdenticalTo:cell.playerDictionary];
    [[GameController sharedInstance] replaceGame:self.game withGame:game];
    
    self.game = game;
    cell.playerDictionary = playerDictionary;
}

@end
