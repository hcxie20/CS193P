//
//  PlayingCard.h
//  Matchismo
//
//  Created by XIE haochen on 5/26/21.
//

#ifndef PlayingCard_h
#define PlayingCard_h

#import "Card.h"

@interface PlayingCard:Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end

#endif /* PlayingCard_h */
