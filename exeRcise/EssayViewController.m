//
//  EssayViewController.m
//  exeRcise
//
//  Created by hemeng on 17/5/11.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "EssayViewController.h"
#import "essayModel.h"
@interface EssayViewController (){
    int whichOne;
    
    UIView *maskview;
}

@end

@implementation EssayViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNum:) name:@"essay" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    essayModel *model = [[essayModel alloc]init];
    
    [model loadNews];
    
    maskview     = [[UIView alloc]initWithFrame:CGRectMake(0, 225, self.view.bounds.size.width, 10)];
    maskview.tag = 2;
    maskview.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self scrollView];
    
    [self pic];
    
    [self.scrollView addSubview:maskview];
    
    [self Title];
    
    [self paragraphOne];
    
    [self swipeGesture];
    
    if(whichOne == 0){
        self.pic.image = [UIImage imageNamed:@"titleImage-1"];
        _Title.text = @"运动饮食选择";
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 220);
    }
    else if(whichOne == 1){
        self.pic.image = [UIImage imageNamed:@"titleImage-2"];
        _Title.text = @"正确喝水的姿势";
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 460);
    }
    else if(whichOne == 2){
        self.pic.image = [UIImage imageNamed:@"titleImage-3"];
        _Title.text = @"健康小贴士";
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 840);
    }
    
    [self backBtn];
 
    // Do any additional setup after loading the view.
}
-(void)getNum:(NSNotification *)notification{
    whichOne = (int)[notification.userInfo[@"item"] integerValue];

}
-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView             = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        
        _scrollView.center      = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2 - 20);
        _scrollView.bounces     = YES;
        _scrollView.delegate    = self;

        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(UIImageView *)pic{
    if(!_pic){
        _pic             = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 225)];
        _pic.tag         = 1;
        _pic.contentMode = UIViewContentModeScaleToFill;
  
        [self.scrollView addSubview:_pic];
    }
    return _pic;
}
-(UILabel *)Title{
    if(!_Title){
        _Title = [[UILabel alloc]initWithFrame:CGRectMake(20, 225, 250, 40)];
        _Title.font = [UIFont systemFontOfSize:31];

        [self.scrollView addSubview:_Title];
    }
    return _Title;
}
-(UILabel *)paragraphOne{
    if(!_paragraphOne){
        if(whichOne == 0){
            _paragraphOne = [[UILabel alloc]initWithFrame:CGRectMake(20, 235, 335, 730)];
            
            NSString *str = @"运动前选择温性食物\n        假如想使体内脂肪代谢速度加快，那可在做运动前的一个小时选择食用温热性食品，就能有效提高身体基础代谢率，如红萝卜、辣椒、姜、葱、蒜头、胡椒等，但如果肠胃道不适的人，最好不要食用太多刺激性温热食材，如辣椒、胡椒等。\n\n运动前适量补充碳水化合物\n        尽管减肥过程中热量控制很重要，不过千万别认为饿肚子运动会让你更瘦，由于运动消耗体内热量水分，若空腹运动，反会让心理有补偿作用，运动后反而吃得更多。因此，如果不是饭后1-1.5小时后运动，最好在运动前1小时，补充适量碳水化合物，如优酪乳、水果等易消化食物，除可避免运动后血糖下降等不适症状，也能增加运动的持久性与降低运动过后的疲劳感与饥饿感。\n\n运动后要摄入少量高纤食品\n        减肥者在运动后一个小时内可以适量饮用些开水，补充因运动而过度流失的水分，也减少饥饿感。待运动后1小时以上，仍觉得肚子饿时，再少量食用全谷类食物，可有效帮助身体燃烧脂肪，让瘦身效果更显著。若想提高细胞新陈代谢率，可以补充含有胶原蛋白的食物，如鲜奶、鸡蛋、鱼皮等。";

            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:str];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:16] range:NSMakeRange(0, 469)];
            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 12)];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(123, 20)];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(316, 14)];
            
            _paragraphOne.attributedText = attriStr;
            _paragraphOne.numberOfLines  = 28;
        }
        else if(whichOne == 1){
            
            _paragraphOne = [[UILabel alloc]initWithFrame:CGRectMake(20, 260, 335, 960)];
            
            NSString *str = @"        人每天都在运动，运动消耗大量能量，产生大量的汗液，在 加上体内不断进行的新陈代谢，一个人每天必须补充足够的水分，才能维持机体正常的运转。一个人一天到底要喝多少水呢？都在什么时间喝好呢？\n\n第一杯水\n        应该在早上起床后六点半左右，因为这个时候休息了一个晚上，喝水以后可以促进体内的毒素从尿中排泄，并且补充了在夜晚丢失的水分，对容颜也有保养作用，能够补充皮肤中缺失的水分，维持皮肤的弹性。\n\n第二杯水\n        应该在早上八点半时喝，这时候刚上班，一路上奔波劳碌，丢失了不少水分，这时候喝水对人体的健康是大有好处的。\n\n第三杯水\n        应该在11:00左右喝，因为这时候经过一上午的劳碌，人体已经很疲劳，并且也丢失了不少的水分，这时候喝水能够起到解乏的作用。并且能够让人体放松。\n\n第四杯水\n        应该在中午12:00左右喝，因为这时候喝，可以稀释人体的胃酸，能起到减肥的作用，减轻人体的负荷。\n\n第五杯水\n        应该在下午三点钟喝，这时候，刚上班，喝杯水能够起到提神醒脑的作用。\n\n第六杯水\n        应该在下午五点半钟喝，因为这个时候喝一杯水，对消化吸收有一定的作用。\n\n第七杯水\n        应该在晚上十点钟左右喝，这个时候喝能够促进体内的代谢产物排出，增进血液循环，晚上能够睡个好觉。";
            
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:str];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:16] range:NSMakeRange(0, 582)];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(102, 8)];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(207, 8)];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(275, 8)];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(360, 8)];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(423, 8)];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(473, 8)];
            
            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(521, 8)];
            
            _paragraphOne.attributedText = attriStr;
            _paragraphOne.numberOfLines  = 45;

        }
        else if(whichOne == 2){
            _paragraphOne = [[UILabel alloc]initWithFrame:CGRectMake(20, 265, 335, 1460)];
            
            NSString *str = @"1.常吃宵夜，会得胃癌，因为胃得不到休息。\n2.一个星期只能吃四颗蛋，吃太多对身体不好。\n3.鸡屁股含有致癌物，不要吃较好。\n4.饭后吃水果是错误的观念，应是饭前吃水果。\n5.喝豆浆时，不要加鸡蛋和糖，也不要喝太多。\n6.空腹时不要吃蕃茄，最好饭后吃。\n7.早上醒来，先喝一杯水，预防结石。\n8.睡前三小时不要吃东西，会胖。\n9.少喝奶茶，因为高热量，高油，没有营养价值可言，长期饮用，易罹患高血压，糖尿病等疾病。\n10.刚出炉的面包不宜马上食用。\n11.远离充电座，人体应远离30公分以上，切忌放在床边。\n12.天天喝水八大杯。\n13.每天十杯水，膀胱癌不会来。\n14.白天多喝水，晚上少喝水。\n15.一天不要喝两杯以上的咖啡，喝太多易导致失眠、胃痛。\n16.多油脂的食物少吃，因为得花5-7小时去消化，并使脑中血液集中到肠胃，易昏昏欲睡。\n17.下午五点后，大餐少少吃，因为五点后身体不需那么多能量。\n18.10种吃了会快乐的食物:深海鱼、香蕉、葡萄柚、全麦面包、菠菜、大蒜、番瓜、低牛奶、鸡肉、樱桃。\n19.睡眠不足会变笨，一天须八小时睡眠，有午睡习惯较不会老。\n20.最佳睡眠时间是在晚上10点-清晨6点。\n21.每天喝酒不要超过一杯，因为酒精会抑制制造抗体的B细胞，增加细菌感染的机会。\n22.服用胶囊应以冷水吞服(可以第一个吃)，睡前30分钟先服药，忌立即躺下。\n23.酸梅具防止老化作用，青春永驻;肝火有毛病者宜多食用。\n24.掉发因素:熬夜、压力、烟酒、香鸡排、麻辣锅、油腻食物、调味过重的料理。\n25.帮助头发生长:多食用包心菜、蛋、豆类;少吃甜食(尤其是果糖)。\n26.每天一杯柠檬汁、柳橙汁，不但可以美白，还可以淡化黑斑。\n27.苹果:机车族，瘾君子，家庭主妇的常备良药。一天一颗，才能让自己有个干干净净的肺。\n28.抽烟又吃维他命(B胡萝卜素-A维他命的一种)会致癌，尽早戒烟，才是最健康的做法。\n29.女性不宜喝茶的五个时?月经来时、孕妇、临产前、生产完后、更年期。\n30.抽烟:关系最大的是肺癌、唇癌、也与膀胱癌有关。\n31.饮酒导致肝硬化，引发肝癌。\n32.吃槟榔会导致口腔纤维化，引发口腔癌。\n33.食物过于精细，缺乏纤维，含大量脂肪，尤其是胆固醇，会引发胃癌。\n34.食物过于粗糙，营养不足时，导致食道癌、胃癌。\n35.食物中的黄曲毒素、亚硝酸类物皆具有致癌性。\n36.不抽烟、拒吸二手烟。\n37.适量饮酒，不拚酒，不醉酒。\n38.减少食用盐腌、烟熏、烧烤的食物。\n39.每天摄取新鲜的蔬菜与水果。\n40.每天摄取富含高纤维的五谷类及豆类。\n41.每天摄取均衡的饮食，不过量。\n42.保持规律的生活与运动。";
            
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:str];

            [attriStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:16] range:NSMakeRange(0, 1120)];
            
            _paragraphOne.attributedText = attriStr;
            _paragraphOne.numberOfLines  = 70;
        }
        
        [self.scrollView addSubview:_paragraphOne];
    }
    return  _paragraphOne;
}

-(UIButton *)backBtn{
    if(!_backBtn){
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
        [_backBtn setTitle:@"<" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_backBtn];
    }
    return _backBtn;
}
-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    //BOOL direction = NO;//在临界点时改变值 改变值时设置pic且只改变一次
    float contentOffsetY;//图像顶部与屏幕顶部的距离
    
    if(scrollView.contentOffset.y < -20){//向上滑动
//        if(direction == NO){
//            self.pic.frame = CGRectMake(0, 0, 375, 225);
//            direction      = YES;
//        }
        
        contentOffsetY = -(20 + scrollView.contentOffset.y);
    
        CGRect rect      = CGRectMake(0, 0, 375, 225);
        rect.size.height = contentOffsetY * 2 + 225 ;
        rect.size.width  = contentOffsetY * 2 + 375 ;
        
        [[scrollView viewWithTag:1] setBounds:rect];
        [[scrollView viewWithTag:2] setFrame:CGRectMake(0, 225 + contentOffsetY, 375, 10)];
        [self.Title setFrame:CGRectMake(20, 225 + contentOffsetY, 250, 40)];
        
        if(whichOne == 0)//不同的文章
            [self.paragraphOne setFrame:CGRectMake(20, 235 + contentOffsetY, 335, 730)];
        else if(whichOne == 1)
            [self.paragraphOne setFrame:CGRectMake(20, 260 + contentOffsetY, 335, 960)];
        else if(whichOne == 2)
            [self.paragraphOne setFrame:CGRectMake(20, 265 + contentOffsetY, 335, 1460)];
        
    }
    else if(scrollView.contentOffset.y > - 20){//向下拖动

//        if(direction == YES){
//            self.pic.frame = CGRectMake(0, 0, 375, 225);
//            direction      = NO;
//            NSLog(@"yes");
//        }
        contentOffsetY = (scrollView.contentOffset.y + 20);
        
        CGRect rect;
        rect.size.height = 225;
        rect.size.width  = 375;
        rect.origin.x    = 0;
        rect.origin.y    = contentOffsetY / 4;
        
        [[scrollView viewWithTag:1] setFrame:rect];
        [[scrollView viewWithTag:2] setFrame:CGRectMake(0, 225 - contentOffsetY/4, 375, 10 + contentOffsetY/2)];
        [self.Title setFrame:CGRectMake(20, 225 - contentOffsetY/4, 250, 40)];
        
        if(whichOne == 0)
            [self.paragraphOne setFrame:CGRectMake(20, 235 - contentOffsetY/4, 335, 730)];
        else if(whichOne == 1)
            [self.paragraphOne setFrame:CGRectMake(20, 260 - contentOffsetY/4, 335, 960)];
        else if(whichOne == 2)
            [self.paragraphOne setFrame:CGRectMake(20, 265 - contentOffsetY/4, 335, 1460)];
            
    }
}
-(UISwipeGestureRecognizer *)swipeGesture{
    if(!_swipeGesture){
        _swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        _swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        
        [self.view addGestureRecognizer:_swipeGesture];
    }
    return _swipeGesture;
}
-(void)swipeAction:(UISwipeGestureRecognizer *)gesture{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
