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

@end
