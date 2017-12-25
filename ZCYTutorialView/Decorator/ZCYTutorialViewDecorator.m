//
//  ZCYTutorialViewDecorator.m
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ZCYTutorialViewDecorator.h"

@implementation ZCYTutorialViewDecorator

+ (__kindof ZCYTutorialView *)makeWith:(ZCYTutorialView *)tutorialView {
    ZCYTutorialViewDecorator *tutorialViewDecorator = [[self.class alloc] init];
    tutorialViewDecorator.tutorialView = tutorialView;
    [tutorialViewDecorator setup];
    return tutorialViewDecorator;
}

- (void)setup {
}

- (NSArray<UIView *> *)focusArray {
    return self.tutorialView.focusArray;
}

- (void)focus:(UIView *)views, ... {
    NSMutableArray *focusArray = [NSMutableArray new];
    
    va_list viewList;
    va_start(viewList, views);
    for (UIView *view = views; view != nil; view = va_arg(viewList, UIView *)) {
        [focusArray addObject:view];
    }
    va_end(viewList);
    
    [self.tutorialView focusOnViews:focusArray];
}

- (void)focusOnViews:(NSArray<UIView *> *)views {
    [self.tutorialView focusOnViews:views];
}

- (void)updateLayoutForShowing {
}

- (void)show {
    [self.tutorialView show];
    
    [self updateLayoutForShowing];
}

- (void)dismiss {
    [self.tutorialView dismiss];
}

- (ZCYTutorialView *)baseTutorialView {
    if ([self.tutorialView isKindOfClass:ZCYTutorialViewDecorator.class]) {
        return [(ZCYTutorialViewDecorator *)self.tutorialView baseTutorialView];
    } else {
        return self.tutorialView;
    }
}

@end
