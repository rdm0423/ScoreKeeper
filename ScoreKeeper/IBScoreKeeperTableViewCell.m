//
//  IBScoreKeeperTableViewCell.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-09.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "IBScoreKeeperTableViewCell.h"

@interface IBScoreKeeperTableViewCell () <UITextFieldDelegate>

@end

@implementation IBScoreKeeperTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)scoreStepper:(id)sender {
    UIStepper *stepper = sender;
    double stepperValue = stepper.value;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", (int) stepperValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

@end
