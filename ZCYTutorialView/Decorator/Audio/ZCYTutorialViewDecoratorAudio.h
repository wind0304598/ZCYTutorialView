//
//  ZCYTutorialViewDecoratorAudio.h
//  ZCYTutorialView
//
//  Created by 張聰益 on 2018/1/10.
//

#import "ZCYTutorialViewDecorator.h"

@class ZCYAudioConfig;

@protocol ZCYTutorialViewAudioDelegate <NSObject>

- (NSURL *)sourceUrlNeedByTutorialView:(ZCYTutorialView *)tutorialView;

@optional

- (UIButton *)skipButtonNeedByTutorialView:(ZCYTutorialView *)tutorialView withDefaultButton:(UIButton *)defaultButton;

- (ZCYAudioConfig *)audioConfigNeedByTutorialView:(ZCYTutorialView *)tutorialView;

@end

@interface ZCYTutorialViewDecoratorAudio : ZCYTutorialViewDecorator

@property (weak, nonatomic) id<ZCYTutorialViewAudioDelegate>audioDelegate;

+ (ZCYTutorialView *)makeWith:(ZCYTutorialView *)tutorialView andDelegate:(id<ZCYTutorialViewAudioDelegate>)delegate;

@end

@interface ZCYAudioConfig : NSObject

@property (nonatomic) CGFloat holdSkipButtonForSeconds;

@end
