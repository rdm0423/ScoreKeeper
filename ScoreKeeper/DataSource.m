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

static NSString * const cellIdentifier = @"identifier";

@implementation DataSource

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[IBScoreKeeperTableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (void)registerNib:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:@"IBScoreKeeperTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allCells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IBScoreKeeperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;
}

// method to ensure table view commit a delete command
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        IBScoreKeeperTableViewCell *cell = self.allCells[indexPath.row];
        [self.allCells removeObject:cell];
        
        // remove the cell from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

// get index path for adding cell
- (NSIndexPath *)addNewCell:(UITableView *)tableView {
    IBScoreKeeperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [self.allCells addObject:cell];
    
    NSInteger lastRow = [self.allCells indexOfObject:cell];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    return indexPath;
}

// methods for reordering rows
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    IBScoreKeeperTableViewCell *cell = [self.allCells objectAtIndex:sourceIndexPath.row];
    [self.allCells removeObject:cell];
    [self.allCells insertObject:cell atIndex:destinationIndexPath.row];
}

@end
