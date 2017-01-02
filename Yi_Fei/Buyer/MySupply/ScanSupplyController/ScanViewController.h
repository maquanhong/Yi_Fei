//
//  ScanViewController.h
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSString *_dataStr;
}

@property (nonatomic, copy) NSString *resultStr;







@end










