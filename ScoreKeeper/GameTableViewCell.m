//
//  GameTableViewCell.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-14.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "GameTableViewCell.h"
#import "GameController.h"

@interface GameTableViewCell () <UITextFieldDelegate>

@end

static NSString * const gameNameKey = @"gameName";
static NSString * const playersKey = @"players";
static NSString * const gamesKey = @"games";

@implementation GameTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.textField setTintColor:[UIColor orangeColor]];
    self.textField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    [self save];
    return YES;
}

- (void)save {
    
    if (self.game) {
        self.game.title = self.textField.text;
        [[GameController sharedInstance] synchronize];
    } else {
        [[GameController sharedInstance] addGameWithTitle:self.textField.text];
    }
}

@end
