//
//  DolphinGoodsCollectionViewCell.h
//  ZYCarouselScroller
//
//  Created by zhiyi on 16/11/22.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBIG_IMAGE_URL_STRING @"kBIG_IMAGE_URL_STRING"
#define kGOODS_IMAGE_URL_STRING_LIST @"kGOODS_IMAGE_URL_STRING_LIST"

@interface DolphinGoodsCollectionViewCell : UICollectionViewCell
+ (NSString *)getCellIdentifier;
- (void)updateCellWithDataDict:(NSDictionary *)dataDict;
@end
