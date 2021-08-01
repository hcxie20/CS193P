//
//  UIViewController+TextStatsViewController.m
//  Attributer
//
//  Created by XIE haochen on 2021/8/1.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController
@synthesize textToAnalyze = _textToAnalyze;

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
  _textToAnalyze = textToAnalyze;
  if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
  NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
  
  unsigned long index = 0;
  
  while (index < [self.textToAnalyze length]) {
    NSRange range;
    id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
    
    if (value) {
      [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
      index = range.location + range.length;
    } else {
      index ++;
    }
  }
  
  return characters;
}

- (void)updateUI {
  self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu Colorful Characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
  self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu Outlined Characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

@end
