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
#import "Logger.h"

// shoule be in another file
typedef NS_ENUM(NSInteger, cardMatchingGameMode) {
    cardMatchingGameModeBiCardsMode,
    cardMatchingGameModeTriCardsMode,
    cardMatchingGameModeLastGameModeValue = cardMatchingGameModeTriCardsMode
};

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
-(void)alterGameMode:(cardMatchingGameMode)gameMode;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readwrite) cardMatchingGameMode gameMode;
@property (nonatomic, readwrite) Logger *logger;
@end

#endif /* Model_CardMatchingGame_h */
