//
//  CalculatorBrain.m
//  iCalculate
//
//  Created by Eric Holmes on 12-06-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain


@synthesize operandStack = _operandStack;
@synthesize commandStack = _commandStack;

// *** Getters/Setters ***

- (NSMutableArray *)operandStack
{ // getter for operandStack
    if(!_operandStack) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}


- (void)setOperandStack:(NSMutableArray *)operandStack
{ // setter for operandStack
    _operandStack = operandStack;
}

// *** Methods ***

- (void)pushOperand:(double)operand
{ // add a new operand to the operand stack
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (void)pushCommand:(NSString *)command
{
    [self.commandStack addObject:command];
}

- (double) popOperand
{ // remove and return the last operand in the stack
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (void) resetToDefault
{
    [self.operandStack removeAllObjects];
    
}

- (double)performOperation:(NSString *)operation
{
    // perform an operation (ex. +/-/div/mult)
    double result = 0;
    
    //check if there is only one item in the operand array
    if (self.operandStack.count > 1) {
        //calculate result
        
        // Depending on the operation given, perform that operation
        if([operation isEqualToString:@"+"]) {
            // Remove operands from stack in order conducive to performing operations
            double secondOperand = [self popOperand];
            double firstOperand = [self popOperand];
            result =  firstOperand + secondOperand;
            NSLog(@"%f + %f", firstOperand, secondOperand);
        } else if ([operation isEqualToString:@"-"]) {
            // Remove operands from stack in order conducive to performing operations
            double secondOperand = [self popOperand];
            double firstOperand = [self popOperand];
            result =  firstOperand - secondOperand;
            NSLog(@"%f - %f", firstOperand, secondOperand);
        } else if ([operation isEqualToString:@"*"]) {
            // Remove operands from stack in order conducive to performing operations
            double secondOperand = [self popOperand];
            double firstOperand = [self popOperand];
            result =  firstOperand * secondOperand;
            NSLog(@"%f * %f", firstOperand, secondOperand);
        } else if ([operation isEqualToString:@"/"] && 
                   [[self.operandStack objectAtIndex:(self.operandStack.count - 1)] doubleValue] != 0) {
            // If the denominator != zero, then the operation will be performed.
            // Otherwise, the result will be zero (as is the default return value.)
            double secondOperand = [self popOperand];
            double firstOperand = [self popOperand];
            result =  firstOperand / secondOperand;
            NSLog(@"%f / %f", firstOperand, secondOperand);
        } 
    } else if ([operation isEqualToString:@"sin"]) {
        double operand = [self popOperand];
        result = sin(operand);
        NSLog(@"NOTE: sin %f = %f", operand, result);
    } else if ([operation isEqualToString:@"cos"]) {
        double operand = [self popOperand];
        result = cos(operand);
    } else {
        // not enough operands to perform calculation, result is the singular operand on the stack
        result = [self popOperand];
        NSLog(@"NOTE: One or less operands present in operandStack.");
    }
    return result;
}


@end
