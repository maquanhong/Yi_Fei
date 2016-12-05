//
//  FourTableViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.


#import "ThreeTableViewCell.h"
#import "PicsCell.h"

@interface ThreeTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@end

@implementation ThreeTableViewCell


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
[_collectionView registerClass:[PicsCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    [self.contentView addSubview: _collectionView];
    [_collectionView reloadData];

}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PicsCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    if (!photoCell) {
        photoCell = [[PicsCell alloc]init];
    }
    
    if ([[_imageArray objectAtIndex:indexPath.row] isKindOfClass:[ZZPhoto class]]) {
        //从数组里面把model取出来
        ZZPhoto *photo = [_imageArray objectAtIndex:indexPath.row];
        //用photo对象中的originImage属性来展示图片
        photoCell.photo.image = photo.originImage;
    }else if([[_imageArray objectAtIndex:indexPath.row] isKindOfClass:[ZZCamera class]]){
        ZZCamera *camera = [_imageArray objectAtIndex:indexPath.row];
        photoCell.photo.image = camera.image;
    }
    return photoCell;
}


























- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}











@end

















































