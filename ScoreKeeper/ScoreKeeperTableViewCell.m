//
//  ScoreKeeperTableViewCell.m
//  ScoreKeeper
//
//  Created by sombra on 2015-02-06.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import "ScoreKeeperTableViewCell.h"

static CGFloat margin = 15;
static CGFloat height = 30;

@interface ScoreKeeperTableViewCell() <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UIStepper *stepper;

@end

@implementation ScoreKeeperTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    // set the background color of the cell
    self.backgroundColor = [UIColor whiteColor];
    
    // UITextField to input name
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(margin, 10, 110, height)];
    self.nameField.placeholder = @"name";
    self.nameField.textColor = [UIColor orangeColor];
    self.nameField.delegate = self;
    [self.contentView addSubview:self.nameField];
    
    // UILabel to display the score
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 + margin, 10, 40, height)];
    self.scoreLabel.text = @"0";
    self.scoreLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:self.scoreLabel];
    
    // UIStepper to increment/decrement the score/value
    self.stepper = [[UIStepper alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - margin * 4, 10, 20, height)];
    self.stepper.minimumValue = 0;
    self.stepper.maximumValue = 1000;
    self.stepper.tintColor = [UIColor orangeColor];
    [self.stepper addTarget:self action:@selector(scoreStepper:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.stepper];
    
    
    return self;
}

// method to set editing style
- (UITableViewCellEditingStyle)editingStyle {
    return UITableViewCellEditingStyleDelete;
}

// add target action method for UIStepper
- (void)scoreStepper:(UIStepper *)sender {
    UIStepper *stepper = sender;
    double stepperValue = stepper.value;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", (int) stepperValue];
}

#pragma UITextFieldDelegate method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
