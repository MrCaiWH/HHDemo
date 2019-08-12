//
//  HHSliderView.m
//  HHDemo
//
//  Created by zero on 2017/3/16.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHSliderView.h"
#import <QuartzCore/QuartzCore.h>

@interface HHSliderView ()
@property (nonatomic, assign) NSTimeInterval changeTime;

@property (nonatomic, assign) NSTimeInterval downTime;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, assign) BOOL isLongPress;

@property (nonatomic, assign) float downValue;

@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation HHSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContent];
    }
    return self;
}

- (void) loadContent {
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.arrowImageView];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectZero];
    _slider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    CGPoint ctr = _slider.center;
    CGRect sliderFrame = _slider.frame;
    sliderFrame.size.width -= 4; //each "edge" of the track is 2 pixels wide
    _slider.frame = sliderFrame;
    _slider.center = ctr;
    _slider.backgroundColor = [UIColor clearColor];
    [_slider setThumbImage:[UIImage imageNamed:@"anniu_1_"] forState:UIControlStateNormal];
    
    UIImage *clearImage = [self clearPixel];
    [_slider setMaximumTrackImage:clearImage forState:UIControlStateNormal];
    [_slider setMinimumTrackImage:clearImage forState:UIControlStateNormal];
    
    _slider.minimumValue = 0.0;
    _slider.maximumValue = 1.0;
    _slider.continuous = YES;
    _slider.value = 1.0;
    [self addSubview:_slider];

    // Set the slider action methods
    [_slider addTarget:self action:@selector(sliderUp:) forControlEvents:UIControlEventTouchUpInside];
    [_slider addTarget:self action:@selector(sliderUp:) forControlEvents:UIControlEventTouchUpOutside];
    [_slider addTarget:self action:@selector(sliderDown:) forControlEvents:UIControlEventTouchDown];
    [_slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@149);
        make.height.equalTo(@57);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@13);
        make.height.equalTo(@12.5);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@149);
        make.height.equalTo(@57);
    }];
}

// UISlider actions
- (void)sliderUp:(UISlider *)sender {
    
    if (!self.isLongPress) {
        
        if (self.downValue <= 1.0 && self.downValue >= 0.9) { //出发点是解锁状态
            //单击，不执行
            [_slider setValue:1.0 animated: YES];
        }
        
        if (self.downValue <= 0.1 && self.downValue >= 0.0) { //出发点是未解锁状态
            if (sender.value <= 0.1 && sender.value >= 0.0) { //单击，不执行
                [_slider setValue:0.0 animated: YES];
            }
            else {
                [_slider setValue:1.0 animated: YES];
            }
        }
    }
    
    if (self.changeTime - self.downTime > 120) {
        
        if (_slider.value == 0) {
            [_slider setValue:0.0 animated: YES];
            [_slider setThumbImage:[UIImage imageNamed:@"anniu_suo_"] forState:UIControlStateNormal];
            [_arrowImageView setImage:[UIImage imageNamed:@"jiantou_2_"]];
            [_bgImageView setImage:[UIImage imageNamed:@"sp_jiesuo_"]];
        }
        else {
            [_slider setValue:1.0 animated: YES];
            [_slider setThumbImage:[UIImage imageNamed:@"anniu_1_"] forState:UIControlStateNormal];
            [_arrowImageView setImage:[UIImage imageNamed:@"jiantou_1_"]];
            [_bgImageView setImage:[UIImage imageNamed:@"sp_suo_"]];
        }
    }
    
    self.changeTime = 0;
    self.downTime = 0;
    self.flag = NO;
    self.isLongPress = NO;
}

- (void)sliderDown:(UISlider *)sender {
    self.downTime = [[NSDate date] timeIntervalSince1970]*1000;
    self.downValue = sender.value;
}

- (void)sliderChanged:(UISlider *)sender {
    
    self.changeTime = [[NSDate date] timeIntervalSince1970]*1000;

    if (self.changeTime - self.downTime > 120 && self.downTime != 0) {
        
        self.isLongPress = YES;
        
        if (self.flag) {
            return;
        }
    }
}

- (UIImage *)clearPixel {
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Lazy
- (UIImageView *)arrowImageView {
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] initWithImage:HHIMG(@"jiantou_1_")];
    }
    return _arrowImageView;
}

- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithImage:HHIMG(@"sp_suo_")];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}
@end
