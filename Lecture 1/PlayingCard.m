#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7",
             @"8", @"9", @"10",@"J", @"Q", @"K"];
}

- (NSString *) contents
{
    /*return [NSString stringWithFormat:@"%d%@", 
            self.rank, self.suit];*/
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] 
              stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"heart", @"diamond", @"spade", @"club"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank {
   return [[self rankStrings] count] - 1; 
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= PlayingCard maxRank]) {
        _rank = rank;
    }
}

