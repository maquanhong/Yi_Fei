//
//  AboutDetailViewController.m
//  Yi_Fei
//
//  Created by 徐友明 on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AboutDetailViewController.h"
#import "DetailTableViewCell.h"
static NSString *isData;
@interface AboutDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;


@end

@implementation AboutDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
   
    if ([_indexStr isEqualToString:@"0"]) {
        self.navigationItem.title = @"功能介绍";
        UILabel *label = [[UILabel alloc]init];
        CGFloat hight = [self heightForStringContent:_model.functionIntro] + 15;
        label.frame = CGRectMake(25, 80, self.view.bounds.size.width - 50, hight);
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        [self.view addSubview:label];
        label.text = self.model.functionIntro;
        
    }else if ([_indexStr isEqualToString:@"1"]){
        self.navigationItem.title = @"系统通知";
        UILabel *label = [[UILabel alloc]init];
        CGFloat hight = [self heightForStringContent:_model.privacyPolicy] + 20;
        label.frame = CGRectMake(25, 89, self.view.bounds.size.width - 50, hight);
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        [self.view addSubview:label];
        label.text = self.model.privacyPolicy;
    }else if ([_indexStr isEqualToString:@"2"]){
        UILabel *label = [[UILabel alloc]init];
        CGFloat hight = [self heightForStringContent:_model.customerService] + 20;
        label.frame = CGRectMake(25, 89, self.view.bounds.size.width - 50, hight);
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        [self.view addSubview:label];
        self.navigationItem.title =  @"联系客服";
        label.text = self.model.customerService;

    }else if ([_indexStr isEqualToString:@"3"]){
        
        self.navigationItem.title = @"检查新更新";
        
        
        NSString *temp =nil;
        for(int i =0; i < [_model.sysInform length]; i++)
        {
            temp = [_model.sysInform substringWithRange:NSMakeRange(i,1)];
            if ([temp isEqualToString:@"|"]) {
               isData = @"1";
            }

        }
        
        if ([isData isEqualToString:@"1"]) {
            self.dataArr = [_model.sysInform componentsSeparatedByString:@"|"];
        }else{
            if (_model.sysInform.length == 0) {
                self.dataArr = [[NSArray alloc]initWithObjects:@"", nil];
            }else{
                self.dataArr = [[NSArray alloc]initWithObjects:_model.sysInform, nil];
            }
        }
       
        
        [self creatView];
    }
    
    
    // Do any additional setup after loading the view.
}


- (void)creatView{
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailcell"];
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"detailcell" forIndexPath:indexPath];
    
    cell.titleLabel.text = self.dataArr[indexPath.row];
    return cell;
}


//xym
- (CGFloat)heightForStringContent:(NSString *)string{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}


- (void)setNav {
    
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
}
- (void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
