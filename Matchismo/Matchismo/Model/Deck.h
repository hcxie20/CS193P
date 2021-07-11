//
//  Deck.h
//  Matchismo
//
//  Created by XIE haochen on 6/10/21.
//

#ifndef Deck_h
#define Deck_h

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end


#endif /* Deck_h */
