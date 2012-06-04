//
//  HangManViewController.m
//  HangMan
//
//  Created by mahesh gattani on 04/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HangManViewController.h"

@interface HangManViewController ()
@property NSInteger faults;
@property (weak, nonatomic) IBOutlet UILabel *word;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic) NSInteger solved;
@end

@implementation HangManViewController
@synthesize mind = _mind;
@synthesize faults = _faults;
@synthesize word = _word;
@synthesize solved = _solved;
@synthesize image = _image;

- (HangManMind*) mind
{
    if(!_mind){
        _mind = [[HangManMind alloc] init];
    }
    return _mind;
}

- (void)presentInfo
{
    NSString *info = @"Try to guess the random word given to you with maximum 7 wrong attempts. Enjoy :)";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"HANGMAN" 
                                                        message:info 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
    
    [alertView show];
}

- (IBAction)StartGame:(UIButton *)sender 
{
    [sender setHidden:YES];
    [self newGame];
}

- (IBAction)Restart:(UIButton *)sender {
    [self newGame];    
}

- (void) newGame
{
    self.faults = 0;
    self.solved = 0;

    NSMutableString* s = [NSMutableString stringWithFormat:@""];
    NSString* imageName = [NSString stringWithFormat:@"hangman0.jpg"];
    [self.image setImage:[UIImage imageNamed:imageName]]; 
    
    NSString *test_word = [[self mind] getRandomWord];
    NSLog(@"%@", test_word);
    NSInteger length = [test_word length];
    for (NSInteger i = 0; i < length; i++) {
        [s appendFormat:@"_ "];        
    }
    [self.word setText:s];    
}

- (IBAction)Info:(id)sender {
    [self presentInfo];
}

- (IBAction)characterPressed:(UIButton *)sender 
{
    NSString *character = [sender currentTitle];        
    NSMutableArray *retval = [self.mind getPositionsOfWord:character];
    NSLog(@"%d", [retval count]);
    NSString* label = [self.word text];
    
    if ([retval count] == 0) {
        self.faults += 1;
        [self imageFailue];
        if(self.faults == 7){
            NSLog(@"LOST");
            NSString* message = [NSString stringWithFormat:@"You Lost!"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!!" 
                                                            message:message 
                                                           delegate:self
                                                  cancelButtonTitle:@"New Game"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    }
    else {
        for (NSUInteger i = 0; i < [retval count]; i++) {
            NSNumber *index = [retval objectAtIndex:i];
            NSRange range = NSMakeRange(2*([index intValue]+1) - 2, 1);
            label = [label stringByReplacingCharactersInRange:range withString:character];
        }
        self.solved += [retval count];
        [self.word setText:label];
        if (self.solved == [[[self mind] word] length]) {
            NSLog(@"SOLVED!");
            NSString* message = [NSString stringWithFormat:@"Congratulations"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Winner!!" 
                                                            message:message 
                                                           delegate:self
                                                  cancelButtonTitle:@"New Game"
                                                  otherButtonTitles:nil];
            [alert show];

        }
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self newGame];
}

- (void) imageFailue
{
    NSString* imageName = [NSString stringWithFormat:@"hangman%d.jpg", self.faults];
    [self.image setImage:[UIImage imageNamed:imageName]]; 
}

- (void)viewDidUnload {
    [self setWord:nil];
    [self setImage:nil];
    [self setWord:nil];
    [self setWord:nil];
    [super viewDidUnload];
}
@end
