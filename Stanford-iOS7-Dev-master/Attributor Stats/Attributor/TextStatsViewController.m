//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Mark Lewis on 15-7-31.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineCharactersLabel;
@end

@implementation TextStatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"SecondMVC test"
                                                         attributes:@{NSForegroundColorAttributeName : [UIColor greenColor],NSStrokeWidthAttributeName : @-3}
                          ];*/
}
// 使用viewDidLoad来测试新添加的MVC是否正常工作，viewDidLoad为model提供假数据

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if(self.view.window) [self updateUI];
}
// 常用的模式是：在View出现地时候更新UI，否则交给viewWillAppear来更新

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateUI];
}

- (void)updateUI
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colorful characters" ,[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlineCharactersLabel.text = [NSString stringWithFormat:@"%d outline characters" ,[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < _textToAnalyze.length)
    {
        NSRange range;
        id value = [_textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value)
        {
            [characters appendAttributedString:[_textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length; //移动到这个属性范围的下一位
        }
        else
        {
            index++;
        }
    }
    
    return characters;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
