//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by XIE haochen on 2021/8/1.
//

#import <Foundation/Foundation.h>

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()
@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
