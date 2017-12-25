//
//  ZCYTutorialViewDecoratorHint.m
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ZCYTutorialViewDecoratorHint.h"

@implementation ZCYTutorialViewDecoratorHint

+ (ZCYTutorialView *)makeWith:(ZCYTutorialView *)tutorialView andDelegate:(id<ZCYTutorialViewHintDelegate>)delegate {
    ZCYTutorialViewDecoratorHint *tutorialViewDecorator = [super makeWith:tutorialView];
    tutorialViewDecorator.hintDelegate = delegate;
    return tutorialViewDecorator;
}

- (void)setup {
    [super setup];
    
    [self.baseTutorialView addSubview:self];
}

#pragma mark - Overrides

- (void)updateLayoutForShowing {
    [super updateLayoutForShowing];
    
    for (UIView *focusView in self.tutorialView.focusArray) {
        if (!self.hintDelegate || ![self.hintDelegate respondsToSelector:@selector(tutorialView:hintViewForFocusView:atIndex:)]) {
            return;
        }
        
        ZCYHintObject *hint = [self.hintDelegate tutorialView:self.baseTutorialView
                                         hintViewForFocusView:focusView
                                                      atIndex:[self.tutorialView.focusArray indexOfObject:focusView]];
        UIView *hintView = hint.view;
        if (!hintView) {
            continue;
        }
        [self addSubview:hintView];
        if (hint.viewDidAdd) {
            hint.viewDidAdd(hintView);
        }
    }
}

@end

@implementation ZCYHintObject

@end
