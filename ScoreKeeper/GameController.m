//
//  GameController.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-13.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "GameController.h"
#import "Stack.h"
#import "Player.h"
#import "Game.h"

@interface GameController ()

@property (nonatomic, strong) NSArray *games;
@property (nonatomic, strong) NSArray *players;

@end

static NSString * const gameNameKey = @"gameName";
static NSString * const playersKey = @"players";
static NSString * const gamesKey = @"game";

@implementation GameController

+ (GameController *)sharedInstance {
    static GameController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GameController alloc] init];
        
    });
    return sharedInstance;
}

#pragma mark - fetchRequest

- (NSArray *)games {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
}


#pragma mark - setting up core data storage

- (void)addGameWithTitle:(NSString *)title {
    Game *newGame = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    newGame.title = title;
    
    [self synchronize];

}

- (void)removeGame:(Game *)game {
    
    [game.managedObjectContext deleteObject:game];
    [self synchronize];
    }

- (void)addPlayer:(Player *)player toGame:(Game *)game {
    
    [game addPlayersObject:player];
    [self synchronize];
}

- (void)removePlayer:(Player *)player {
    
    [player.managedObjectContext deleteObject:player];
    [self synchronize];
}

- (Player *)createPlayerWithName:(NSString *)name andScore:(NSString *)score {
    
    Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    return player;
}

- (void)synchronize {
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
}


@end
