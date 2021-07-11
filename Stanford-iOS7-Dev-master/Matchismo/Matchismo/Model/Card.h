//
//  Card.h
//  Matchismo
//
//  Created by Mark Lewis on 15-5-30.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;
@end
