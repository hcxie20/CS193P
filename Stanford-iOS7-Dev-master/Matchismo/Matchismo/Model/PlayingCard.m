//
//  PlayingCard.m
//  Matchismo
//
//  Created by Mark Lewis on 15-5-30.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
+ (NSArray *)validSuits
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}



- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == 1) //只匹配两张牌
    {
        id card = [otherCards firstObject];
        if ([card isKindOfClass:[PlayingCard class]])
        {
            PlayingCard *otherCard = (PlayingCard *)card; //如果数组为空array[0]会导致崩溃
            if ([self.suit isEqualToString:otherCard.suit])
            {
                score = 1;
            }
            else if(self.rank == otherCard.rank)
            {
                score = 4;
            }
        }

    }
    
    return score;
}

@synthesize suit = _suit; // Because we provide setter AND getter
                          // don't have _suit instance variable

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
        
}
@end
