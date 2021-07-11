#import <Foundation/Foundation.h>

@interface Card:NSObject

@property (strong, nonatomic) NSString *contents;
/*
  strong and week: the pointer for objects stored in heap
  objective-c uses referrence counter like python does.

  strong: count toward counter
  weak: do not count toward referrence counter. When object
        got released, weak pointers will be set nil.
*/

@property (nonatomic, getter=isChosen) BOOL chosen; // No strong or week since this is a primary type
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)singleMatch:(Card *)card;
/*
0: don't match
return higher, match higher
*/

- (int)match:(NSArray *)otherCards;

@end
