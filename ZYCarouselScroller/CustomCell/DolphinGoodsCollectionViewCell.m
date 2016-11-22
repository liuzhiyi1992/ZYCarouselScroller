//
//  DolphinGoodsCollectionViewCell.m
//  ZYCarouselScroller
//
//  Created by zhiyi on 16/11/22.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "DolphinGoodsCollectionViewCell.h"

@interface DolphinGoodsCollectionViewCell ()

@end

@implementation DolphinGoodsCollectionViewCell
+ (NSString *)getCellIdentifier {
    return @"DolphinGoodsCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)updateCellWithDataDict:(NSDictionary *)dataDict {
    
}

- (void)setupCell {
    
}
@end


//商品图片url:
//http://assets.haituncun.com/media/catalog/product/f/b/fbajphus60010003x.jpg?imageView2/0/w/232/h/232
//URL	http://assets.haituncun.com/media/catalog/product/f/b/fbajpcos10010038_1.jpg?imageView2/0/w/232/h/232
//URL	http://assets.haituncun.com/media/catalog/product/b/l/blmnzspl30020018x2.jpg?imageView2/0/w/232/h/232
//URL	http://assets.haituncun.com/media/catalog/product/r/e/red-seal-molasses-500g2_1.jpg?imageView2/0/w/232/h/232
//URL	http://assets.haituncun.com/media/catalog/product/s/w/swiauspl30020011x3.jpg?imageView2/0/w/232/h/232
//URL	http://assets.haituncun.com/media/catalog/product/f/b/fbagbspl30010016x2_1_1.jpg?imageView2/0/w/232/h/232
//URL	http://assets.haituncun.com/media/catalog/product/c/h/chiusspl30010002_1.jpg?imageView2/0/w/232/h/232
//URL	http://assets.haituncun.com/media/catalog/product/r/s/rslauspl30020002x3.jpg?imageView2/0/w/232/h/232
//URL	http://assets.haituncun.com/media/catalog/product/w/l/wldusbbya0030003.jpg?imageView2/0/w/232/h/232
//URL	http://assets.haituncun.com/media/catalog/product/f/b/fbakrcos10010003.jpg?imageView2/0/w/200/h/200
//URL	http://assets.haituncun.com/media/catalog/product/f/b/fbakrcos10010058x6_1.jpg?imageView2/0/w/200/h/200
//URL	http://assets.haituncun.com/media/catalog/product/f/b/fbakrcos10010062__1.jpg?imageView2/0/w/200/h/200
//URL	http://assets.haituncun.com/media/catalog/product/f/b/fbajpcos10010023.jpg?imageView2/0/w/200/h/200
//URL	http://assets.haituncun.com/media/catalog/product/f/b/fbagbcos10010005x2.jpg?imageView2/0/w/200/h/200
//URL	http://assets.haituncun.com/media/catalog/product/o/v/ovdauspl30010008x2.jpg?imageView2/0/w/200/h/200
//URL	http://assets.haituncun.com/media/catalog/product/f/b/fbadespl30020004x2.jpg?imageView2/0/w/200/h/200



//国家馆图片url:
//URL	http://app-img.haituncun.com/uploads/images/recommend/bannner/6c3f5e0ca91367d9d35f2afc7db7f1ee.jpg
//URL	http://app-img.haituncun.com/uploads/images/recommend/bannner/2299e0ee63407d8d3d454c3e99acea61.jpg
//URL	http://app-img.haituncun.com/uploads/images/recommend/bannner/6566fb1cfe55d5f5f39d11097156efa7.jpg
//URL	http://app-img.haituncun.com/uploads/images/recommend/bannner/6855eb4cc29edc52c7f6961d21e1ca44.jpg
//URL	http://app-img.haituncun.com/uploads/images/recommend/bannner/9574777713406cae924043fd63452b3a.jpg
//
