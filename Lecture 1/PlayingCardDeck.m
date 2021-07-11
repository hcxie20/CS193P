#import "PlayingCard.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];

    // if init fails, return nil
    if (self) {
        for [NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rand <= [PlayingCard maxRand]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rand = rank;
                card.suit = suit;
                [self addCard:card];
        }

    }

    return self;
}

@end

