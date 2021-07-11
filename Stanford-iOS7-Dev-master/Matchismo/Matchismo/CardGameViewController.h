//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Mark Lewis on 15-5-30.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//
// Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

// protected    for subclasses
- (Deck *)createDeck; // abstract

@end
