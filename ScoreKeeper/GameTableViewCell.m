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
    Game *game = [[Game alloc] initWithDictionary:@{gameNameKey: self.textField.text, playersKey:@[]}];
    
    if (self.game) {
        [[GameController sharedInstance] replaceGame:self.game withGame:game];
    } else {
        [[GameController sharedInstance] addGame:game];
    }
}

@end
