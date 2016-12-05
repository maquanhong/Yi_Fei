//
//  BUYNavigationControl.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "NavigationControl.h"

@interface NavigationControl ()

@end

@implementation NavigationControl

+ (void) initialize
{
    [[UINavigationBar appearance] setBarTintColor:NAVCOLOR];
    //设置左右两侧的文字为黑色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //设置中间标题的字体颜色或者大小，两者必须兼有
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
