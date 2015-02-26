//
//  GameController.h
//  ScoreKeeper
//
//  Created by sombra on 2015-02-13.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "Player.h"

@interface GameController : NSObject

@property (nonatomic, strong, readonly) NSArray *games;
@property (nonatomic, strong, readonly) NSArray *players;

+ (GameController *)sharedInstance;

- (void)addGameWithTitle:(NSString *)title;
- (void)removeGame:(Game *)game;
- (void)addPlayersToGames:(NSString *)title name:(NSString *)text andScore:(NSInteger *)score;
- (Player *)createPlayerWithName:(NSString *)name andScore:(NSString *)score;
- (void)removePlayer:(Player *)player;

- (void)synchronize;

@end
