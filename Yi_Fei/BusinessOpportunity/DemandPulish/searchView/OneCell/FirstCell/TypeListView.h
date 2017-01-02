//
//  TypeListView.h
//  Yi_Fei
//
//  Created by yons on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

@interface TypeListView : UIView<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *listImageView;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic)  UICollectionViewFlowLayout *flowLayOut;
@property (weak, nonatomic) IBOutlet UIView *backView;

+(TypeListView*)instanceTypeListView;

-(void)reloadData;

@property (nonatomic,strong) NSMutableArray *array;


@end




