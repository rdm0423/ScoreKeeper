//
//  GameController.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-13.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "GameController.h"

@interface GameController ()

@property (nonatomic, strong) NSArray *games;

@end

static NSString * const gameNameKey = @"gameName";
static NSString * const playersKey = @"players";
static NSString * const gamesKey = @"games";

@implementation GameController

+ (GameController *)sharedInstance {
    static GameController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GameController alloc] init];
        
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)addGame:(Game *)game {
    
    if (!game) {
        return;
    }
    
    NSMutableArray *mutableGames = [[NSMutableArray alloc] initWithArray:self.games];
    [mutableGames addObject:game];
    
    self.games = mutableGames;
    [self saveToDefaults];
}

- (void)removeGame:(Game *)game {
    
    if (!game) {
        return;
    }
    
    NSMutableArray *mutableGames = [[NSMutableArray alloc] initWithArray:self.games];
    [mutableGames removeObject:game];
    self.games = mutableGames;
    
    [self saveToDefaults];
}

- (void)replaceGame:(Game *)oldGame withGame:(Game *)newGame {
    
    if (!oldGame || !newGame) {
        return;
    }
    
    NSMutableArray *mutableGames = [[NSMutableArray alloc] initWithArray:self.games];
    
    if ([mutableGames containsObject:oldGame]) {
        
        NSUInteger index = [mutableGames indexOfObject:oldGame];
        [mutableGames replaceObjectAtIndex:index withObject:newGame];
    }
    
    self.games = mutableGames;
    [self saveToDefaults];
}

- (void)loadFromDefaults {
    
    NSArray *gameDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:gamesKey];
    
    NSMutableArray *games = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in gameDictionaries) {
        [games addObject:[[Game alloc] initWithDictionary:dictionary]];
    }
    
    self.games = games;
}

- (void)saveToDefaults {
    
    NSMutableArray *gameDictionaries = [[NSMutableArray alloc] init];
    
    for (Game *game in self.games) {

        NSDictionary *dictionary = [game gameDictionary];
        [gameDictionaries addObject:dictionary];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:gameDictionaries forKey:gamesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
