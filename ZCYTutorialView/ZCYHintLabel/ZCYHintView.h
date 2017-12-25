//
//  ZCYHintView.h
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZCYHintDirection) {
    ZCYHintDirectionLeft,
    ZCYHintDirectionTop,
    ZCYHintDirectionRight,
    ZCYHintDirectionBottom,
    ZCYHintDirectionNone
};

@interface ZCYHintView : UIView

@property (nonatomic) CGSize indicatorSize;
@property (nonatomic) CGPoint indicatorPoint;

/**
   The offset between text and border.
 **/
@property (nonatomic) UIEdgeInsets padding;

/**
   The offset between self and parent's edge.
 **/
@property (nonatomic) UIEdgeInsets margin;
@property (strong, nonatomic) UIColor *labelBackgroundColor;
@property (nonatomic) CGFloat labelBackgroundCornerRadius;

/**
   The width of border. Actual width will be twice because half width are clipped by backgroundLayer.
 */
@property (nonatomic) CGFloat labelBorderWidth;
@property (strong, nonatomic) UIColor *labelBorderColor;
@property (strong, nonatomic) UIFont *font;

/**
   The direction of the hintView to the focusPoint. If the direction is ZCYHintDirectionTop, it means the hintView is at
 the top of the focus point. If the direction is ZCYHintDirectionBottom, it means the hintView is at the bottom of the
 hintView.
 **/
@property (nonatomic) ZCYHintDirection direction;
@property (nonatomic) CGPoint originOnDirectionNone;

/**
   The distance between the hintView and the focus point.
 */
@property (nonatomic) CGFloat gap;


/**
   Showing the hintView which point at the view depending on direction. If the direction is ZCYHintDirectionNone,
 originOnDirectionNone must be set.

 @param view A view at which the hintView will point. Can be nil only when direction is ZCYHintDirectionNone.
 */
- (void)showHintAtView:(UIView *)view;

- (void)showHintAtPoint:(CGPoint)point;

- (void)showHintWithText:(NSString *)hintText atPoint:(CGPoint)point;

- (void)setHintText:(NSString *)hintText;

@end
