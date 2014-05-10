//
//  LLStepperTableViewCell.h
//  Werewolf Companion
//
//  Created by Lauren Lee on 5/9/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLStepperTableViewCellProtocol <NSObject>

@optional

- (void)setValue:(int)value forRole:(NSString*)role;

@end

@interface LLStepperTableViewCell : UITableViewCell

@property (unsafe_unretained, nonatomic) id<LLStepperTableViewCellProtocol> delegate;

@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end
