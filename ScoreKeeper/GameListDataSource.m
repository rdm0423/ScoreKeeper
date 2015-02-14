//
//  GameListDataSource.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-13.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "GameListDataSource.h"
#import "GameController.h"

static NSString * const gameCell = @"cell";

@implementation GameListDataSource

- (void)registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:gameCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:gameCell];
    
    cell.textLabel.text = @"new game";
    
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
    
    Game *game = [[Game alloc] init];
    [[GameController sharedInstance] addGame:game];
    
    NSUInteger lastRow = [[GameController sharedInstance].games indexOfObject:game];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    return indexPath;
}

@end
