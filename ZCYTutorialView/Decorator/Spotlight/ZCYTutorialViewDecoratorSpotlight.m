//
//  ZCYTutorialViewDecoratorSpotlight.m
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ZCYTutorialViewDecoratorSpotlight.h"

@implementation ZCYTutorialViewDecoratorSpotlight

#pragma mark - Decorator Methods

- (void)setup {
    [super setup];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.1f];
}

#pragma mark - Overrides

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [[UIColor clearColor] setFill];
    for (UIView *focusView in self.tutorialView.focusArray) {
        UIRectFill(CGRectIntersection(focusView.frame, rect));
    }
}

- (void)updateLayoutForShowing {
    [super updateLayoutForShowing];
    
    [self setNeedsDisplay];
}

@end
