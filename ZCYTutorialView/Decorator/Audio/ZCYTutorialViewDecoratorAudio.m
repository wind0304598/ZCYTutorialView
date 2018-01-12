//
//  ZCYTutorialViewDecoratorAudio.m
//  ZCYTutorialView
//
//  Created by 張聰益 on 2018/1/10.
//

#import "ZCYTutorialViewDecoratorAudio.h"
#import <AVFoundation/AVFoundation.h>

@interface ZCYTutorialViewDecoratorAudio ()

@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) id playbackTimeObserver;
@property (strong, nonatomic) UIButton *skipButton;

@property (nonatomic) CGFloat holdSkipButtonForSeconds;

@end

@implementation ZCYTutorialViewDecoratorAudio

+ (ZCYTutorialView *)makeWith:(ZCYTutorialView *)tutorialView andDelegate:(id<ZCYTutorialViewAudioDelegate>)delegate {
    ZCYTutorialViewDecoratorAudio *tutorialViewDecorator = [super makeWith:tutorialView];
    tutorialViewDecorator.audioDelegate = delegate;
    return tutorialViewDecorator;
}

- (void)setup {
    [super setup];
    
    self.userInteractionEnabled = NO;
    [self.baseTutorialView addSubview:self];
    
    self.baseTutorialView.closeOnTouch = YES;
    self.baseTutorialView.closeOnFocusedTouch = NO;
    self.baseTutorialView.dismissOnly = YES;
    self.baseTutorialView.ignoreOnFocusedTouch = YES;
    
    [self setupSkipButton];
}

- (void)setupSkipButton {
    self.skipButton = ({
        CGFloat buttonMargin = 16;
        CGSize buttonSize = CGSizeMake(self.frame.size.width - 2 * buttonMargin, 40);
        CGPoint buttonOrigin = CGPointMake(buttonMargin, self.frame.size.height - buttonMargin - buttonSize.height);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor colorWithWhite:0 alpha:.6f] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithWhite:0 alpha:.1f] forState:UIControlStateDisabled];
        [button setTitle:@"skip" forState:UIControlStateNormal];
        button.layer.cornerRadius = 4;
        button.clipsToBounds = YES;
        button.adjustsImageWhenHighlighted = NO;
        button.adjustsImageWhenDisabled = NO;
        button.frame = CGRectMake(buttonOrigin.x, buttonOrigin.y, buttonSize.width, buttonSize.height);
        if ([self respondsToSelector:@selector(skipButtonDidClick)]) {
            [button addTarget:self action:@selector(skipButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        }
        button;
    });
    [self addSubview:self.skipButton];
    
    if (self.audioDelegate && [self.audioDelegate respondsToSelector:@selector(skipButtonNeedByTutorialView:withDefaultButton:)]) {
        self.skipButton = [self.audioDelegate skipButtonNeedByTutorialView:self.baseTutorialView withDefaultButton:self.skipButton];
    }
}

- (void)show {
    [super show];
    
    if (self.audioDelegate && [self.audioDelegate respondsToSelector:@selector(audioConfigNeedByTutorialView:)]) {
        ZCYAudioConfig *audioConfig = [self.audioDelegate audioConfigNeedByTutorialView:self.baseTutorialView];
        self.holdSkipButtonForSeconds = audioConfig.holdSkipButtonForSeconds;
    }
    [self updateSkipButton];
    [self playAudio];
}

- (void)dismiss {
    [super dismiss];
    
    [self stopAudio];
}

- (void)playAudio {
    if (!self.audioDelegate || ![self.audioDelegate respondsToSelector:@selector(sourceUrlNeedByTutorialView:)]) {
        return;
    }
    
    self.playerItem = [AVPlayerItem playerItemWithURL:[self.audioDelegate sourceUrlNeedByTutorialView:self.baseTutorialView]];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
}

- (void)stopAudio {
    [self.player pause];
    @try {
        [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    } @catch (id exception) {
    }
    if (self.playbackTimeObserver) {
        [self.player removeTimeObserver:self.playbackTimeObserver];
        self.playbackTimeObserver = nil;
    }
}

- (void)skipButtonDidClick {
    [self dismiss];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isEqual:self.playerItem] && [keyPath isEqualToString:@"status"]) {
        if ([self.playerItem status] == AVPlayerStatusReadyToPlay) {
            [self monitoringPlayback:self.playerItem];
            
            [self.player play];
        } else if ([self.playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    }
}

- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(.01f, NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time) {
        [weakSelf updateSkipButton];
    }];
}

- (void)updateSkipButton {
    CGFloat currentSecond = CMTimeGetSeconds(self.playerItem.currentTime);
    CGFloat durationSecond = CMTimeGetSeconds(self.playerItem.duration);
    if (isnan(durationSecond)) {
        currentSecond = 0;
        durationSecond = CGFLOAT_MAX;
    }
    
    [self updateSkipButtonAbilityWithCurrentSecond:currentSecond];
    [self updateSkipButtonBackgroundWithCurrentPercentage:currentSecond / durationSecond];
}

- (void)updateSkipButtonAbilityWithCurrentSecond:(CGFloat)currentSecond {
    BOOL enabled = currentSecond >= self.holdSkipButtonForSeconds;
    if (self.skipButton.enabled != enabled) {
        self.skipButton.enabled = enabled;
    }
}

- (void)updateSkipButtonBackgroundWithCurrentPercentage:(CGFloat)currentPercentage {
    CGFloat newWidth = (self.skipButton.frame.size.width) * currentPercentage;
    [self.skipButton setBackgroundImage:[self progressBarImageWithPassedWidth:newWidth] forState:UIControlStateNormal];
}

- (UIImage *)progressBarImageWithPassedWidth:(CGFloat)passedwidth {
    CGSize imageSize = self.skipButton.frame.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    [[UIColor colorWithWhite:1 alpha:1] set];
    UIRectFill(CGRectMake(0, 0, passedwidth, self.skipButton.frame.size.height));
    [[UIColor colorWithWhite:1 alpha:.6f] set];
    UIRectFill(CGRectMake(passedwidth, 0, self.skipButton.frame.size.width - passedwidth, self.skipButton.frame.size.height));
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void)dealloc {
    @try {
        [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    } @catch (id exception) {
    }
    if (self.playbackTimeObserver) {
        [self.player removeTimeObserver:self.playbackTimeObserver];
        self.playbackTimeObserver = nil;
    }
}

@end

@implementation ZCYAudioConfig

@end
