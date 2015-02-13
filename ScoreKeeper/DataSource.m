//
//  DataSource.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-06.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "DataSource.h"
#import "ScoreKeeperTableViewCell.h"
#import "IBScoreKeeperTableViewCell.h"
#import "PlayerController.h"

static NSString * const cellIdentifier = @"identifier";

@implementation DataSource

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[IBScoreKeeperTableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (void)registerNib:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:@"IBScoreKeeperTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [PlayerController sharedInstance].players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IBScoreKeeperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // update player info for the table view cell
    cell.player = [PlayerController sharedInstance].players[indexPath.row];
    cell.textField.text = cell.player.name;
    cell.scoreLabel.text = cell.player.score;
    cell.stepper.value = [cell.player.score doubleValue];
    
    return cell;
}

// method to ensure table view commit a delete command
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Player *player = [PlayerController sharedInstance].players[indexPath.row];
        [[PlayerController sharedInstance] removePlayer:player];
        
        // remove the cell from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

// get index path for adding cell
- (NSIndexPath *)addNewCell:(UITableView *)tableView {
    
    IBScoreKeeperTableViewCell *cell = [[IBScoreKeeperTableViewCell alloc] init];
    
    Player *player = [[Player alloc] init];
    player.name = cell.textField.text;
    player.score = cell.scoreLabel.text;
    [[PlayerController sharedInstance] addPlayer:player];
    
    NSInteger lastRow = [[PlayerController sharedInstance].players indexOfObject:player];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    return indexPath;
}

// methods for reordering rows
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [[PlayerController sharedInstance] moveFromIndex:sourceIndexPath.row toNewIndex:destinationIndexPath.row];
}

@end
