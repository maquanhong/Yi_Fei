//
//  EditFourShopCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "EditFourShopCell.h"

@interface EditFourShopCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@end



@implementation EditFourShopCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView
{
    NSInteger count =  _imageArray.count;
    NSInteger height;
    if (count % 4 != 0) {
        height = count / 4;
    }else{
        height = count / 4 + 1;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((WIDTH - 50)  / 4, (WIDTH - 50) / 4);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 10000) collectionViewLayout:layout];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionView"];
    [self.contentView addSubview: _collectionView];
    [_collectionView reloadData];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    //由于cell可复用，可采用如下逻辑判断contentView上是否已经添加imageView
    UIImageView *imageView = [cell.contentView viewWithTag:1000];
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        imageView.tag = 1000;
    imageView.image= [UIImage imageWithContentsOfFile:_imageArray[indexPath.item]];
        [cell.contentView addSubview:imageView];
    }else{
        imageView.image = _imageArray[indexPath.item];
    }
    return cell;
    
}






@end










