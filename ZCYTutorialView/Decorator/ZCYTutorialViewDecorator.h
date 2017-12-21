//
//  ZCYTutorialViewDecorator.h
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ZCYTutorialView.h"

@interface ZCYTutorialViewDecorator : ZCYTutorialView

@property (strong, nonatomic) ZCYTutorialView *tutorialView;

+ (__kindof ZCYTutorialView *)makeWith:(ZCYTutorialView *)tutorialView;

- (void)setup;
- (void)updateLayoutForShowing;
- (ZCYTutorialView *)baseTutorialView;

@end
