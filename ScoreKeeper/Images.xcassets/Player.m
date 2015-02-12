//
//  Player.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-12.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "Player.h"

static NSString * const nameKey = @"name";
static NSString * const scoreKey = @"score";
static NSString * const playerKey = @"player";

@implementation Player

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        self.name = dictionary[nameKey];
        self.score = dictionary[scoreKey];
    }
    
    return self;
}

- (NSDictionary *)playerDictionary {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if (self.name) {
        dictionary[nameKey] = self.name;
    }
    
    if (self.score) {
        dictionary[scoreKey] = self.score;
    }
    
    return dictionary;
}

@end
