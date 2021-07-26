//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by J on 2021/7/11.
//

#import "CardMatchingGame.h"
#import "Deck.h"
#import "Card.h"
#import "Logger.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // Cards
@property (nonatomic, readwrite) Logger *logger;
@end

@implementation CardMatchingGame

@synthesize cards = _cards;
@synthesize gameMode = _gameMode;

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (cardMatchingGameMode)gameMode {
    return (!_gameMode) ? cardMatchingGameModeBiCardsMode : _gameMode;
}

- (void)alterGameMode:(cardMatchingGameMode)gameMode {
    // mode should be
    // 0: 2 - cards match
    // 1: 3 - cards match
    if (gameMode < 0 || gameMode > cardMatchingGameModeLastGameModeValue) return;
    _gameMode = gameMode;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init]; // super's designated initializer
    
    [Logger setLoggerLevel:logLevelDebug];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil; // return nil if out of range
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];

    if (card.isMatched) return;

    if (card.isChosen) {
        card.chosen = NO;
        return;
    }

    [self checkMatchingCards:card];

    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
}

- (void)checkMatchingCards:(Card *)selectedCard {
    __block NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
    
    [self.cards
     enumerateObjectsUsingBlock:
     ^(Card *otherCard, NSUInteger index, BOOL *stop){
        if (!otherCard.isChosen || otherCard.isMatched) return;

        // Found a face-up card
        [faceUpCards addObject:otherCard];
        if (self.gameMode == cardMatchingGameModeBiCardsMode) *stop = TRUE;
        
        if (self.gameMode == cardMatchingGameModeTriCardsMode && [faceUpCards count] == 2) *stop = TRUE;
    }];
    
    // if no face-up card found
    if ([faceUpCards count] == 0) {
        [Logger Debug:[NSString stringWithFormat:@"No other face-up card found. Card: %@", selectedCard]];
        return;
    }
    // if in tri-cards mode and only 2 cards face up
    if (self.gameMode == cardMatchingGameModeTriCardsMode && [faceUpCards count] == 1) {
        [Logger Debug:[NSString stringWithFormat:@"Only one face-up card found. One more card needed. Card: %@", selectedCard]];
        return;
    }
    
    NSInteger matchScore = [selectedCard match:faceUpCards];
    
    if (matchScore) {
        self.score += matchScore * MATCH_BONUS;
        for (Card *otherCard in faceUpCards) otherCard.matched = YES;
        selectedCard.matched = YES;
        return;
    }
        
    self.score -= MISMATCH_PENALTY;
    for (Card *otherCard in faceUpCards) otherCard.chosen = NO;
}

@end
