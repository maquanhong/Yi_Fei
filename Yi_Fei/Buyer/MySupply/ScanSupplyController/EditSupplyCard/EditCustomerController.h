//
//  EditCustomerController.h
//  Yi_Fei
//
//  Created by yons on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCustomerController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) NSString  *str;

@property (nonatomic,strong) UIImage  *image;

@property (nonatomic, copy) NSString *resultStr;



@end
