//
//  ZYCarouselScroller.m
//  ZYCarouselScroller
//
//  Created by zhiyi on 16/11/21.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "ZYCarouselScroller.h"

#define LIMIT_CHANGE_SCALE 0.2
#define BACKGROUND_COLOR_DEFAULT [UIColor whiteColor]
NSUInteger const REPETITION_COEFFICIENT = 300;//创建副本数量

@interface ZYCarouselScroller () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (copy, nonatomic) NSString *collectionViewCellClazz;
@property (copy, nonatomic) NSString *collectionViewCellIdentifier;
@property (assign, nonatomic) CGSize collectionViewCellSize;
@property (assign, nonatomic) CGFloat collectionViewCellGap;
@property (assign, nonatomic) CGFloat lastScrollOffsetX;
@property (assign, nonatomic) CGFloat ratioCoefficient;//切换比例系数
@end

@implementation ZYCarouselScroller
- (instancetype)initWithFrame:(CGRect)frame
      collectionViewCellClazz:(NSString *)cellClazz
               cellIdentifier:(NSString *)cellIdentifier
                     cellSize:(CGSize)cellSize
                      cellGap:(CGFloat)cellGap
      updateCarouselCellBlock:(UpdateCarouselCellBlock)updateCarouselCellBlock {
    self = [super initWithFrame:frame];
    if (self) {
        _collectionViewCellClazz = cellClazz;
        _collectionViewCellIdentifier = cellIdentifier;
        _collectionViewCellSize = cellSize;
        _collectionViewCellGap = cellGap;
        _updateCarouselCellBlock = updateCarouselCellBlock;
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    [self addSubview:self.collectionView];
    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *views = @{@"collectionView":_collectionView};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
}

/**
 自动定位cell
 */
- (void)autoPositionCellWithScrollContentOffsetX:(CGFloat)contentOffsetX {
    NSUInteger currentIndexIndex = (NSUInteger)((contentOffsetX) / (_collectionViewCellSize.width + _collectionViewCellGap) + _ratioCoefficient);
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndexIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (BOOL)validIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 0 || indexPath.row >= _dataList.count*REPETITION_COEFFICIENT) {
        return NO;
    }
    return YES;
}

- (void)makeScaleWithIndexPath:(NSIndexPath *)indexPath {
    if (![self validIndexPath:indexPath]) {
        return;
    }
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        CGPoint convertCenter = [_collectionView convertPoint:cell.center toView:self];
        CGFloat divergencyDistance = _collectionViewCellSize.width + _collectionViewCellGap;
        CGFloat convertDistance = fabs(self.center.x - convertCenter.x);
        CGFloat progress = convertDistance/divergencyDistance;
        CGFloat scale = 1 - LIMIT_CHANGE_SCALE * progress;
        cell.transform = CGAffineTransformMakeScale(1, scale);
    }
}

#pragma mark - Delegate DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count * REPETITION_COEFFICIENT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row % _dataList.count;
    NSDictionary *dataDict = [_dataList objectAtIndex:index];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_collectionViewCellIdentifier forIndexPath:indexPath];
    if (_updateCarouselCellBlock) {
        _updateCarouselCellBlock(cell, dataDict);
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _collectionViewCellSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return _collectionViewCellGap;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //dir
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX > _lastScrollOffsetX) {//左滑
        self.ratioCoefficient = 0.9;
    } else {//右滑
        self.ratioCoefficient = 0.2;
    }
    self.lastScrollOffsetX = offsetX;
    //currentIndexFloat 前后两个做scale
    NSUInteger currentIndexFloat = (NSUInteger)((scrollView.contentOffset.x) / (_collectionViewCellSize.width + _collectionViewCellGap) + _ratioCoefficient);
    [self makeScaleWithIndexPath:[NSIndexPath indexPathForRow:currentIndexFloat-1 inSection:0]];
    [self makeScaleWithIndexPath:[NSIndexPath indexPathForRow:currentIndexFloat inSection:0]];
    [self makeScaleWithIndexPath:[NSIndexPath indexPathForRow:currentIndexFloat+1 inSection:0]];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (velocity.x == 0) {
        [self autoPositionCellWithScrollContentOffsetX:scrollView.contentOffset.x];
        return;
    }
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat unitLength = _collectionViewCellSize.width + _collectionViewCellGap;
    CGFloat leadingOffset = _collectionViewCellSize.width - (self.frame.size.width - _collectionViewCellSize.width - 2*_collectionViewCellGap)/2;
    NSUInteger index;
    if ((*targetContentOffset).x > currentOffsetX) {//左滑
        index = roundf(currentOffsetX/unitLength);
    } else if ((*targetContentOffset).x < currentOffsetX) {//右滑
        index = roundf(currentOffsetX/unitLength) - 2;
    }
    //下一个锚点所处的offset
    CGFloat targetOffsetX = index*unitLength + leadingOffset;
    *targetContentOffset = CGPointMake(targetOffsetX, scrollView.contentOffset.y);
}

#pragma mark - GET SET
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.itemSize = _collectionViewCellSize;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        CGFloat collectionViewCellLeadingTrailing = (self.frame.size.width - _collectionViewCellSize.width)/2;
        _collectionView.contentInset = UIEdgeInsetsMake(0, collectionViewCellLeadingTrailing, 0, collectionViewCellLeadingTrailing);
        [_collectionView registerClass:NSClassFromString(_collectionViewCellClazz) forCellWithReuseIdentifier:_collectionViewCellIdentifier];
        [_collectionView setBackgroundColor:BACKGROUND_COLOR_DEFAULT];
    }
    return _collectionView;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    [_collectionView setBackgroundColor:backgroundColor];
}

- (void)setDataList:(NSArray *)dataList {
    _dataList = [dataList copy];
    [_collectionView reloadData];
    [_collectionView layoutIfNeeded];
    //滑动到中央副本
    NSInteger operateIndexPathRow = round(REPETITION_COEFFICIENT/2) * _dataList.count;
    //旧逻辑
    //[_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:operateIndexPathRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async (dispatch_get_main_queue (),  ^{
        CGFloat unitLength = _collectionViewCellSize.width + weakSelf.collectionViewCellGap;
        CGFloat leadingOffset = weakSelf.collectionViewCellSize.width - (self.frame.size.width - weakSelf.collectionViewCellSize.width - 2*weakSelf.collectionViewCellGap)/2;
        //下一个锚点所处的offset
        CGFloat targetOffsetX = (operateIndexPathRow-1)*unitLength + leadingOffset;
        [weakSelf.collectionView setContentOffset:CGPointMake(targetOffsetX, 0)];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf makeScaleWithIndexPath:[NSIndexPath indexPathForRow:operateIndexPathRow-1 inSection:0]];
            [weakSelf makeScaleWithIndexPath:[NSIndexPath indexPathForRow:operateIndexPathRow inSection:0]];
            [weakSelf makeScaleWithIndexPath:[NSIndexPath indexPathForRow:operateIndexPathRow+1 inSection:0]];
        });
    });
}
@end
