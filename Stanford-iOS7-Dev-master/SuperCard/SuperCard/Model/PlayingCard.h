//
//  PlayingCard.h
//  Matchismo
//
//  Created by Mark Lewis on 15-5-30.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic, strong) NSString *suit; // 花色
@property (nonatomic) NSUInteger rank; // 数字

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
