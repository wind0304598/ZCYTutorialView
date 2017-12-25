//
//  ZCYTutorialViewDecoratorHint.h
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ZCYTutorialViewDecorator.h"

@class ZCYHintObject;

@protocol ZCYTutorialViewHintDelegate <NSObject>
- (ZCYHintObject *)tutorialView:(ZCYTutorialView *)tutorialView
           hintViewForFocusView:(UIView *)focusView
                        atIndex:(NSUInteger)index;
@end

@interface ZCYTutorialViewDecoratorHint : ZCYTutorialViewDecorator

@property (weak, nonatomic) id<ZCYTutorialViewHintDelegate> hintDelegate;

+ (ZCYTutorialView *)makeWith:(ZCYTutorialView *)tutorialView andDelegate:(id<ZCYTutorialViewHintDelegate>)delegate;

@end

@interface ZCYHintObject : NSObject

@property (strong, nonatomic) UIView *view;
@property (copy, nonatomic) void (^viewDidAdd)(UIView *hintView);

@end
