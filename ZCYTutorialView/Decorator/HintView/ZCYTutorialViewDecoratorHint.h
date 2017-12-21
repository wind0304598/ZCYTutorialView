//
//  ZCYTutorialViewDecoratorHint.h
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ZCYTutorialViewDecorator.h"

@interface ZCYTutorialViewDecoratorHint : ZCYTutorialViewDecorator

@property (strong, setter=setHintViewArray:, nonatomic) NSArray<UIView *> *hintViews;

/**
 An forbidden tutorialView area to HintViews.
 */
@property (nonatomic) UIEdgeInsets hintPadding;

/**
 A distance between hintView and focusView.
 */
@property (nonatomic) CGFloat hintGap;

+ (ZCYTutorialView *)makeWith:(ZCYTutorialView *)tutorialView andHintViews:(UIView *)hintViews, ... NS_REQUIRES_NIL_TERMINATION;

+ (ZCYTutorialView *)makeWith:(ZCYTutorialView *)tutorialView andHintViewArray:(NSArray <UIView *>*)hintViews;

- (void)setHintViews:(UIView *)hintViews, ... NS_REQUIRES_NIL_TERMINATION;

- (void)setHintViewArray:(NSArray <UIView *> *)hintViews;

@end
