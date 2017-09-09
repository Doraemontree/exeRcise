//
//  CommodityCommentViewController.m
//  exeRcise
//
//  Created by hemeng on 17/7/12.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "CommodityCommentViewController.h"
#import "CommentModel.h"

@interface CommodityCommentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    NSDictionary *commodityInfo;
    
    /*Commoditynum CommodityCategory userid username userdate comment*/
    NSMutableArray *commentAr;
    NSMutableArray *imageAr;//用户头像
    
    //textfield view
    UIView *textFieldView;
    UIButton *sendBtn;
    UITextView *textView;
    
    BOOL didLoadImage;//初始值为no 为yes时表示已经下载好用户头像
}

@end

@implementation CommodityCommentViewController
-(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}
- (instancetype)initWithCommodiyInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        commodityInfo = info;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    didLoadImage = NO;
    
    CommentModel *model = [[CommentModel alloc]init];
    
    [model loadCommodityCommentWithCommodityInfo:commodityInfo withUid:self.appDelegate.userInfo.uid];
    
    commentAr = [NSMutableArray array];
    
    model.returnComment = ^(NSArray *ar){
        commentAr = [NSMutableArray arrayWithArray:ar];
        //刷新评论
        [self performSelector:@selector(loadComment) withObject:nil];
    };
    model.returnImage = ^(NSArray *ar){
        imageAr = [NSMutableArray arrayWithArray:ar];
        //下载好图片
        didLoadImage = YES;
        
        [self performSelector:@selector(loadComment) withObject:nil];
    };
    
    self.navigationItem.title = @"商品评论";
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"ㄑ" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = back;

    self.navigationController.navigationBar.hidden = NO;
    
    [self CommodityComment];
    
    [self commentBtn];
    
    [self createTextFieldView];
}
-(void)backAction{
    self.navigationController.navigationBar.hidden = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadComment{
    if(commentAr.count == 0){
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        imageView.image = [UIImage imageNamed:@"emptyComment"];
        imageView.center = CGPointMake(187.5, 300);
        imageView.tag = 1;
        [self.view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.text = @"评论空空如也,来为它添加评论吧";
        label.center = CGPointMake(187.5, 375);
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 2;
        [self.view addSubview:label];
    }
    else{
        [self.CommodityComment reloadData];
    }
}

-(void)createTextFieldView{
    textFieldView = [[UIView alloc]initWithFrame:CGRectMake(0, 667, 375, 45)];
    textFieldView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldView];

    textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 2.5, 300, 40)];
    textView.font = [UIFont systemFontOfSize:18];
    [textFieldView addSubview:textView];
    
    sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(319, 8, 50, 30)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    sendBtn.layer.borderWidth = 2;
    sendBtn.layer.cornerRadius = 15;
    sendBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [textFieldView addSubview:sendBtn];
}

-(UIButton *)commentBtn{
    if(!_commentBtn){
        _commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 617, 375, 50)];
        _commentBtn.backgroundColor = [UIColor whiteColor];
        [_commentBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_commentBtn];
        
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
        text.text = @"请说出你的想法...";
        text.textColor = [UIColor grayColor];
        text.userInteractionEnabled = NO;
        [self.commentBtn addSubview:text];
    }
    return _commentBtn;
}

-(void)commentBtnAction{
    //将textfield带到最上面
    [self.view bringSubviewToFront:textFieldView];

    [textView becomeFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        textFieldView.frame = CGRectMake(0, 667 - 303, 375, 45);
    }];
}

-(void)sendAction{
    if([textView.text isEqualToString:@""]){
        UILabel *notice = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 40)];
        notice.center = CGPointMake(187.5, 333);
        notice.textAlignment = NSTextAlignmentCenter;
        notice.backgroundColor = [UIColor blackColor];
        notice.text = @"请输入评论";
        notice.layer.cornerRadius = 15;
        notice.textColor = [UIColor whiteColor];
        notice.alpha = 0.8;
        [self.view addSubview:notice];
        
        [UIView animateWithDuration:0.7 delay:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            notice.alpha = 0;
        } completion:nil];
        
        notice = nil;
    }
    else{
        //第一个评论要清除界面
        if(commentAr.count == 0){
            UIImageView *imageView = (UIImageView *)[self.view viewWithTag:1];
            [imageView removeFromSuperview];
            imageView = nil;
            UILabel *label = (UILabel *)[self.view viewWithTag:2];
            [label removeFromSuperview];
            label = nil;
        }
        //添加进commentAr
        NSMutableArray *ar = [NSMutableArray array];
        [ar addObject:[commodityInfo objectForKey:@"num"]];
        [ar addObject:[commodityInfo objectForKey:@"category"]];
        [ar addObject:self.appDelegate.userInfo.uid];
        [ar addObject:self.appDelegate.userInfo.name];
        [ar addObject:[self getTodayDate]];
        [ar addObject:textView.text];
        [ar addObject:@(commentAr.count + 1)];
        
        [commentAr addObject:ar];
        //刷新tableview
        [_CommodityComment reloadData];
        
        //添加进服务器
        CommentModel *model = [[CommentModel alloc]init];
        [model uploadCommodityCommentWithAr:ar];
        
        //清空textview
        textView.text = @"";
    }
}

-(UITableView *)CommodityComment{
    if(!_CommodityComment){
        _CommodityComment = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 375, 607) style:UITableViewStylePlain];
        _CommodityComment.dataSource = self;
        _CommodityComment.delegate = self;
        _CommodityComment.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _CommodityComment.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:236.0/255.0 blue:245.0/255.0 alpha:1];
        _CommodityComment.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_CommodityComment];
    }
    return _CommodityComment;
}

#pragma mark uitableviewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(textFieldView.frame.size.width != 667){
        [UIView animateWithDuration:0.2 animations:^{
            textFieldView.frame = CGRectMake(0, 667, 375, 45);
        }];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return commentAr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil];
    
    if(nib.count > 0){
        self.customCell = [nib objectAtIndex:0];
        cell = self.customCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //头像
    UIImageView *imageview = [self.customCell viewWithTag:1];
    imageview.layer.cornerRadius = 20;
    imageview.layer.masksToBounds = YES;
    //如果评论用户id与本机id一致 则直接读取头像 否则从网上下载
    if([[[commentAr objectAtIndex:indexPath.row]objectAtIndex:2] isEqualToString:self.appDelegate.userInfo.uid]){
        NSString *imageStr = [self.appDelegate.userInfo.uid stringByAppendingString:@".jpeg"];
        NSString *fullpath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageStr];
        UIImage *image = [[UIImage alloc]initWithContentsOfFile:fullpath];
        imageview.image = image;
    }
    else{
        if(didLoadImage == YES){//表示加载好头像
            for(int i = 0; i < imageAr.count; i++){
                //表示该cell的用户名与保存头像数组对应的用户名一致 则该名字匹配头像
                if([[[imageAr objectAtIndex:i]objectAtIndex:1] isEqualToString:[[commentAr objectAtIndex:indexPath.row]objectAtIndex:2]]){
                    imageview.image = [[imageAr objectAtIndex:i]objectAtIndex:0];
                }
            }
        }
    }
    //名称
    UILabel *name = [self.customCell viewWithTag:2];
    name.text = [[commentAr objectAtIndex:indexPath.row]objectAtIndex:3];
    //日期
    UILabel *date = [self.customCell viewWithTag:3];
    date.text = [[commentAr objectAtIndex:indexPath.row]objectAtIndex:4];
    
    //comment
    UILabel *comment = [self.customCell viewWithTag:4];
    comment.numberOfLines = 0;
    comment.lineBreakMode = NSLineBreakByTruncatingTail;
    comment.text = [[commentAr objectAtIndex:indexPath.row]objectAtIndex:5];
    CGSize maximumLabelSize = CGSizeMake(355, 500);//labelsize的最大值
    
    CGSize labelSize = [comment sizeThatFits:maximumLabelSize];
    comment.frame = CGRectMake(20, 50, labelSize.width, labelSize.height);
    
    cell.frame = CGRectMake(0, 0, 375, 65 + labelSize.height);
    //遮挡view
    UIView *view = [self.customCell viewWithTag:5];
    view.frame = CGRectMake(0, 0, 375, 55 + labelSize.height);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:self.CommodityComment cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

-(NSString *)getTodayDate{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *str = [formatter stringFromDate:date];
    
    return str;
    
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
