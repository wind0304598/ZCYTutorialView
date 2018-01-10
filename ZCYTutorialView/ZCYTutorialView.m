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
    return [self initWithDelegate:nil];
}

- (instancetype)initWithDelegate:(id<ZCYTutorialViewDelegate>)delegate {
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    if (self) {
        self.delegate = delegate;
        self.userInteractionEnabled = NO;
    }
    return self;
}

#pragma mark - Overrides

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.shown) {
        return nil;
    }
    
    if (self.closeOnTouch) {
        if (self.dismissOnly) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
            return self;
        } else {
            [self dismiss];
        }
    }
    
    if (!self.ignoreOnFocusedTouch) {
        for (UIView *focusView in self.focusArray) {
            if (CGRectContainsPoint(focusView.frame, point)) {
                if (!self.closeOnTouch && self.closeOnFocusedTouch) {
                    if (self.dismissOnly) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self dismiss];
                        });
                        return self;
                    } else {
                        [self dismiss];
                    }
                }
                return focusView;
            }
        }
    }
    
    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
        CGPoint convertedPoint = [subview convertPoint:point fromView:self];
        UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
        if (hitTestView) {
            return hitTestView;
        }
    }
    
    return self;
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
    if (!self.shown || !self.superview) {
        return;
    }
    
    self.shown = NO;
    self.focusArray = nil;
    self.userInteractionEnabled = NO;
    [self removeFromSuperview];
    
    if (self.delegate) {
        [self.delegate dismissedWithTutorialView:self];
    }
}

@end
