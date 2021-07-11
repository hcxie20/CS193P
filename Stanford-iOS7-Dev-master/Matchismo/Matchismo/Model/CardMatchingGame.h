//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Mark Lewis on 15-7-20.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//  游戏逻辑封装到模型中

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@end
