//
//  DropitViewController.m
//  Dropit
//
//  Created by Mark Lewis on 15-8-10.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "DropitViewController.h"
#import "DropitBehavior.h"
#import "BezierView.h"

@interface DropitViewController () <UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet BezierView *gameView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) DropitBehavior *dropitBehavior;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;
@property (strong, nonatomic) UIView *droppingView;
@end

@implementation DropitViewController

- (UIColor *)randomColor
{
    switch (arc4random()%5)
    {
        case 0: return [UIColor greenColor];
        case 1: return [UIColor blueColor];
        case 2: return [UIColor orangeColor];
        case 3: return [UIColor redColor];
        case 4: return [UIColor purpleColor];
    }
    
    return [UIColor blackColor];
}

static const CGSize DROP_SIZE = {40 ,40};
- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    // 网格排列，x代表第几列
    int x = arc4random()%(int)(self.gameView.bounds.size.width)/ DROP_SIZE.width;
    frame.origin.x = x*DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
    self.droppingView = dropView;
    
    [self.dropitBehavior addItem:dropView];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender
{
    CGPoint gesturePoint = [sender locationInView:self.gameView];
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        [self attachDroppingViewToPoint:gesturePoint];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        self.attachment.anchorPoint = gesturePoint;
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.animator removeBehavior:self.attachment];
        self.gameView.path = nil; // 手放开后，绘制的线清空
    }
}
- (void)attachDroppingViewToPoint:(CGPoint)anchorPoint
{
    if (self.droppingView)
    {
        self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.droppingView
                                                    attachedToAnchor:anchorPoint];
        UIView *droppingView = self.droppingView;
        __weak DropitViewController *weakSelf = self;
        
        self.attachment.action = ^{
            UIBezierPath *path = [[UIBezierPath alloc] init];
            [path moveToPoint:weakSelf.attachment.anchorPoint];
            [path addLineToPoint:droppingView.center];
            weakSelf.gameView.path = path;
        };
        self.droppingView = nil;
        [self.animator addBehavior:self.attachment];
    }
}


- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    [self removeCompletedRows];
}

- (BOOL)removeCompletedRows
{
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc] init];
    
    for (CGFloat y = self.gameView.bounds.size.height-DROP_SIZE.height/2; y > 0; y -= DROP_SIZE.height)//如果是3.5寸屏幕，循环12次
    {
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
        for (CGFloat x = DROP_SIZE.width/2; x <= self.gameView.bounds.size.width-DROP_SIZE.width/2; x += DROP_SIZE.width) //如果是3.5寸屏幕，循环8次
        {
            // 关键方法hitTest,先检测全部的对象.如果有视图，就添加到dropsFound数组中
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            if ([hitView superview] == self.gameView)
            {
                [dropsFound addObject:hitView];
            }
            else
            {
                rowIsComplete = NO;
                break;
            }
        }
        if (![dropsFound count]) break;
        if (rowIsComplete) [dropsToRemove addObjectsFromArray:dropsFound];
    }
    
    
    if ([dropsToRemove count])
    {
        for (UIView *drop in dropsToRemove)
        {
            [self.dropitBehavior removeItem:drop];
            // 避免DynamicAnimator影响我们的ViewAnimation动画，防止重力的影响
        }
        
        [self animateRemovingDrops:dropsToRemove];
        return YES;
    }
    
    return NO;
}

- (void)animateRemovingDrops:(NSArray *)dropsToRemove
{
    [UIView animateWithDuration:1.5
                     animations:^{
                         for (UIView *drop in dropsToRemove)
                         {
                             int x = (arc4random()%(int)(self.gameView.bounds.size.width*5)) - (int)self.gameView.bounds.size.width*2;
                             int y = DROP_SIZE.height;
                             
                             drop.center = CGPointMake(x, -y);
                         }
                     }
                     completion:^(BOOL finished) {
                         // Array非常好用的一个方法，能给数组中每个元素发送这个selector。比for in循环方便很多
                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     }];
}


#pragma mark - lazy loading
- (UIDynamicAnimator *)animator
{
    if(!_animator) _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
    _animator.delegate = self;
    return _animator;
}

- (DropitBehavior *)dropitBehavior
{
    if(!_dropitBehavior)
    {
        _dropitBehavior = [[DropitBehavior alloc] init];
        [self.animator addBehavior:self.dropitBehavior];
    }
    
    return _dropitBehavior;
}

#pragma mark - ViewController Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
