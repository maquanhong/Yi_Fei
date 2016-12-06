//
//  OrdersDropdownSelection.m
//  CooperChimney
//
//  Created by Karthik Baskaran on 29/09/16.
//  Copyright © 2016 Karthik Baskaran. All rights reserved.
//

#import "PopView.h"
#import "Masonry.h"
#import "SelectTableViewCell.h"

@interface PopView ()<SelectTableViewCellDelegate>
{
    AppDelegate *appDelegate;
    SelectTableViewCell *cell;
    NSArray *ordersarray;
    UIButton *cacelBtn;    //取消按钮
    UIButton *certainBtn;  //确定按钮
    NSInteger _index;
}
@end
@implementation PopView

- (id)initWithFrame:(CGRect)frame delegate:(id<SSPopupDelegate>)delegate
{
    self = [super init];
    if ((self = [super initWithFrame:frame]))
    {
        self.SSPopupDelegate = delegate;
    }
    
    return self;
}


-(void)CreateTableview:(NSArray *)Contentarray withSender:(id)sender  withTitle:(NSString *)title setCompletionBlock:(VSActionBlock )aCompletionBlock{
    
    [self addTarget:self action:@selector(CloseAnimation) forControlEvents:UIControlEventTouchUpInside];
    self.alpha=0;
    self.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.5];
    completionBlock=aCompletionBlock;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Title=title;
    
    DropdownTable=[[UITableView alloc]  init ];
    DropdownTable.backgroundColor=[UIColor whiteColor];
    DropdownTable.dataSource=self;
    DropdownTable.scrollEnabled = NO;
    DropdownTable.delegate=self;
    DropdownTable.layer.cornerRadius=5.0f;
//  DropdownTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:DropdownTable];
    [DropdownTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(50);
        make.trailing.mas_equalTo(self).offset(-50);
        make.height.mas_equalTo(230);
    }];
    ordersarray=[[NSArray alloc]initWithArray:Contentarray];
 NormalAnimation(self.superview, 0.30f,UIViewAnimationOptionTransitionNone,
                    
    self.alpha=1;
               
)completion:nil];
    
}

#pragma mark 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifer1 = @"firstCell";
    cell  = [tableView dequeueReusableCellWithIdentifier:identifer1];
    if (cell == nil) {
        cell = [[SelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
    }
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.delegate = self;
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark Cell的代理方法
-(void)clickEmailBtn:(NSInteger)number{
    _index = number;
}


-(void)clickBloothBtn:(NSInteger)number{
    _index = number;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

//tableVie高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *myview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,10)];
    [myview setBackgroundColor:RGB(227, 9, 50)];
    UILabel *headLbl=[[UILabel alloc] init];
    headLbl.backgroundColor=[UIColor clearColor];
    headLbl.textColor=[UIColor whiteColor];
    headLbl.text=Title?Title:@"Select";
    headLbl.textAlignment=NSTextAlignmentCenter;
    headLbl.font=AvenirMedium(18);
    [myview addSubview:headLbl];
    [headLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(myview);
        make.trailing.mas_equalTo(myview);
        make.top.mas_equalTo(myview.mas_top);
        make.bottom.mas_equalTo(myview.mas_bottom);
    }];
    
    return myview;
}


//tableVie高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}


-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
  UIView *myview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,30)];
    myview.userInteractionEnabled = YES;
     NSInteger width = myview.frame.size.width / 12;
    cacelBtn =  [[UIButton alloc] init];
    [cacelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cacelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cacelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [myview addSubview:cacelBtn];
    [cacelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(myview).offset(width);
        make.bottom.mas_equalTo(myview.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    [cacelBtn addTarget:self action:@selector(removSuperView) forControlEvents:UIControlEventTouchUpInside];
    
    certainBtn =  [[UIButton alloc] init];
     [certainBtn setTitle:@"确定" forState:UIControlStateNormal];
    certainBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [certainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myview addSubview:certainBtn];
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(myview).offset(-width);
        make.bottom.mas_equalTo(myview.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    [certainBtn addTarget:self action:@selector(nextOperation:) forControlEvents:UIControlEventTouchUpInside];
    return myview;
}


#pragma mark 确定操作
-(void)nextOperation:(UIButton*)btn{
    
    if (completionBlock) {
        completionBlock((int)_index);
    }
    if ([self.SSPopupDelegate respondsToSelector:@selector(GetSelectedOutlet:)]) {
        [self.SSPopupDelegate GetSelectedOutlet:(int)_index];
    }
    [self CloseAnimation];
    
}

#pragma mark 取消操作
-(void)removSuperView{
    [self CloseAnimation];
}

-(void)CloseAnimation{
NormalAnimation(self.superview, 0.30f,UIViewAnimationOptionTransitionNone,
                    DropdownTable.alpha=0;
        )
completion:^(BOOL finished){
    [DropdownTable removeFromSuperview];
    [self removeFromSuperview];
}];

}



















@end


































