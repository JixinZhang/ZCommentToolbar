//
//  UIImage+tintedImage.h
//  QBTitleView
//
//  Created by Katsuma Tanaka on 2013/01/17.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TintedImage)

/*!
 *	使用颜色生成图片
 *
 *	@param color	color description
 *
 *	@return return value description
 */
- (UIImage *)tintedImageUsingColor:(UIColor *)color;


/*!
 *	使用颜色生成图片
 *
 *	@param color			color description
 *	@param imageSize	imageSize description
 *
 *	@return return value description
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)imageSize;

@end
