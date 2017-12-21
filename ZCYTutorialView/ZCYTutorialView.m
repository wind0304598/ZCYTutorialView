//
//  ZCYTutorialView.m
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ZCYTutorialView.h"

@interface ZCYTutorialView ()

@property (strong, nonatomic, readwrite) NSArray<UIView *> * focusArray;
@property (nonatomic, getter=isShown, readwrite) BOOL shown;

@end

@implementation ZCYTutorialView

- (instancetype)init {
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

#pragma mark - Overrides

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *focusView in self.focusArray) {
        if (CGRectContainsPoint(focusView.frame, point)) {
            return focusView;
        }
    }
    
    return self.isShown ? self : nil;
}

#pragma mark - Public Methods

- (void)focus:(UIView *)views, ... {
    NSMutableArray *focusArray = [NSMutableArray new];
    
    va_list viewList;
    va_start(viewList, views);
    for (UIView *view = views; view != nil; view = va_arg(viewList, UIView *)) {
        [focusArray addObject:view];
    }
    va_end(viewList);
    
    [self focusOnViews:[focusArray copy]];
}

- (void)focusOnViews:(NSArray<UIView *> *)views {
    NSParameterAssert(views);
    self.focusArray = [views copy];
}

- (void)show {
    self.shown = YES;
    self.userInteractionEnabled = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss {
    self.shown = NO;
    self.focusArray = nil;
    self.userInteractionEnabled = NO;
    [self removeFromSuperview];
}

@end
