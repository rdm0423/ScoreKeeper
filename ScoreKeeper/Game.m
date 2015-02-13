//
//  Game.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-13.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "Game.h"

static NSString * const gameNameKey = @"gameName";
static NSString * const playersKey = @"players";

@implementation Game

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        self.name = dictionary[gameNameKey];
        self.players = dictionary[playersKey];
    }
    
    return self;
}

- (NSDictionary *)gameDictionary {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    if (self.name) {
        dictionary[gameNameKey] = self.name;
    }
    
    if (self.players) {
        dictionary[playersKey] = self.players;
    }
    
    return dictionary;
}

@end
