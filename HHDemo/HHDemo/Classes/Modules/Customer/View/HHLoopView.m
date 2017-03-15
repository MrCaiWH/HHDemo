//
//  HHLoopView.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHLoopView.h"

@interface HHLoopView () {
    // 记录
    int currentIndex;
    // 内容载体
    UILabel *tickerLabel;
}
@property (nonatomic, copy) NSString *flagStr;
@property (nonatomic, assign) CGSize textSize;
@end

@implementation HHLoopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setupView {
    tickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    tickerLabel.textAlignment = NSTextAlignmentCenter;
    [tickerLabel setBackgroundColor:[UIColor clearColor]];
    [tickerLabel setNumberOfLines:1];
    tickerLabel.font=[UIFont systemFontOfSize:15.f];
    [self addSubview:tickerLabel];
}

-(void)setLabelColor:(UIColor *)color {
    tickerLabel.textColor = color;
}

- (void)setTickerArrs:(NSArray *)tickerArrs {
    _tickerArrs = tickerArrs;
    
    if (tickerLabel) {
        [tickerLabel removeFromSuperview];
        tickerLabel = nil;
    }
    
    [self setupView];
}

-(void)animateCurrentTickerString {
    if (_tickerArrs.count == 0 || _tickerArrs == nil) {
        return;
    }
    
    NSString *currentString = [_tickerArrs objectAtIndex:currentIndex];
    
    NSLog(@"currentString  %@",currentString);
    
    if (![self.flagStr isEqualToString:currentString]) {
        //获取当前文字size
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15.f]};
        self.textSize=[currentString sizeWithAttributes:attrs];
    }
    
    self.flagStr = currentString;
    
    if (self.textSize.width <= self.frame.size.width && _tickerArrs.count == 1) {
        [tickerLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [tickerLabel setText:currentString];
        return;
    }

    // 设置起点和终点
    float startingX = 0.0f;
    float endX = 0.0f;
    
    startingX = self.frame.size.width;
    endX = -_textSize.width;
    
    [tickerLabel setFrame:CGRectMake(startingX, tickerLabel.frame.origin.y, _textSize.width, tickerLabel.frame.size.height)];
    [tickerLabel setText:currentString];
    float duration = (_textSize.width + self.frame.size.width) / _Speed;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    //动画结束后执行
    [UIView setAnimationDidStopSelector:@selector(tickerMoveAnimationDidStop:finished:context:)];
    CGRect tickerFrame = tickerLabel.frame;
    tickerFrame.origin.x = endX;
    [tickerLabel setFrame:tickerFrame];
    
    [UIView commitAnimations];
}

-(void)tickerMoveAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if([finished boolValue]) {
        NSLog(@"动画已经结束");
        currentIndex++;
        if(currentIndex >= [_tickerArrs count]) {
            currentIndex = 0;
        }
        [self animateCurrentTickerString];
    }
    else {
        NSLog(@"动画没有正常结束");
    }
}

#pragma mark - Ticker Animation Handling
-(void)start {
    // 开启动画默认第一条信息
    currentIndex = 0;
    // 开始动画
    [self animateCurrentTickerString];
}

@end
