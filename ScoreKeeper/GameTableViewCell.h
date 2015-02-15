//
//  GameTableViewCell.h
//  ScoreKeeper
//
//  Created by sombra on 2015-02-14.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface GameTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) Game *game;

@end
