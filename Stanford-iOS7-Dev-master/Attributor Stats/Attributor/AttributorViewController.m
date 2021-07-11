//
//  AttributorViewController.m
//  Attributor
//
//  Created by Mark Lewis on 15-7-26.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "AttributorViewController.h"
#import "TextStatsViewController.h"

@interface AttributorViewController ()

// @property (weak, nonatomic) IBOutlet UILabel *headLine; // titleLabel
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@end

@implementation AttributorViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Analyze Text"])
    {
        if ([segue.destinationViewController isKindOfClass:[TextStatsViewController class]])
        {
            TextStatsViewController *destinationVC= segue.destinationViewController;
            destinationVC.textToAnalyze = _body.textStorage;
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // UITextView 在设置字体时要小心，因为设置后之前的字体属性会失效

    NSMutableAttributedString *styleTitle = [[NSMutableAttributedString alloc] initWithString:_outlineButton.currentTitle];
    [styleTitle setAttributes:@{NSStrokeWidthAttributeName : @3,
                                NSStrokeColorAttributeName : _outlineButton.tintColor}
                        range:NSMakeRange(0, styleTitle.length)];
    
    [self.outlineButton setAttributedTitle:styleTitle forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated]; // 调用父类的方法，先后调用取决于操作的先后
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil]; // nil代表不限制广播的发送者
}


-(void)preferredFontsChanged:(NSNotification *)notification
{
    [self usePreferredFonts];
}

- (void)usePreferredFonts
{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}


- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender
{
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
    NSLog(@"%@", _body.selectedTextRange);
    
}
- (IBAction)outlineBodySelection:(id)sender
{
    // 描边宽度为负数才会填充，正数的话文字就会变成空心的
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName : @-3,
                                           NSStrokeColorAttributeName : [UIColor blackColor] }
                                   range:self.body.selectedRange];
}
- (IBAction)unoutlineBodySelection:(id)sender
{
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
    // 移除这个属性
    
//    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName : @0,
//                                           NSStrokeColorAttributeName : [UIColor blackColor] }
//                                   range:self.body.selectedRange];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 其他情况下不要使用该方法 ，这里是处理unsafe retained指针
    // [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
