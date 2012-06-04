//
//  HangManMind.h
//  HangMan
//
//  Created by mahesh gattani on 04/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HangManMind : NSObject
@property (nonatomic, strong) NSString *word;

-(NSMutableArray*) getPositionsOfWord:(NSString* )word;  
-(NSString*) getRandomWord;

@end
