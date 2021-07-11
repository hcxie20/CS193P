//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by J on 2021/7/11.
//

#ifndef Model_CardMatchingGame_h
#define Model_CardMatchingGame_h

#import "Foundation/Foundation.h"
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@end


#endif /* Model_CardMatchingGame_h */
