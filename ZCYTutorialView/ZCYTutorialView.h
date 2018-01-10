//
//  ZCYTutorialView.h
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import <UIKit/UIKit.h>

@class ZCYTutorialView;

@protocol ZCYTutorialViewDelegate <NSObject>

- (void)dismissedWithTutorialView:(ZCYTutorialView *)tutorialView;

@end

@interface ZCYTutorialView : UIView

@property (weak, nonatomic) id<ZCYTutorialViewDelegate> delegate;

@property (strong, nonatomic, readonly) NSArray<UIView *> *focusArray;
@property (nonatomic, getter=isShown, readonly) BOOL shown;
@property (nonatomic, getter=isCloseOnTouch) BOOL closeOnTouch;
@property (nonatomic, getter=isCloseOnFocusedTouch) BOOL closeOnFocusedTouch;
@property (nonatomic, getter=isDismissOnly) BOOL dismissOnly;
@property (nonatomic, getter=isIgnoreOnFocusedTouch) BOOL ignoreOnFocusedTouch;

- (instancetype)initWithDelegate:(id<ZCYTutorialViewDelegate>)delegate;

- (void)focus:(UIView *)views, ...;

- (void)focusOnViews:(NSArray <UIView *> *)views;

- (void)show;

- (void)dismiss;

@end
