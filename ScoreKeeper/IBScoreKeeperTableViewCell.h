//
//  IBScoreKeeperTableViewCell.h
//  ScoreKeeper
//
//  Created by sombra on 2015-02-09.
//  Copyright (c) 2015 sombra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@protocol IBScoreKeeperTableViewCellDelegate;

@interface IBScoreKeeperTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (nonatomic, strong) Player *player;
@property (nonatomic, weak) id<IBScoreKeeperTableViewCellDelegate>delegate;

@end

@protocol IBScoreKeeperTableViewCellDelegate <NSObject>

- (void)valueChangedForCellStepper:(UIStepper *)stepper cell:(IBScoreKeeperTableViewCell *)cell;

@end