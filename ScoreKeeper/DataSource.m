//
//  DataSource.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-06.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "DataSource.h"
#import "ScoreKeeperTableViewCell.h"

static NSString * const cellIdentifier = @"identifier";

@implementation DataSource

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[ScoreKeeperTableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreKeeperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ScoreKeeperTableViewCell *cell = self.allCells[indexPath.row];
        [self.allCells removeObject:cell];
    }
    
    // remove the cell from the table view with an animation
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [tableView reloadData];
}


@end
