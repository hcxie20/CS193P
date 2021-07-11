//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Mark Lewis on 15-5-30.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()

//@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
//@property (nonatomic) int flipCount;
//@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic, copy) NSMutableString *state;
@end

@implementation CardGameViewController

// lazy loading methods
- (Deck *)createDeck // abstract
{
    return nil;
}
- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    
    return _game;
}

- (NSMutableString *)state
{
    if(!_state) _state = [NSMutableString stringWithCapacity:100];
    return _state;
}
// lazy loading methods




- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:(card.isChosen ? @"cardfront" : @"cardback")];
}
- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d" ,(int)_game.score];
    }
    

}
- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
    static NSString *title;
    if([self.game cardAtIndex:chosenButtonIndex].isChosen)
    {
        title = [sender titleForState:UIControlStateNormal];
        self.state = [NSMutableString stringWithFormat:@"已选择%@\n" ,title];
    }
    else
    {
        self.state = [NSMutableString stringWithFormat:@"取消选择%@\n" ,title];
    }
    if(_state) NSLog(@"%@" ,_state);
}

/* 旧版方法touchCardButton:(UIButton *)sender
 if (sender.currentTitle.length)
 {
 [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
 forState:UIControlStateNormal];
 [sender setTitle:@"" forState:UIControlStateNormal];
 self.flipCount++;
 }
 else
 {
 Card *randomCard = [self.deck drawRandomCard];
 if (randomCard)
 {
 [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
 forState:UIControlStateNormal];
 [sender setTitle:randomCard.contents forState:UIControlStateNormal];
 self.flipCount++;
 }
 
 }
 
 // NSLog(@"%d", self.flipCount);
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 三元运算符测试
    // NSString *suit;
    // suit = @"1";
    // NSLog(@"%@", suit? suit:@"?");
    
    // NSLog(@"%@\n%@" ,[CardMatchingGame class],[self.game class]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setFlipCount:(int)flipCount
//{
//    _flipCount = flipCount;
//    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
//}
@end
