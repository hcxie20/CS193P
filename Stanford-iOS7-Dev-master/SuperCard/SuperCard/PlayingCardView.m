//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Mark Lewis on 15-8-5.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

#pragma mark - Propertys

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}


- (void)setRank:(NSUInteger)rank
{
    if (_rank != rank)
    {
        _rank = rank;
        [self setNeedsDisplay];
    }
}

- (void)setSuit:(NSString *)suit
{
    if (_suit != suit)
    {
        _suit = suit;
        [self setNeedsDisplay];
    }
}

- (void)setFaceUp:(BOOL)faceUp
{
    if (_faceUp != faceUp)
    {
        _faceUp = faceUp;
        [self setNeedsDisplay];
    }
}


#pragma mark - Gesture Recognizer
- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded)
    {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }
}

#pragma mark - Drawing
// 不明白怎么计算出圆角矩形的圆角半径的
#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundRect addClip];
    
    // set fillColor
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    // set stroke
    [[UIColor blackColor] setStroke];
    roundRect.lineWidth = 2.0;
    [roundRect stroke];

    if(self.faceUp)
    {
        // 绘制扑克牌中间的图案
        UIImage *faceImage = [UIImage imageNamed:([NSString stringWithFormat:@"%@%@" ,[self rankAsString] ,self.suit])];
        if(faceImage)
        {
            CGRect imageRect = CGRectInset(self.bounds,
                                           self.bounds.size.width*(1.0 - self.faceCardScaleFactor),
                                           self.bounds.size.height*(1.0 - self.faceCardScaleFactor));
            [faceImage drawInRect:imageRect];
        }
        else
        {
            // 如果不是JQK，就绘制suit的图案
            [self drawPips];
            
        }
        
        // 绘制左上角和右下角
        [self drawCorners];
    }
    else
    {
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

- (void)drawPips
{
    
}

#pragma mark - Corners
// Drawing Corner 绘制边角的牌面
- (void)drawCorners
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:(cornerFont.pointSize *[self cornerScaleFactor])];
    
    NSMutableAttributedString *cornerText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString] ,self.suit]
                                                                                   attributes:@{NSFontAttributeName : cornerFont ,
                                                                                                NSParagraphStyleAttributeName :paragraphStyle}];
    
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = cornerText.size;
    [cornerText drawInRect:textBounds];
    //上下颠倒绘图内容
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI); // 旋转108度，上下颠倒
    [cornerText drawInRect:textBounds]; // 这一行代码将属性字符串绘制到右下角
}

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

#pragma mark - Initialization
- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO; // 设置为透明的View
    self.contentMode = UIViewContentModeRedraw; //当bounds改变时调用drawRect重绘View
}

- (void)awakeFromNib
{
    // 从对象库中拖View到Storyboard，会调用这个初始化函数
    NSLog(@"awakeFronStoryboard");
    [self setup];
}


- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"the initialization method"); // 使用纯代码创建添加View，会调用这个初始化函数
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
@end
