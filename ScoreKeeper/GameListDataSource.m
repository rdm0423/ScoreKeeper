//
//  GameListDataSource.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-13.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "GameListDataSource.h"
#import "GameController.h"
#import "GameTableViewCell.h"

static NSString * const gameCell = @"cell";

@implementation GameListDataSource

- (void)registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[GameTableViewCell class] forCellReuseIdentifier:gameCell];
}

- (void)registerNib:(UITableView *)tableView {
    
    [tableView registerNib:[UINib nibWithNibName:@"GameTableViewCell" bundle:nil] forCellReuseIdentifier:gameCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:gameCell];
    
    cell.game = [GameController sharedInstance].games[indexPath.row];
    cell.textField.text = cell.game.name;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [GameController sharedInstance].games.count;
}

// method to ensure table view commit delete command
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Game *game = [GameController sharedInstance].games[indexPath.row];
        [[GameController sharedInstance] removeGame:game];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// method to get index path for adding new cells
- (NSIndexPath *)addNewCell:(UITableView *)tableView {
    
    GameTableViewCell *cell = [[GameTableViewCell alloc] init];
    
    Game *game = [[Game alloc] init];
    game.name = cell.textField.text;
    [[GameController sharedInstance] addGame:game];
    
    NSUInteger lastRow = [[GameController sharedInstance].games indexOfObject:game];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    return indexPath;
}

// methods for reordering rows
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [[GameController sharedInstance] moveFromIndex:sourceIndexPath.row toNewIndex:destinationIndexPath.row];
}

@end
