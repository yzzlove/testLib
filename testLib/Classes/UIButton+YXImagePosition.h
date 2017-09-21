//
//  UIButton+YXImagePosition.h
//  YzzBaseLib
//
//  Created by yaozhengzheng on 2017/9/19.
//  Copyright © 2017年 yaozhengzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    /// 图片在左，文字在右
    YXImagePositionStyleDefault,
    /// 图片在右，文字在左
    YXImagePositionStyleRight,
    /// 图片在上，文字在下
    YXImagePositionStyleTop,
    /// 图片在下，文字在上
    YXImagePositionStyleBottom,
} YXImagePositionStyle;

@interface UIButton (YXImagePosition)
/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 */
- (void)YX_imagePositionStyle:(YXImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;
@end
