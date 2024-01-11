//
//  UIColor+KGSColor.h
//  Typography
//
//  Created by KITE GAMES STUDIO on 1/24/17.
//  Copyright © 2017 KITE GAMES STUDIO LTD. All rights reserved.
//
//
//  Designed By: ANPrince
//
#import <UIKit/UIKit.h>

@interface UIColor (KGSColor)

//ANPrince: Get UIColor from hexa value string (EX: "D81B61").
+(UIColor *) colorWithHexaValue:(NSString *)strHexaCode withAlpha:(CGFloat) flAlpha;

//ANPrince: Get Random UIColor
+(UIColor *) randomColor;

//ANPrince: Get UIColor from the pixel of the image at origin (x,y)
+(UIColor*) colorWithImage:(UIImage*)image atOriginX:(int)x andOriginY:(int)y;

+(UIColor*) kgsBinaryInvertColorFromColor:(UIColor*)color;

+(BOOL) isEqualToColor:(UIColor*)colorToCompare;

@end
