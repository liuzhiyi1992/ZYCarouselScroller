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
//    zyCarouselScrollerSecond.dataList = @[];
    [self.view addSubview:zyCarouselScrollerSecond];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
