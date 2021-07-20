//
//  ViewController.m
//  Matchismo
//
//  Created by XIE haochen on 5/23/21.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck* deck;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeController;
@end

@implementation ViewController

@synthesize game = _game;
@synthesize deck = _deck;

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    
    return _game;
}

- (Deck *)deck {
    if (!_deck) {
        _deck = [self createDeck];
    }
    
    return _deck;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    [_cardButton setTitle:@"" forState:UIControlStateNormal];
}

- (void)setFlipCount:(int)flipCount{
    // this IS the setter for property flipCount,
    // called every time when self.flipCount++
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
    NSLog(@"flipCount = %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([self.modeController isEnabled]) {
        [self.modeController setEnabled:false];
    }
    
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
    
    self.flipCount++; // calls getter AND setter
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchResetGameButton:(UIButton *)sender {
    _game = [[CardMatchingGame alloc]
           initWithCardCount:[self.cardButtons count]
           usingDeck:[self createDeck]];
    [self updateUI];
    self.flipCount = 0;
    [self.modeController setEnabled:true];
}

// Map UISegmentedControl index to game mode
//+ (NSDictionary *)gameModeMap {
//    return @{
//        @0: gameModeAllowedBiCardsMode,
//        @1: gameModeAllowedTriCardsMode,
//    };
//}

- (IBAction)touchGameModeContorller:(UISegmentedControl *)sender {
    cardMatchingGameMode gameMode = cardMatchingGameModeBiCardsMode;
    
    // todo: Find a way to remove this stupid switch case
    switch ([self.modeController selectedSegmentIndex]) {
        case 0: gameMode = cardMatchingGameModeBiCardsMode;
            break;
        case 1: gameMode = cardMatchingGameModeTriCardsMode;
            break;
    }
    
    [self.game alterGameMode: gameMode];
}


@end
