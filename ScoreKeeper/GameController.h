//
//  GameController.h
//  ScoreKeeper
//
//  Created by sombra on 2015-02-13.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface GameController : NSObject

@property (nonatomic, strong, readonly) NSArray *games;

+ (GameController *)sharedInstance;

- (void)addGame:(Game *)game;
- (void)removeGame:(Game *)game;
- (void)replaceGame:(Game *)oldGame withGame:(Game *)newGame;

@end
