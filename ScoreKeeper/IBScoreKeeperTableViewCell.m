//
//  IBScoreKeeperTableViewCell.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-09.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "IBScoreKeeperTableViewCell.h"
#import "PlayerController.h"

@interface IBScoreKeeperTableViewCell () <UITextFieldDelegate>

@end

static NSString * const nameKey = @"name";
static NSString * const scoreKey = @"score";

@implementation IBScoreKeeperTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.textField.tintColor = [UIColor orangeColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)scoreStepper:(id)sender {
    self.stepper = sender;
    double stepperValue = self.stepper.value;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", (int) stepperValue];
    [self save];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    
    return YES;
}

- (void)save {
    
    Player *player = [[Player alloc] initWithDictionary:@{nameKey: self.textField.text, scoreKey: [NSString stringWithFormat:@"%d", (int) self.stepper.value]}];
    
    if (self.player) {
        [[PlayerController sharedInstance] replacePlayer:self.player withPlayer:player];
    } else {
        [[PlayerController sharedInstance] addPlayer:player];
    }
//    self.player = player;

}

@end
