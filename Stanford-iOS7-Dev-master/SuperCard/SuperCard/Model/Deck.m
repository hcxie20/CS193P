//
//  Deck.m
//  Matchismo
//
//  Created by Mark Lewis on 15-5-30.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "Deck.h"

@interface Deck ()
@property (strong, nonatomic)NSMutableArray *cards;
@end


@implementation Deck
- (NSMutableArray *)cards
{
    // 延时加载(懒加载) lazy loading
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop)
    {
        [self.cards insertObject:card atIndex:0];
    }
    else
    {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil; // 学习好的设计,如果处理错误也能返回nil来表示。而且给nil发消息相当于空消息
    
    if ([self.cards count])
    {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}
@end
