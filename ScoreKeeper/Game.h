//
//  Game.h
//  ScoreKeeper
//
//  Created by sombra on 2015-02-13.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *players;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)gameDictionary;

@end
