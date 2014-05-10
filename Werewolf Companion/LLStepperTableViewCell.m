//
//  LLStepperTableViewCell.m
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LLStepperTableViewCell.h"

@implementation LLStepperTableViewCell

- (IBAction)valueChanged:(UIStepper *)sender
{
    int value = (int)[sender value];
    [self.delegate setValue:value forRole:self.roleLabel.text];
    [self.numberLabel setText:[NSString stringWithFormat:@"%d", value]];   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:NO];

    // Configure the view for the selected state
}

@end
