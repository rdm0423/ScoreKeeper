//
//  PlayerController.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-12.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "PlayerController.h"

@interface PlayerController ()

@property (nonatomic, strong) NSArray *players;

@end

static NSString * const nameKey = @"name";
static NSString * const scoreKey = @"score";
static NSString * const playerKey = @"player";

@implementation PlayerController

+ (PlayerController *)sharedInstance {
    static PlayerController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PlayerController alloc] init];
        
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)loadFromDefaults {
    
    NSArray *playerDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:playerKey];
    
    NSMutableArray *players = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in playerDictionaries) {
        [players addObject:[[Player alloc] initWithDictionary:dictionary]];
    }
    
    self.players = players;
}

- (void)saveToDefaults {
    
    NSMutableArray *playerDictionaries = [[NSMutableArray alloc] init];
    
    for (Player *player in self.players) {
        NSDictionary *dictionary = [player playerDictionary];
        [playerDictionaries addObject:dictionary];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:playerDictionaries forKey:playerKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
