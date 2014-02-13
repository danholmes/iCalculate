//
//  CalculatorViewController.m
//  iCalculate
//
//  Created by Eric Holmes on 12-05-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumber;
@property (nonatomic) BOOL resultCurrentlyBeingDisplayed;
@property (nonatomic, strong) NSString *command;
@property (nonatomic, strong) NSString *firstEnteredNumber;
@property (nonatomic, strong) NSString *secondEnteredNumber;
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@property (nonatomic) double memoryValue;

/*

@property (nonatomic, strong) NSString *thirdEnteredNumber;

@property (nonatomic, strong) NSString *firstCommand;
@property (nonatomic, strong) NSString *secondCommand;
@property (nonatomic, strong) NSString *thirdCommand;
 */

- (NSString *) doubleToString:(double) val;
- (void) performOperation;
//- (void) operationPressed:(NSString *)operation;
//- (void) pushOperand:(NSString *)operand;
@end



@implementation CalculatorViewController
@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringNumber = _userIsInTheMiddleOfEnteringNumber;
@synthesize command = _command;
@synthesize firstEnteredNumber = _firstEnteredNumber;
@synthesize secondEnteredNumber = _secondEnteredNumber;
@synthesize historyTextView = _historyTextView;
@synthesize resultCurrentlyBeingDisplayed;
@synthesize memoryValue;

/*
@synthesize firstCommand = _firstCommand;
@synthesize secondCommand = _secondCommand;
@synthesize thirdCommand = _thirdCommand;


@synthesize thirdEnteredNumber = _thirdEnteredNumber;
*/


- (IBAction)buttonPressed:(UIButton *)sender 
{
    NSString *buttonTitle = sender.currentTitle;
    if ([buttonTitle isEqualToString:@"clear"]) 
    {
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringNumber = NO;
    } else if ([buttonTitle isEqualToString:@"minus"])
    {
        double currentDisplayValue = self.display.text.doubleValue;
        currentDisplayValue *= -1;
        if (currentDisplayValue != -0)
        {
            self.display.text = [self doubleToString:currentDisplayValue];
        } else if ([self.display.text isEqualToString:@"0"]){
            self.display.text = @"-0";
        } else if ([self.display.text isEqualToString:@"-0"]){
            self.display.text = @"0";
        } else if ([self.display.text isEqualToString:@"0."]){
            self.display.text = @"-0.";
        } else if ([self.display.text isEqualToString:@"-0."]){
            self.display.text = @"0.";
        }
    } else if ( (self.firstEnteredNumber == nil || [self.firstEnteredNumber isEqualToString:@""]) &&
               ([buttonTitle isEqualToString:@"add"] ||
                [buttonTitle isEqualToString:@"subtract"] ||
                [buttonTitle isEqualToString:@"multiply"] ||
                [buttonTitle isEqualToString:@"divide"] )  ) 
    {
        self.firstEnteredNumber = self.display.text;
        self.command = buttonTitle;
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringNumber = NO;
    } else if ( (self.firstEnteredNumber != nil && ![self.firstEnteredNumber isEqualToString:@""]) &&
                ([buttonTitle isEqualToString:@"add"] ||
                [buttonTitle isEqualToString:@"subtract"] ||
                [buttonTitle isEqualToString:@"multiply"] ||
                [buttonTitle isEqualToString:@"divide"] ||
                [buttonTitle isEqualToString:@"equals"])) 
    {
        self.secondEnteredNumber = self.display.text;
        [self performOperation];
    } else if ([sender.currentTitle isEqualToString:@"mr"]) 
    {
        self.display.text = [NSString stringWithFormat:@"%f", self.memoryValue];
        
    }else if ([sender.currentTitle isEqualToString:@"mc"]) 
    {
        self.memoryValue = 0;
    }else if ([sender.currentTitle isEqualToString:@"mplus"]) 
    {
        self.memoryValue += self.display.text.doubleValue;
    }
}

- (void) performOperation
{
    
    double result = 0;
    if ([self.command isEqualToString:@"add"]) { // **** ADDITION ****
        double result = self.firstEnteredNumber.doubleValue + self.secondEnteredNumber.doubleValue;
        self.display.text = [NSString stringWithFormat:@"%f", result];
        
        if ([self.historyTextView.text isEqualToString:@"(No History)"]) { self.historyTextView.text = @""; }
        NSString *newHistoryLine = @"";
        newHistoryLine = [newHistoryLine stringByAppendingString:self.firstEnteredNumber];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@" + "];
        newHistoryLine = [newHistoryLine stringByAppendingString:self.secondEnteredNumber];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@" = "];
        newHistoryLine = [newHistoryLine stringByAppendingString:self.display.text];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@"\n"];
        self.historyTextView.text = [newHistoryLine stringByAppendingString:self.historyTextView.text];
        NSRange rangeOfNewestStringAdded = rangeOfNewestStringAdded = [self.historyTextView.text rangeOfString:newHistoryLine];
        [self.historyTextView scrollRangeToVisible:rangeOfNewestStringAdded];
        self.firstEnteredNumber = @"";
        
    } else if([self.command isEqualToString:@"subtract"]) { // **** SUBTRACTION ****
        double result = self.firstEnteredNumber.doubleValue - self.secondEnteredNumber.doubleValue;
        self.display.text = [NSString stringWithFormat:@"%f", result];
        
        if ([self.historyTextView.text isEqualToString:@"(No History)"]) { self.historyTextView.text = @""; }
        NSString *newHistoryLine = @"";
        newHistoryLine = [newHistoryLine stringByAppendingString:self.firstEnteredNumber];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@" - "];
        newHistoryLine = [newHistoryLine stringByAppendingString:self.secondEnteredNumber];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@" = "];
        newHistoryLine = [newHistoryLine stringByAppendingString:self.display.text];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@"\n"];
        self.historyTextView.text = [newHistoryLine stringByAppendingString:self.historyTextView.text];
        NSRange rangeOfNewestStringAdded = rangeOfNewestStringAdded = [self.historyTextView.text rangeOfString:newHistoryLine];
        [self.historyTextView scrollRangeToVisible:rangeOfNewestStringAdded];
        self.firstEnteredNumber = @"";
    } else if([self.command isEqualToString:@"multiply"]) { // **** MULTIPLICATION ****
        double result = self.firstEnteredNumber.doubleValue * self.secondEnteredNumber.doubleValue;
        self.display.text = [NSString stringWithFormat:@"%f", result];
        
        if ([self.historyTextView.text isEqualToString:@"(No History)"]) { self.historyTextView.text = @""; }
        NSString *newHistoryLine = @"";
        newHistoryLine = [newHistoryLine stringByAppendingString:self.firstEnteredNumber];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@" * "];
        newHistoryLine = [newHistoryLine stringByAppendingString:self.secondEnteredNumber];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@" = "];
        newHistoryLine = [newHistoryLine stringByAppendingString:self.display.text];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@"\n"];
        self.historyTextView.text = [newHistoryLine stringByAppendingString:self.historyTextView.text];
        NSRange rangeOfNewestStringAdded = rangeOfNewestStringAdded = [self.historyTextView.text rangeOfString:newHistoryLine];
        [self.historyTextView scrollRangeToVisible:rangeOfNewestStringAdded];
        self.firstEnteredNumber = @"";
    } else if([self.command isEqualToString:@"divide"]) { // **** DIVISION ****
        double result = self.firstEnteredNumber.doubleValue / self.secondEnteredNumber.doubleValue;
        self.display.text = [NSString stringWithFormat:@"%f", result];
        
        if ([self.historyTextView.text isEqualToString:@"(No History)"]) { self.historyTextView.text = @""; }
        NSString *newHistoryLine = @"";
        newHistoryLine = [newHistoryLine stringByAppendingString:self.firstEnteredNumber];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@" / "];
        newHistoryLine = [newHistoryLine stringByAppendingString:self.secondEnteredNumber];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@" = "];
        newHistoryLine = [newHistoryLine stringByAppendingString:self.display.text];
        newHistoryLine = [newHistoryLine stringByAppendingFormat:@"\n"];
        self.historyTextView.text = [newHistoryLine stringByAppendingString:self.historyTextView.text];
        NSRange rangeOfNewestStringAdded = rangeOfNewestStringAdded = [self.historyTextView.text rangeOfString:newHistoryLine];
        [self.historyTextView scrollRangeToVisible:rangeOfNewestStringAdded];
        self.firstEnteredNumber = @"";
    } 
}


/*
- (void) pushOperand:(NSString *) operand 
{
    
}

- (void) operationPressed:(NSString *)operation
{
    double result = 0;
    if([self.firstCommand isEqualToString:@""] ||
       self.firstCommand == nil)
    {
        if([operation isEqualToString:@"plus"])
        {
            self.firstCommand = @"plus";
        } else if ([operation isEqualToString:@"subtract"])
        {
            self.firstCommand = @"subtract";
        } else if ([operation isEqualToString:@"multiply"])
        {
            self.firstCommand = @"multiply";
        } else if ([operation isEqualToString:@"divide"])
        {
            self.firstCommand = @"divide";
        }
    } else if ((![self.firstCommand isEqualToString:@""] ||
                self.firstCommand != nil) && ([self.thirdCommand isEqualToString:@""] ||
                                               self.thirdCommand == nil))
    {
        if([self.firstCommand isEqualToString:@"plus"] ||
           [self.firstCommand isEqualToString:@"subtract"])
        {
            if([self.secondCommand isEqualToString:@"plus"] ||
               [self.secondCommand isEqualToString:@"subtract"])
            {
                
            }
        }
    }
}
 */

- (IBAction)digitPressed:(UIButton *)sender 
{
    
    NSString *digit = sender.currentTitle;
    if (![sender.currentTitle isEqualToString:@"equals"]){
        if (self.userIsInTheMiddleOfEnteringNumber)
        { // if the user is in the middle of entering a number
            if ([digit isEqualToString:@"."] != YES) {
                self.display.text = [self.display.text stringByAppendingFormat:digit];
            } else if ([self.display.text rangeOfString:@"."].location == NSNotFound)  {
                if ([self.display.text isEqualToString:@"0"] == YES &&
                      [digit isEqualToString:@"0"])
                { 
                    // do nothing at all
                } else {
                    self.display.text = [self.display.text stringByAppendingFormat:digit];
                }
            }
        } else
        { // if the user has yet to enter a digit/number
            if ([digit isEqualToString:@"."] == NO) 
            { // if the digit the user is entering IS NOT a dot (.)
                self.userIsInTheMiddleOfEnteringNumber = YES;
                
                if ([self.display.text isEqualToString:@"-0"])
                {
                    self.display.text = @"-";
                    self.display.text = [self.display.text stringByAppendingFormat:digit];
                } else if ([self.display.text isEqualToString:@"-0."])
                {
                    self.display.text = [self.display.text stringByAppendingFormat:digit];
                } else 
                {
                    self.display.text = digit;
                }
                
            } else { // else the digit the user is entering IS a dot (.)
                // add the dot on the end:
                self.userIsInTheMiddleOfEnteringNumber = YES;
                self.display.text = [self.display.text stringByAppendingFormat:digit];
            }
        }
    } else {
        [self buttonPressed:sender];
    }
}


- (NSString *) doubleToString:(double) val {
	NSString *ret = [NSString stringWithFormat:@"%f", val];
	unichar c = [ret characterAtIndex:[ret length] - 1];
	while (c == 48 || c == 46) { // 0 or .
		ret = [ret substringToIndex:[ret length] - 1];
		c = [ret characterAtIndex:[ret length] - 1];
	}
	return ret;
}


- (void)viewDidUnload {
    [self setDisplay:nil];
    [self setHistoryTextView:nil];
    [super viewDidUnload];
}
@end
