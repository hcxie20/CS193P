//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Mark Lewis on 15-7-20.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
// readwrite是默认的参数,这个只使用在重新声明公共中的只读属性为private的readwrite属性
@property (nonatomic, readwrite) NSInteger score;
// 这里的score和头文件中的score是相同的,但是只有在.m文件实现里能调用setter
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

// designated initializer 指定初始化器，复习第十章
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self)
    {
        for (int i = 0;i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if(card)
            {
                [self.cards addObject:card];
                // lazy initialize,再给已经初始化的空数组添加元素
            }
            else // deck空了
            {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}
- (instancetype)init
{
    return nil;
}

// #define MISMATCH_PENALTY 1
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

// 这个方法是游戏逻辑的核心
- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (! card.isMatched)
    {
        if (card.isChosen)
        {
            card.chosen = NO; // 第二次选择就取消选择
        }
        else // 玩家选择了这张牌，但是没有匹配
        {
           // match against another car
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    int matchScore = [card match:@[otherCard]];
                     // 如果没有匹配match方法返回0，表示完全匹配上
                    if (matchScore) // 匹配上了
                    {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }
                    else // 没有匹配上
                    {
                        // 没有匹配上要扣分
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break; // 选择了第二张就跳出循环

                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
@end
