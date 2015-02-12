//
//  Player.h
//  ScoreKeeper
//
//  Created by sombra on 2015-02-12.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *score;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)playerDictionary;

@end
