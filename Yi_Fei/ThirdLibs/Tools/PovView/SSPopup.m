//
//  OrdersDropdownSelection.m
//  CooperChimney
//
//  Created by Karthik Baskaran on 29/09/16.
//  Copyright © 2016 Karthik Baskaran. All rights reserved.
//

#import "SSPopup.h"

@interface SSPopup ()
{
    AppDelegate *appDelegate;
    
    NSArray *ordersarray;
    
    UIButton *ParentBtn;
}

@end
@implementation SSPopup

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
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    completionBlock=aCompletionBlock;
    ParentBtn=(UIButton *)sender;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Title=title;
    
   DropdownTable=[[UITableView alloc] init];
    DropdownTable.backgroundColor=[UIColor whiteColor];
    DropdownTable.dataSource=self;
    DropdownTable.delegate=self;
    DropdownTable.layer.cornerRadius=5.0f;
    [self addSubview:DropdownTable];
    NSInteger height = _index * 44;
    NSInteger tableViewHeight = self.bounds.size.height;
    if (height >= tableViewHeight) {
        [DropdownTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.leading.mas_equalTo(self).offset(20);
            make.trailing.mas_equalTo(self).offset(-20);
            make.height.mas_equalTo(tableViewHeight - 50);
        }];
    }else{
        [DropdownTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.leading.mas_equalTo(self).offset(30);
            make.trailing.mas_equalTo(self).offset(-30);
            make.height.mas_equalTo(height);
        }];
    }
    ordersarray=[[NSArray alloc]initWithArray:Contentarray];
    
    NormalAnimation(self.superview, 0.20f,UIViewAnimationOptionTransitionNone,
                    
            self.alpha=1;
               
)completion:nil];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ordersarray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    UIView *lineView =[[UIView alloc]init];
   lineView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [cell.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(cell.contentView);
        make.leading.mas_equalTo(cell.contentView);
        make.bottom.mas_equalTo(cell.contentView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    if(indexPath.row == [ordersarray count] -1){
        lineView.hidden=YES;
}
}
    cell.textLabel.text = ordersarray[indexPath.row];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [ParentBtn setTitle:[ordersarray objectAtIndex:indexPath.row] forState:UIControlStateNormal]; //Setting title for Button

    if (completionBlock) {
        
         completionBlock((int)indexPath.row);
    }
    
    if ([self.SSPopupDelegate respondsToSelector:@selector(GetSelectedOutlet:)]) {
        
         [self.SSPopupDelegate GetSelectedOutlet:(int)indexPath.row];
    }

    
    [self CloseAnimation];
    

}

-(void)CloseAnimation{
    
    NormalAnimation(self.superview, 0.20f,UIViewAnimationOptionTransitionNone,
                    
            DropdownTable.alpha=0;
                    
                    )
completion:^(BOOL finished){
    
    [DropdownTable removeFromSuperview];
    [self removeFromSuperview];
    
    
}];
}

@end
