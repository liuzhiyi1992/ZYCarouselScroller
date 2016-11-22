//
//  DemoCollectionViewCell.m
//  ZYCarouselScroller
//
//  Created by zhiyi on 16/11/21.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "DemoCollectionViewCell.h"

@interface DemoCollectionViewCell ()
@property (strong, nonatomic) UIImageView *mainImageView;
@end

@implementation DemoCollectionViewCell
+ (NSString *)getCellIdentifier {
    return @"DemoCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    self.mainImageView = [[UIImageView alloc] init];
    _mainImageView.layer.cornerRadius = 3.f;
    _mainImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_mainImageView];
    [_mainImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *views = @{@"mainImageView":_mainImageView};
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mainImageView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainImageView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
}

- (void)updateCellWithDataDict:(NSDictionary *)dataDict {
    NSString *mainImageName = [dataDict objectForKey:kMAIN_IMAGE_NAME];
    [_mainImageView setImage:[UIImage imageNamed:mainImageName]];
}
@end
