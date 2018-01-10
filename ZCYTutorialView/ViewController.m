//
//  ViewController.m
//  ZCYTutorialView
//
//  Created by 張聰益 on 2017/12/21.
//

#import "ViewController.h"
#import "ZCYTutorialView.h"
#import "ZCYTutorialViewDecorator.h"
#import "ZCYTutorialViewDecoratorHint.h"
#import "ZCYTutorialViewDecoratorSpotlight.h"
#import "ZCYTutorialViewDecoratorBlurSpotlight.h"
#import "ZCYHintView.h"

@interface ViewController () <ZCYTutorialViewDelegate, ZCYTutorialViewHintDelegate>

@property (strong, nonatomic) UIButton *fatButton;
@property (strong, nonatomic) ZCYTutorialView *tutorialView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextView *textView = [UITextView new];
    textView.text = @"媽媽騎馬，馬慢，媽媽罵馬。 《施氏食獅史》。 紅鯉魚與綠鯉魚與驢 鋼彈盪單槓。 挽熊玩網球 和尚端湯上塔，塔滑湯灑湯燙塔；和尚端塔上湯，湯滑塔灑塔燙湯。 吃葡萄吐葡萄皮，不吃葡萄不吐葡萄皮。吃葡萄不吐葡萄皮，不吃葡萄倒吐葡萄皮。 扁擔寬，板凳長，扁擔想綁在板凳上，板凳不讓扁擔綁在板凳上，扁擔偏要綁在板凳上，板凳偏不讓扁擔綁在板凳上，到底是扁擔寬還是板凳長。 八百標兵奔北坡，炮兵並排北邊跑。炮兵怕把標兵碰，標兵怕碰炮兵炮。 天上七顆星，地下七塊冰，樹上七隻鷹，樑上七根釘，台上七盞燈。 石獅寺有四十四隻石獅子，不知到底是四十四隻石獅子，還是四十四隻死獅子。 蔣家羊楊家牆，蔣家羊撞倒了楊家牆，楊家牆壓死了蔣家羊，楊家要蔣家賠牆蔣家要楊家賠羊。 前山有個嚴圓眼，後山有個嚴眼圓，兩人上山來比眼，不知嚴圓眼的眼圓？還是嚴眼圓的眼圓？ 一葫蘆酒九兩六，一葫蘆油六兩九。六兩九的油，要換九兩六的酒；九兩六的酒，不換六兩九的油。 六十六歲的陸老頭，蓋了六十六間樓，買了六十六簍油，養了六十六頭牛，栽了六十六棵垂楊柳。六十六簍油，堆在六十六間樓；六十六頭牛，扣在六十六棵垂楊柳。忽然一陣狂風起，吹倒了六十六間樓，翻倒了六十六簍油，折斷了六十六棵垂楊柳，砸死了六十六頭牛，急煞了六十六歲的陸老頭。 哥哥弟弟坡前坐, 坡上臥著一隻鵝, 坡下流著一條河,哥哥說:寬寬的河, 弟弟說:白白的鵝。鵝要過河,河要渡 鵝,不知是鵝過河還是河渡鵝。 四是四，十是十，十四是十四，四十是四十；誰把十四說「十適」，就打他十四；誰把四十說「適十」，就打他四十。 呼嚕呼嚕扇滅七盞燈，噯唷噯唷拔掉七根釘，呀噓呀噓趕走七隻鷹，抬起一腳踢碎七塊冰，飛來烏雲蓋沒七顆星。一連念七遍就聰明。 永和有永和路，中和有中和路，中和的中和路有接永和的中和路，永和的永和路沒接中和的永和路；永和的中和路有接永和的永和路，中和的永和路沒接中和的中和路。永和有中正路，中和有中正路，永和的中正路用景平路接中和的中正路；永和有中山路，中和有中山路，永和的中山路直接接上了中和的中山路。永和的中正路接上了永和的中山路，中和的中正路卻不接中和的中山路。中正橋下來不是中正路，但永和有中正路；秀朗橋下來也不是秀朗路，但永和也有秀朗路。永福橋下來不是永福路，永和沒有永福路；福和橋下來不是福和路，但福和路接的是永福橋。* 且南來了個啞巴，腰裡別著個喇叭。 且北來了個喇嘛，手裡提拉著五斤鰨蟆。 別了喇叭啞巴要拿喇叭換提拉[1]鰨蟆喇嘛的鰨蟆，提拉鰨蟆喇嘛就不拿鰨蟆換別了喇叭啞巴的喇叭。 別了喇叭啞巴要拿喇叭打提拉鰨蟆喇嘛一喇叭，提拉鰨蟆喇嘛要拿鰨蟆打別了喇叭啞巴一鰨蟆。 不知道是提拉鰨蟆喇嘛拿鰨蟆打了別了喇叭啞巴一鰨蟆，也不知道是別了喇叭啞巴拿喇叭打了提拉鰨蟆喇嘛一喇叭。 啞巴吹喇叭，那個喇嘛回家燉鰨蟆。 黑化肥發灰，灰化肥發黑。 黑化肥揮發會發灰；灰化肥揮發會發黑。 黑化肥揮發發灰會揮發；灰化肥揮發發黑會發揮。 黑灰化肥會揮發發灰黑化肥揮發；灰黑化肥會揮發發黑灰化肥發揮。 黑灰化肥會揮發發灰黑化肥黑灰揮發化為灰；灰黑化肥會揮發發黑灰化肥灰黑發揮化為黑。 黑化黑灰化肥黑灰會揮發發灰黑化肥黑灰化肥揮發；灰化灰黑化肥灰黑會發揮發黑灰化肥灰黑化肥發揮。 台語的繞口令[編輯] 溝頂一隻猴，溝底一隻狗，狗鬧勾著猴，猴哭輾過狗，猴走狗亦走，狗走猴亦走，是狗驚猴亦是猴驚狗？ 姑無索假嫂剪索。嫂無鎖假姑借鎖。嫂講有索，叫姑來提剪刀剪索。姑講有鎖，叫嫂來提鎖鎖鎖。嫂叫姑拿鎖，姑叫嫂拿索。 壁掛鼓，鼓畫虎，虎爬鼓，拿布補，是布補虎亦是布補鼓？ 姓傅的提布給查某買褲，傅的因某食醋，放虎掠傅，傅仔走路，半路破褲。 粵語的繞口令[編輯] 入實驗室㩒緊急掣。 入食物實驗室撳實十個緊急掣。 雞龜骨滾羹 三蚊一斤雞，兩蚊一斤龜，你話係雞貴過龜，定係龜貴過雞，我話係雞貴過龜，唔係龜貴過雞，原來係龜貴過雞。 郵差叔叔送信純熟迅速送出。 痴線雌性蜘蛛啲蜘蛛絲痴住枝樹枝。 牆角撞床腳 大吉大利巨無霸，蘋果批熱暖萬家；年年有餘魚柳飽，薯條常滿笑哈哈。 獅子山上獅山寺，山寺門前四獅子。山寺是禪寺，獅子是石獅。獅子看守獅山寺，禪寺保護石獅子。 掘柑掘桔掘金桔，掘雞掘骨掘龜骨，掘完雞骨掘金桔，掘完龜骨掘雞骨 床腳撞牆角，牆角撞床腳， 你話床角撞牆角定牆角撞床腳 白石塔，白石搭，白石搭白塔，白塔白石搭。搭好白石塔，白塔白又滑 注釋[編輯] 移至 ^ dīla 2 個分類：漢語文字遊戲";
    textView.textColor = [UIColor blackColor];
    textView.frame = CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 200);
    [self.view addSubview:textView];
    
    self.fatButton = ({
        UIButton *button = [UIButton new];
        [button setTitle:@"我是按鈕矮又肥呀" forState:UIControlStateNormal];
        [button sizeToFit];
        button.center = CGPointMake(CGRectGetMaxX(self.view.frame) / 2.f,
                                    CGRectGetMaxY(self.view.frame) / 4.f * 3);
        button.backgroundColor = [UIColor yellowColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(fabButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:self.fatButton];
    
    self.tutorialView = [[ZCYTutorialView alloc] initWithDelegate:self];
    self.tutorialView = [ZCYTutorialViewDecoratorHint makeWith:self.tutorialView andDelegate:self];
    self.tutorialView = [ZCYTutorialViewDecoratorSpotlight makeWith:self.tutorialView];
    self.tutorialView.closeOnTouch = YES;
    self.tutorialView.closeOnFocusedTouch = NO;
    self.tutorialView.ignoreOnFocusedTouch = YES;
    self.tutorialView.dismissOnly = YES;
    [self.tutorialView focus:textView, nil];
}

- (void)fabButtonDidClick:(id)sender {
    NSLog(@"Don't poke me!!! I'm FatButton");
    
    [self.tutorialView show];
}

#pragma mark - ZCYTutorialViewHintDelegate

- (ZCYHintObject *)tutorialView:(ZCYTutorialView *)tutorialView hintViewForFocusView:(UIView *)focusView atIndex:(NSUInteger)index {
    
    ZCYHintView *hintView = ({
        ZCYHintView *view = [[ZCYHintView alloc] init];
        view.labelBorderColor = [UIColor greenColor];
        view.labelBorderWidth = 2;
        view.labelBackgroundColor = [UIColor whiteColor];
        view.labelBackgroundCornerRadius = 5;
        view.font = [UIFont systemFontOfSize:16];
        view.padding = UIEdgeInsetsMake(8, 16, 8, 16);
        view.margin = UIEdgeInsetsMake(8, 8, 8, 8);
        view.indicatorSize = CGSizeMake(10, 10);
        view.direction = ZCYHintDirectionBottom;
        view.gap = 10;
//        view.originOnDirectionNone = CGPointMake(0, 200);
        [view setHintText:@"10101011010路人勿指我"];
        view;
    });
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"正面按我！" forState:UIControlStateNormal];
    button.frame = CGRectMake(16, 400, 100, 30);
    [button addTarget:self action:@selector(hintButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    return ({
        ZCYHintObject *hint = [[ZCYHintObject alloc] init];
        hint.view = button;
        hint.viewDidAdd = ^(UIView *hintView) {
//            [(ZCYHintView *)hintView showHintAtView:focusView];
        };
        hint;
    });
}

- (void)hintButtonClicked {
    NSLog(@"My precious hintButton clicked");
}

#pragma mark - ZCYTutorialViewDelegate

- (void)dismissedWithTutorialView:(ZCYTutorialView *)tutorialView {
    NSLog(@"%@ dismissed.", tutorialView);
}

@end
