#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)singleMatch:(Card *)card
{
    int score = 0; // Actually all those are initialized 0

    /*
      Message sender: dot notation and open square brackets
      Dot: used for access properties ONLY. (Warning)
        card.contents actually call getter of the contents
        property on the card instance
        card.contents = @"some string" calls the setter
      Open square brackets: call for method.
        Notice that in this way you can also access setter
        and getter notation.
    */
    if ([card.contents isEqualToString:self.contents]) {
        score = 1;
    }

    return score;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;

    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }

    return score;
}

// All following codes are hidden
/*
- (BOOL) isChosen
{
    return _chosen;
}

- (void)setChosen:(BOOL)chosen
{
    _chosen = chosen;
}

- (BOOL) isMatched
{
    return matched;
}

- (void)setMatched:(BOOL)matched
{
    _matched = matched;
}

@synthesize contents = _contents;
- (NSString *)contents
{
    return _contents;
}

- (void) setContents:(NSString *)contents
{
    _contents = contents;
}
*/
