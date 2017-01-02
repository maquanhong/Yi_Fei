//
//  TypeListView.m
//  Yi_Fei
//
//  Created by yons on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TypeListView.h"


@implementation TypeListView

+(TypeListView *)instanceTypeListView{
NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"TypeListView" owner:self options:nil];
    return [ nibView lastObject];
}


#pragma mark 这个方法是初始化对象用的，对象还没有形成，不能赋值
#pragma mark 对象已经形成，可以对其进行赋值
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.lineView.backgroundColor = BACKCOLOR;
    self.listImageView.image = [UIImage imageNamed:@"xiala"];
    _flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    _flowLayOut.itemSize = CGSizeMake(60, 20);
    _flowLayOut.sectionInset = UIEdgeInsetsMake(5, 5, 5, 2.5);
    _collectionView.collectionViewLayout = _flowLayOut;
    _collectionView.delegate = self;
    _collectionView.dataSource =self;
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

#pragma mark--UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:self options:nil] lastObject];
    }
  cell.tiltleLabel.text = self.array[indexPath.row];
  return cell;
}

#pragma mark--UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.array removeObjectAtIndex:indexPath.row];
    [_collectionView reloadData];
}




-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark--UICollectionViewDelegateFlowLayout

-(void)reloadData{
    [_collectionView  reloadData];
}



















@end




























