//
//  DemoCollectionViewCell.h
//  ZYCarouselScroller
//
//  Created by zhiyi on 16/11/21.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMAIN_IMAGE_NAME @"kMAIN_IMAGE_NAME"

@interface DemoCollectionViewCell : UICollectionViewCell
+ (NSString *)getCellIdentifier;
- (void)updateCellWithDataDict:(NSDictionary *)dataDict;
@end
