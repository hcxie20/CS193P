//
//  PlayingCard.m
//  Matchismo
//
//  Created by XIE haochen on 5/26/21.
//
#import "PlayingCard.h"

#import <Foundation/Foundation.h>
#import "Logger.h"

@implementation PlayingCard

@synthesize suit = _suit;

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7",
             @"8", @"9", @"10",@"J", @"Q", @"K"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%lu %@", (unsigned long)self.rank, self.suit];
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank]
              stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♥️", @"♦️", @"♠️", @"♣️"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank {
   return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if (![otherCards count]) {
        [Logger Info:[NSString stringWithFormat:@"No other Cards found for %@", self]];
        return score;
    }
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards objectAtIndex:0];
        
        if (otherCard.rank == self.rank) {
            score = 4;
            [Logger Info:[NSString stringWithFormat:@"Found rank match: %@ to %@, Score 4.", otherCard, self]];
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
            [Logger Info:[NSString stringWithFormat:@"Found suit match: %@ to %@, Score 1.", otherCard, self]];
        }
        
        return score;
    }
    
    // match 2 or more cards:
    int suitMatch = 0;
    int rankMatch = 0;
    
    for (PlayingCard* otherCard in otherCards) {
        if (otherCard.rank == self.rank) rankMatch += 1;
        if (otherCard.suit == self.suit) suitMatch += 1;
    }
    
    score = rankMatch * 4 + suitMatch * 1;
    [Logger Info:[NSString stringWithFormat:@"Found match: %@ to %@, rankMatch %d, suitMatch %d, Score %d", otherCards, self, rankMatch, suitMatch, score]];
    
    return score;
}

@end
