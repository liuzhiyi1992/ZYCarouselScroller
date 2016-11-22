//
//  ViewController.m
//  ZYCarouselScroller
//
//  Created by zhiyi on 16/11/21.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "ViewController.h"
#import "ZYCarouselScroller.h"
#import "DemoCollectionViewCell.h"
#import "DolphinGoodsCollectionViewCell.h"

@interface ViewController ()
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupZYCarousrlScroller];
}

- (void)setupZYCarousrlScroller {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    ZYCarouselScroller *zyCarouselScroller =
    [[ZYCarouselScroller alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 260)
                      collectionViewCellClazz:@"DemoCollectionViewCell"
                               cellIdentifier:[DemoCollectionViewCell getCellIdentifier]
                                     cellSize:CGSizeMake(300, 200)
                                      cellGap:10
                      updateCarouselCellBlock:^(UICollectionViewCell *cell, NSDictionary *dataDict) {
                          [(DemoCollectionViewCell *)cell updateCellWithDataDict:dataDict];
                      }];
    zyCarouselScroller.dataList = @[@{kMAIN_IMAGE_NAME:@"scenic_0"},
                                    @{kMAIN_IMAGE_NAME:@"scenic_1"},
                                    @{kMAIN_IMAGE_NAME:@"scenic_2"},
                                    @{kMAIN_IMAGE_NAME:@"scenic_3"},
                                    @{kMAIN_IMAGE_NAME:@"scenic_4"}];
    zyCarouselScroller.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:zyCarouselScroller];
    
    
    
    ZYCarouselScroller *zyCarouselScrollerSecond =
    [[ZYCarouselScroller alloc] initWithFrame:CGRectMake(0, 260, screenWidth, 260)
                      collectionViewCellClazz:@"DolphinGoodsCollectionViewCell"
                               cellIdentifier:[DolphinGoodsCollectionViewCell getCellIdentifier]
                                     cellSize:CGSizeMake(300, 200)
                                      cellGap:10
                      updateCarouselCellBlock:^(UICollectionViewCell *cell, NSDictionary *dataDict) {
                          [(DolphinGoodsCollectionViewCell *)cell updateCellWithDataDict:dataDict];
                      }];
    zyCarouselScrollerSecond.dataList = [self generateDolphinDataList];
    zyCarouselScrollerSecond.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:zyCarouselScrollerSecond];
}

- (NSArray *)generateDolphinGoodsImageUrlList {
    return @[
             @"http://assets.haituncun.com/media/catalog/product/f/b/fbajphus60010003x.jpg?imageView2/0/w/232/h/232",
             @"http://assets.haituncun.com/media/catalog/product/f/b/fbajpcos10010038_1.jpg?imageView2/0/w/232/h/232",
             @"http://assets.haituncun.com/media/catalog/product/b/l/blmnzspl30020018x2.jpg?imageView2/0/w/232/h/232",
             @"http://assets.haituncun.com/media/catalog/product/r/e/red-seal-molasses-500g2_1.jpg?imageView2/0/w/232/h/232",
             @"http://assets.haituncun.com/media/catalog/product/s/w/swiauspl30020011x3.jpg?imageView2/0/w/232/h/232",
             @"http://assets.haituncun.com/media/catalog/product/f/b/fbagbspl30010016x2_1_1.jpg?imageView2/0/w/232/h/232",
             @"http://assets.haituncun.com/media/catalog/product/c/h/chiusspl30010002_1.jpg?imageView2/0/w/232/h/232",
             @"http://assets.haituncun.com/media/catalog/product/r/s/rslauspl30020002x3.jpg?imageView2/0/w/232/h/232",
             @"http://assets.haituncun.com/media/catalog/product/w/l/wldusbbya0030003.jpg?imageView2/0/w/232/h/232",
             @"http://assets.haituncun.com/media/catalog/product/f/b/fbakrcos10010003.jpg?imageView2/0/w/200/h/200",
             @"http://assets.haituncun.com/media/catalog/product/f/b/fbakrcos10010058x6_1.jpg?imageView2/0/w/200/h/200",
             @"http://assets.haituncun.com/media/catalog/product/f/b/fbakrcos10010062__1.jpg?imageView2/0/w/200/h/200",
             @"http://assets.haituncun.com/media/catalog/product/f/b/fbajpcos10010023.jpg?imageView2/0/w/200/h/200",
             @"http://assets.haituncun.com/media/catalog/product/f/b/fbagbcos10010005x2.jpg?imageView2/0/w/200/h/200",
             @"http://assets.haituncun.com/media/catalog/product/o/v/ovdauspl30010008x2.jpg?imageView2/0/w/200/h/200",
             @"http://assets.haituncun.com/media/catalog/product/f/b/fbadespl30020004x2.jpg?imageView2/0/w/200/h/200"
             ];
}

- (NSArray *)generateDolphinBigImageUrlList {
    return @[
             @"http://app-img.haituncun.com/uploads/images/recommend/bannner/6c3f5e0ca91367d9d35f2afc7db7f1ee.jpg",
             @"http://app-img.haituncun.com/uploads/images/recommend/bannner/2299e0ee63407d8d3d454c3e99acea61.jpg",
             @"http://app-img.haituncun.com/uploads/images/recommend/bannner/6566fb1cfe55d5f5f39d11097156efa7.jpg",
             @"http://app-img.haituncun.com/uploads/images/recommend/bannner/6855eb4cc29edc52c7f6961d21e1ca44.jpg",
             @"http://app-img.haituncun.com/uploads/images/recommend/bannner/9574777713406cae924043fd63452b3a.jpg"
             ];
}


/**
 Generate 3/Gruop GoodsImage random
 */
- (NSArray *)randomThreeGoodsImageUrlGruop {
    NSArray *goodsImageList = [self generateDolphinGoodsImageUrlList];
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        NSString *randomImageUrlString = [goodsImageList objectAtIndex:arc4random()%goodsImageList.count];
        [tmpArray addObject:randomImageUrlString];
    }
    return [tmpArray copy];
}

/**
 Generate haituncun.com style cell dataList
 a big image & three goodsImage a Gruop
 */
- (NSArray *)generateDolphinDataList {
    NSArray *bigImageList = [self generateDolphinBigImageUrlList];
    NSMutableArray *tmpDataList = [NSMutableArray array];
    for (NSString *bigImageUrlString in bigImageList) {
        NSDictionary *dataDict = @{kBIG_IMAGE_URL_STRING:bigImageUrlString,
                            kGOODS_IMAGE_URL_STRING_LIST:[self randomThreeGoodsImageUrlGruop]};
        [tmpDataList addObject:dataDict];
    }
    return [tmpDataList copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
