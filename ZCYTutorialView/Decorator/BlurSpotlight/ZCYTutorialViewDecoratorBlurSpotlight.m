//
//  ZCYTutorialViewDecoratorBlurSpotlight.m
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ZCYTutorialViewDecoratorBlurSpotlight.h"

@interface ZCYTutorialViewDecoratorBlurSpotlight()

@property (strong, nonatomic) UIVisualEffectView *blurView;

@end

@implementation ZCYTutorialViewDecoratorBlurSpotlight

- (void)setup {
    [super setup];
    
    self.blurView = ({
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurView.frame = self.frame;
        blurView.alpha = .3f;
        blurView;
    });
    [self addSubview:self.blurView];
}

#pragma mark - Overrides

- (void)updateLayoutForShowing {
    [super updateLayoutForShowing];
    
    [self updateBlurView];
}

#pragma mark - Private Methods

- (void)updateBlurView {
    if (!self.blurView) {
        return;
    }
    
    self.blurView.frame = self.frame;
    
    UIView *maskView = [[UIView alloc] initWithFrame:self.blurView.bounds];
    maskView.clipsToBounds = YES;
    maskView.backgroundColor = [UIColor clearColor];
    
    UIBezierPath *outerBezierPath = [UIBezierPath bezierPathWithRoundedRect:self.blurView.bounds cornerRadius:0];
    for (UIView *focusView in self.tutorialView.focusArray) {
        UIBezierPath *innerCirclePath = [UIBezierPath bezierPathWithRoundedRect:CGRectIntersection(focusView.frame, self.frame)
                                                                   cornerRadius:0];
        [outerBezierPath appendPath:innerCirclePath];
    }
    outerBezierPath.usesEvenOddFillRule = YES;
    
    CAShapeLayer *fillLayer = [[CAShapeLayer alloc] init];
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.path = outerBezierPath.CGPath;
    [maskView.layer addSublayer:fillLayer];
    
    self.blurView.maskView = maskView;
}

@end
