//
//  ZCYTutorialView.h
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import <UIKit/UIKit.h>

@interface ZCYTutorialView : UIView

@property (strong, nonatomic, readonly) NSArray<UIView *> *focusArray;
@property (nonatomic, getter=isShown, readonly) BOOL shown;
@property (nonatomic, getter=isCloseOnTouch) BOOL closeOnTouch;
@property (nonatomic, getter=isCloseOnFocusedTouch) BOOL closeOnFocusedTouch;
@property (nonatomic, getter=isDismissOnly) BOOL dismissOnly;
@property (nonatomic, getter=isIgnoreOnFocusedTouch) BOOL ignoreOnFocusedTouch;

- (void)focus:(UIView *)views, ...;

- (void)focusOnViews:(NSArray <UIView *> *)views;

- (void)show;

- (void)dismiss;

@end
