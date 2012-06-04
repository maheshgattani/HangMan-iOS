//
//  HangManMind.m
//  HangMan
//
//  Created by mahesh gattani on 04/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HangManMind.h"

@interface HangManMind()
@property (nonatomic, weak) NSArray *allWords;
@end

@implementation HangManMind

@synthesize word = _word;
@synthesize allWords = _allWords;

-(NSString*) word
{
    if(!_word){
        _word = self.getRandomWord;
    }
    return _word;
}

-(NSArray*) allWords
{
    if(!_allWords){
        //read from json file
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"wordlist" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        _allWords = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    }
    return _allWords;
}

-(NSString*) getRandomWord
{
    int randomIndex = arc4random() % [self.allWords count];
    self.word = [self.allWords objectAtIndex:randomIndex];
    return [self.allWords objectAtIndex:randomIndex];
}

-(NSMutableArray*) getPositionsOfWord:(NSString* )word
{
    NSMutableArray* retArr = [[NSMutableArray alloc] init];
    NSUInteger length = [self.word length];
    for(NSInteger i = 0; i < length; i++){
        NSRange range = NSMakeRange(i, 1);
        NSString* c =  [self.word substringWithRange:range];
        if([c compare:word] == NSOrderedSame ){
            [retArr addObject:[NSNumber numberWithInteger:i]];
        }
    }
    return retArr;
}

@end
