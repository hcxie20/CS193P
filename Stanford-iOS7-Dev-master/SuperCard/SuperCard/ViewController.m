//
//  ViewController.m
//  SuperCard
//
//  Created by Mark Lewis on 15-8-4.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong ,nonatomic) Deck *deck;
@end


@implementation ViewController

// lazy instance
- (Deck *)deck
{
    if(!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)drawRandomCard
{
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]])
    {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.playingCardView.rank = playingCard.rank;
        self.playingCardView.suit = playingCard.suit;
    }
}


- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    // 当扑克牌是背面时，滑动翻到正面前将random的牌添加上去
    if(!self.playingCardView.faceUp) [self drawRandomCard];
    
    [UIView transitionWithView:self.playingCardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self.playingCardView.faceUp = !self.playingCardView.faceUp;
                    } completion:^(BOOL finished) {
                        
                    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
    
    
    // test code
    self.playingCardView.rank = 13;
    self.playingCardView.suit = @"♥";
    
//    PlayingCardView *view = [[PlayingCardView alloc] init];
//    view.frame = CGRectMake(0, 0,64, 96);
//    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
