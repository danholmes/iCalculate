//
//  CalculatorBrain.h
//  iCalculate
//
//  Created by Eric Holmes on 12-06-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

@property (nonatomic, strong) NSMutableArray *operandStack;
@property (nonatomic, strong) NSMutableArray *commandStack;

- (void)pushOperand:(double)operand;
- (void) pushCommand:(NSString *)command;
- (double)performOperation:(NSString *)operation;
- (void)resetToDefault;

@end
