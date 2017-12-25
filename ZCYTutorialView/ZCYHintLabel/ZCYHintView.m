//
//  ZCYHintView.m
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ZCYHintView.h"
#import "Masonry.h"

@interface ZCYHintView ()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) CAShapeLayer *borderLayer;
@property (strong, nonatomic) CAShapeLayer *labelBackgroundLayer;

@end

@implementation ZCYHintView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.indicatorSize = CGSizeMake(5, 10);
        self.padding = UIEdgeInsetsMake(8, 8, 8, 8);
        self.labelBackgroundColor = [UIColor orangeColor];
        self.labelBackgroundCornerRadius = 5;
        self.labelBorderColor = [UIColor orangeColor];
        self.labelBorderWidth = 0;
        self.font = [UIFont systemFontOfSize:18];
        
        [self setOpaque:NO];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self.layer setCornerRadius:5];
    
    self.label = [[UILabel alloc] init];
    [self.label setNumberOfLines:0];
    [self.label setFont:self.font];
    [self addSubview:self.label];
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.padding.top);
        make.leading.equalTo(self).offset(self.padding.left);
        make.trailing.equalTo(self).offset(-self.padding.right);
        make.bottom.equalTo(self).offset(-self.padding.bottom);
    }];
}

- (void)updateLabelConstrains {
    switch (self.direction) {
        case ZCYHintDirectionLeft: {
            [self.label updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(self.padding.top);
                make.leading.equalTo(self).offset(self.padding.left);
                make.trailing.equalTo(self).offset(-self.padding.right - self.indicatorSize.width);
                make.bottom.equalTo(self).offset(-self.padding.bottom);
            }];
            break;
        }
        case ZCYHintDirectionTop: {
            [self.label updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(self.padding.top);
                make.leading.equalTo(self).offset(self.padding.left);
                make.trailing.equalTo(self).offset(-self.padding.right);
                make.bottom.equalTo(self).offset(-self.padding.bottom - self.indicatorSize.height);
            }];
            break;
        }
        case ZCYHintDirectionRight: {
            [self.label updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(self.padding.top);
                make.leading.equalTo(self).offset(self.padding.left + self.indicatorSize.width);
                make.trailing.equalTo(self).offset(-self.padding.right);
                make.bottom.equalTo(self).offset(-self.padding.bottom);
            }];
            break;
        }
        case ZCYHintDirectionBottom: {
            [self.label updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(self.padding.top + self.indicatorSize.height);
                make.leading.equalTo(self).offset(self.padding.left);
                make.trailing.equalTo(self).offset(-self.padding.right);
                make.bottom.equalTo(self).offset(-self.padding.bottom);
            }];
            break;
        }
        case ZCYHintDirectionNone:
        default: {
            [self.label updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(self.padding);
            }];
            break;
        }
    }
}

- (void)drawRect:(CGRect)rect {
    [self clearAdditionalLayer];
    
    CGMutablePathRef backgroundPath = CGPathCreateMutable();
    
    switch (self.direction) {
        case ZCYHintDirectionLeft: {
            CGRect labelRect = CGRectMake(0,
                                          0,
                                          self.frame.size.width - self.indicatorSize.width,
                                          self.frame.size.height);
            CGPathAddRoundedRect(backgroundPath, nil, labelRect, self.labelBackgroundCornerRadius, self.labelBackgroundCornerRadius);
            
            CGPathMoveToPoint(backgroundPath, nil, self.indicatorPoint.x - self.indicatorSize.width, self.indicatorPoint.y - self.indicatorSize.height / 2.f);
            CGPathAddLineToPoint(backgroundPath, nil, self.indicatorPoint.x, self.indicatorPoint.y);
            CGPathAddLineToPoint(backgroundPath, nil, self.indicatorPoint.x - self.indicatorSize.width, self.indicatorPoint.y + self.indicatorSize.height / 2.f);
            CGPathCloseSubpath(backgroundPath);
            break;
        }
        case ZCYHintDirectionTop: {
            CGRect labelRect = CGRectMake(0,
                                          0,
                                          self.frame.size.width,
                                          self.frame.size.height - self.indicatorSize.height);
            CGPathAddRoundedRect(backgroundPath, nil, labelRect, self.labelBackgroundCornerRadius, self.labelBackgroundCornerRadius);
            
            CGPathMoveToPoint(backgroundPath, nil, self.indicatorPoint.x + self.indicatorSize.width / 2.f, self.frame.size.height - self.indicatorSize.height);
            CGPathAddLineToPoint(backgroundPath, nil, self.indicatorPoint.x, self.frame.size.height);
            CGPathAddLineToPoint(backgroundPath, nil, self.indicatorPoint.x - self.indicatorSize.width / 2.f, self.frame.size.height - self.indicatorSize.height);
            CGPathCloseSubpath(backgroundPath);
            break;
        }
        case ZCYHintDirectionRight: {
            CGRect labelRect = CGRectMake(self.indicatorSize.width,
                                          0,
                                          self.frame.size.width - self.indicatorSize.width,
                                          self.frame.size.height);
            CGPathAddRoundedRect(backgroundPath, nil, labelRect, self.labelBackgroundCornerRadius, self.labelBackgroundCornerRadius);
            
            CGPathMoveToPoint(backgroundPath, nil, self.indicatorPoint.x + self.indicatorSize.width, self.indicatorPoint.y + self.indicatorSize.height / 2.f);
            CGPathAddLineToPoint(backgroundPath, nil, self.indicatorPoint.x, self.indicatorPoint.y);
            CGPathAddLineToPoint(backgroundPath, nil, self.indicatorPoint.x + self.indicatorSize.width, self.indicatorPoint.y - self.indicatorSize.height / 2.f);
            CGPathCloseSubpath(backgroundPath);
            break;
        }
        case ZCYHintDirectionBottom: {
            CGRect labelRect = CGRectMake(0,
                                          self.indicatorSize.height,
                                          self.frame.size.width,
                                          self.frame.size.height - self.indicatorSize.height);
            CGPathAddRoundedRect(backgroundPath, nil, labelRect, self.labelBackgroundCornerRadius, self.labelBackgroundCornerRadius);
            
            CGPathMoveToPoint(backgroundPath, nil, self.indicatorPoint.x, 0);
            CGPathAddLineToPoint(backgroundPath, nil, self.indicatorPoint.x + self.indicatorSize.width / 2.f, self.indicatorSize.height);
            CGPathAddLineToPoint(backgroundPath, nil, self.indicatorPoint.x - self.indicatorSize.width / 2.f, self.indicatorSize.height);
            CGPathCloseSubpath(backgroundPath);
            break;
        }
        case ZCYHintDirectionNone:
        default:{
            CGRect labelRect = self.bounds;
            CGPathAddRoundedRect(backgroundPath, nil, labelRect, self.labelBackgroundCornerRadius, self.labelBackgroundCornerRadius);
            break;
        }
    }
    
    CGPathRef borderPath = CGPathCreateCopyByStrokingPath(backgroundPath,
                                                          nil,
                                                          self.labelBorderWidth,
                                                          kCGLineCapRound,
                                                          kCGLineJoinRound,
                                                          1.0);
    
    self.borderLayer = [CAShapeLayer layer];
    self.borderLayer.fillColor = self.labelBorderColor.CGColor;
    self.borderLayer.path = borderPath;
    [self.layer addSublayer:self.borderLayer];
    
    self.labelBackgroundLayer = [CAShapeLayer layer];
    self.labelBackgroundLayer.fillColor = self.labelBackgroundColor.CGColor;
    self.labelBackgroundLayer.path = backgroundPath;
    [self.layer addSublayer:self.labelBackgroundLayer];
    
    [self bringSubviewToFront:self.label];
}

- (void)clearAdditionalLayer {
    if (self.borderLayer) {
        [self.borderLayer removeFromSuperlayer];
        self.borderLayer = nil;
    }
    
    if (self.labelBackgroundLayer) {
        [self.labelBackgroundLayer removeFromSuperlayer];
        self.labelBackgroundLayer = nil;
    }
}

- (void)showHintAtView:(UIView *)view {
    if (!self.superview) {
        return;
    }
    
    switch (self.direction) {
        case ZCYHintDirectionLeft:
            [self showHintAtPoint:CGPointMake(CGRectGetMinX(view.frame) - self.gap,
                                              CGRectGetMidY(view.frame))];
            break;
            
        case ZCYHintDirectionTop:
            [self showHintAtPoint:CGPointMake(CGRectGetMidX(view.frame),
                                              CGRectGetMinY(view.frame) - self.gap)];
            break;
            
        case ZCYHintDirectionRight:
            [self showHintAtPoint:CGPointMake(CGRectGetMaxX(view.frame) + self.gap,
                                              CGRectGetMidY(view.frame))];
            break;
            
        case ZCYHintDirectionBottom:
            [self showHintAtPoint:CGPointMake(CGRectGetMidX(view.frame),
                                              CGRectGetMaxY(view.frame) + self.gap)];
            break;
            
        case ZCYHintDirectionNone:
            [self showHintAtPoint:CGPointZero];
        default:
            break;
    }
}

- (void)showHintAtPoint:(CGPoint)point {
    if (!self.superview) {
        return;
    }
    
    switch (self.direction) {
        case ZCYHintDirectionLeft:
            [self updateFrameForLeftDirectionHintAtPoint:point];
            break;
            
        case ZCYHintDirectionTop:
            [self updateFrameForTopDirectionHintAtPoint:point];
            break;
            
        case ZCYHintDirectionRight:
            [self updateFrameForRightDirectionHintAtPoint:point];
            break;
            
        case ZCYHintDirectionBottom:
            [self updateFrameForBottomDirectionHintAtPoint:point];
            break;
            
        case ZCYHintDirectionNone:
            [self updateFrameForNoneDirectionHint];
        default:
            break;
    }
    
    [self setIndicatorPoint:[self.superview convertPoint:point toView:self]];
    [self setNeedsDisplay];
    [self.superview bringSubviewToFront:self];
}

- (void)updateFrameForLeftDirectionHintAtPoint:(CGPoint)point {
    CGFloat const availableWidth = point.x - self.margin.left;
    CGFloat const availAbleHeight = self.superview.frame.size.height - (self.margin.top + self.margin.bottom);
    CGFloat const maxAvailableY = self.superview.center.y + availAbleHeight / 2.f;
    CGFloat const minAvailableY = self.superview.center.y - availAbleHeight / 2.f;
    
    CGSize newSize = [self sizeThatFits:CGSizeMake(availableWidth, CGFLOAT_MAX)];
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    [self setFrame:newFrame];
    
    CGPoint newCenter = CGPointZero;
    if (point.y + newSize.height / 2.f > maxAvailableY) {
        newCenter.y = maxAvailableY - newSize.height / 2.f;
    } else if (point.y - newSize.height / 2.f < minAvailableY) {
        newCenter.y = minAvailableY + newSize.height / 2.f;
    } else {
        newCenter.y = point.y;
    }
    newCenter.x = point.x - newSize.width / 2.f;
    [self setCenter:newCenter];
}

- (void)updateFrameForTopDirectionHintAtPoint:(CGPoint)point {
    CGFloat const availableWidth = self.superview.frame.size.width - (self.margin.left + self.margin.right);
    CGFloat const maxAvailableX = self.superview.center.x + availableWidth / 2.f;
    CGFloat const minAvailableX = self.superview.center.x - availableWidth / 2.f;
    
    CGSize newSize = [self sizeThatFits:CGSizeMake(availableWidth, CGFLOAT_MAX)];
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    [self setFrame:newFrame];
    
    CGPoint newCenter = CGPointZero;
    if (point.x + newSize.width / 2.f > maxAvailableX) {
        newCenter.x = maxAvailableX - newSize.width / 2.f;
    } else if (point.x - newSize.width / 2.f < minAvailableX) {
        newCenter.x = minAvailableX + newSize.width / 2.f;
    } else {
        newCenter.x = point.x;
    }
    newCenter.y = point.y - newSize.height / 2.f;
    [self setCenter:newCenter];
}

- (void)updateFrameForRightDirectionHintAtPoint:(CGPoint)point {
    CGFloat const availableWidth = self.superview.frame.size.width - point.x - self.margin.right;
    CGFloat const availAbleHeight = self.superview.frame.size.height - (self.margin.top + self.margin.bottom);
    CGFloat const maxAvailableY = self.superview.center.y + availAbleHeight / 2.f;
    CGFloat const minAvailableY = self.superview.center.y - availAbleHeight / 2.f;
    
    CGSize newSize = [self sizeThatFits:CGSizeMake(availableWidth, CGFLOAT_MAX)];
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    [self setFrame:newFrame];
    
    CGPoint newCenter = CGPointZero;
    if (point.y + newSize.height / 2.f > maxAvailableY) {
        newCenter.y = maxAvailableY - newSize.height / 2.f;
    } else if (point.y - newSize.height / 2.f < minAvailableY) {
        newCenter.y = minAvailableY + newSize.height / 2.f;
    } else {
        newCenter.y = point.y;
    }
    newCenter.x = point.x + newSize.width / 2.f;
    [self setCenter:newCenter];
}

- (void)updateFrameForBottomDirectionHintAtPoint:(CGPoint)point {
    CGFloat const availableWidth = self.superview.frame.size.width - (self.margin.left + self.margin.right);
    CGFloat const maxAvailableX = self.superview.center.x + availableWidth / 2.f;
    CGFloat const minAvailableX = self.superview.center.x - availableWidth / 2.f;
    
    CGSize newSize = [self sizeThatFits:CGSizeMake(availableWidth, CGFLOAT_MAX)];
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    [self setFrame:newFrame];
    
    CGPoint newCenter = CGPointZero;
    if (point.x + newSize.width / 2.f > maxAvailableX) {
        newCenter.x = maxAvailableX - newSize.width / 2.f;
    } else if (point.x - newSize.width / 2.f < minAvailableX) {
        newCenter.x = minAvailableX + newSize.width / 2.f;
    } else {
        newCenter.x = point.x;
    }
    newCenter.y = point.y + newSize.height / 2.f;
    [self setCenter:newCenter];
}

- (void)updateFrameForNoneDirectionHint {
    CGFloat const availableWidth = self.superview.frame.size.width;
    
    CGSize newSize = [self sizeThatFits:CGSizeMake(availableWidth, CGFLOAT_MAX)];
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    newFrame.origin = self.originOnDirectionNone;
    [self setFrame:newFrame];
}

- (void)showHintWithText:(NSString *)hintText atPoint:(CGPoint)point {
    if (!self.superview) {
        return;
    }
    
    [self setHintText:hintText];
    [self showHintAtPoint:point];
}

- (CGSize)sizeThatFits:(CGSize)size {
    switch (self.direction) {
        case ZCYHintDirectionLeft:
        case ZCYHintDirectionRight: {
            size.width = size.width - self.padding.left - self.padding.right - self.indicatorSize.width;
            CGSize newSize = [self.label sizeThatFits:size];
            newSize.height = newSize.height + self.padding.top + self.padding.bottom;
            newSize.width = newSize.width + self.indicatorSize.width + self.padding.left + self.padding.right;
            return newSize;
        }
        case ZCYHintDirectionTop:
        case ZCYHintDirectionBottom: {
            size.width = size.width - self.padding.left - self.padding.right;
            CGSize newSize = [self.label sizeThatFits:size];
            newSize.height = newSize.height + self.indicatorSize.height + self.padding.top + self.padding.bottom;
            newSize.width = newSize.width + self.padding.left + self.padding.right;
            return newSize;
        }
        case ZCYHintDirectionNone:
        default: {
            size.width = size.width - self.padding.left - self.padding.right;
            CGSize newSize = [self.label sizeThatFits:size];
            newSize.height = newSize.height + self.padding.top + self.padding.bottom;
            newSize.width = newSize.width + self.padding.left + self.padding.right;
            return newSize;
        }
    }
}

- (void)setPadding:(UIEdgeInsets)padding {
    _padding = padding;
    
    [self updateLabelConstrains];
}

- (void)setIndicatorSize:(CGSize)indicatorSize {
    _indicatorSize = indicatorSize;
    
    [self updateLabelConstrains];
}

- (void)setDirection:(ZCYHintDirection)direction {
    _direction = direction;
    
    [self updateLabelConstrains];
}

- (void)setLabelBorderWidth:(CGFloat)labelBorderWidth {
    _labelBorderWidth = 2 * labelBorderWidth;
}

- (void)setHintText:(NSString *)hintText {
    self.label.text = hintText;
}

@end
