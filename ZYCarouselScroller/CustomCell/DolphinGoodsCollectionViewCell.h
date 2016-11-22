//
//  DolphinGoodsCollectionViewCell.h
//  ZYCarouselScroller
//
//  Created by zhiyi on 16/11/22.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DolphinGoodsCollectionViewCell : UICollectionViewCell
+ (NSString *)getCellIdentifier;
- (void)updateCellWithDataDict:(NSDictionary *)dataDict;
@end
