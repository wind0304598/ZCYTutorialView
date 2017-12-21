//
//  ZCYTutorialViewDecoratorHint.m
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ZCYTutorialViewDecoratorHint.h"

@implementation ZCYTutorialViewDecoratorHint

+ (ZCYTutorialView *)makeWith:(ZCYTutorialView *)tutorialView andHintViews:(UIView *)hintViews, ... {
    NSMutableArray *views = [NSMutableArray new];
    
    va_list viewList;
    va_start(viewList, hintViews);
    for (UIView *view = hintViews; view != nil; view = va_arg(viewList, UIView *)) {
        [views addObject:view];
    }
    va_end(viewList);
    return [self.class makeWith:tutorialView andHintViewArray:views];
}

+ (ZCYTutorialView *)makeWith:(ZCYTutorialView *)tutorialView andHintViewArray:(NSArray <UIView *>*)hintViews {
    ZCYTutorialViewDecoratorHint *tutorialViewDecorator = [super makeWith:tutorialView];
    tutorialViewDecorator.hintViews = hintViews;
    return tutorialViewDecorator;
}

- (void)setup {
    [super setup];
    
    self.hintPadding = UIEdgeInsetsMake(16, 16, 16, 16);
    self.hintGap = 16;
}

- (void)setHintViews:(UIView *)hintViews, ... {
    NSMutableArray *views = [NSMutableArray new];
    
    va_list viewList;
    va_start(viewList, hintViews);
    for (UIView *view = hintViews; view != nil; view = va_arg(viewList, UIView *)) {
        [views addObject:view];
    }
    va_end(viewList);
    
    [self setHintViewArray:views];
}

- (void)setHintViewArray:(NSArray<UIView *> *)hintViews {
    _hintViews = [hintViews copy];
}

#pragma mark - Overrides

- (void)updateLayoutForShowing {
    [super updateLayoutForShowing];
    
    for (UIView *focusView in self.tutorialView.focusArray) {
        NSUInteger hintViewIndex = [self.hintViews indexOfObjectPassingTest:^BOOL(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return idx == [self.tutorialView.focusArray indexOfObject:focusView];
        }];
        if (hintViewIndex != NSNotFound) {
            UIView *hintView = self.hintViews[hintViewIndex];
            CGFloat hintWidth = CGRectGetWidth(hintView.frame);
            CGFloat hintHeight = CGRectGetHeight(hintView.frame);
            CGPoint hintOrigin = CGPointMake(CGRectGetMidX(focusView.frame) - hintWidth / 2.f,
                                             CGRectGetMinY(focusView.frame) - hintHeight - self.hintGap);
            if (hintOrigin.x + hintWidth > self.frame.size.width - self.hintPadding.right) {
                hintOrigin.x = self.frame.size.width - self.hintPadding.right;
            } else if (hintOrigin.x < 0 + self.hintPadding.left) {
                hintOrigin.x = 0 + self.hintPadding.left;
            }
            hintView.frame = CGRectMake(hintOrigin.x, hintOrigin.y, hintWidth, hintHeight);
            [self addSubview:hintView];
        }
    }
}

@end
