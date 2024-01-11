//
//  UIColor+KGSColor.m
//  Typography
//
//  Created by KITE GAMES STUDIO on 1/24/17.
//  Copyright © 2017 KITE GAMES STUDIO LTD. All rights reserved.
//
//  Designed By: ANPrince
//
#import "UIColor+KGSColor.h"

#define UIColorFromRGB(rgbValue,rgbOpacity) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha: rgbOpacity]


@implementation UIColor (KGSColor)

+(UIColor *) colorWithHexaValue:(NSString *)strHexaCode withAlpha:(CGFloat) flAlpha{
    
    unsigned rgbValue = 0;
    
    NSScanner *scanner  = [NSScanner scannerWithString: strHexaCode];

    [scanner scanHexInt:&rgbValue];
    
    return UIColorFromRGB(rgbValue, flAlpha);
    
}

+(UIColor *) randomColor {
 
    return [UIColor colorWithRed: ((arc4random()%255)+1)/255.0 green: ((arc4random()%255)+1)/255.0 blue: ((arc4random()%255)+1)/255.0 alpha:1.0];
    
}

+(UIColor*) colorWithImage:(UIImage*)image atOriginX:(int)x andOriginY:(int)y {
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width * y) + x ) * 4; // 4 bytes per pixel
    
    UInt8 red   = data[pixelInfo + 0];
    UInt8 green = data[pixelInfo + 1];
    UInt8 blue  = data[pixelInfo + 2];
    UInt8 alpha = data[pixelInfo + 3];
    CFRelease(pixelData);
    
    return [UIColor colorWithRed:red  /255.0f
                           green:green/255.0f
                            blue:blue /255.0f
                           alpha:alpha/255.0f];
}


+(UIColor*) kgsBinaryInvertColorFromColor:(UIColor*)color {
    
    //Description can be found in the link below
    //https://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
    CGFloat r, g, b;
    [color getRed:&r green:&g blue:&b alpha:nil];
    r = r * 255;
    g = g * 255;
    b = b * 255;
    
    CGFloat intensity = (r * 0.299 + g * 0.587 + b * 0.114);
    if (intensity > 186) {
        return [UIColor blackColor];
    }
    
    return [UIColor whiteColor];
    
    //Alternate approach
//    CGFloat luminance = [[self class] getLuminanceFromColor:color];
//    NSLog(@"Luminance: %f", luminance);
//
//    if (luminance > 0.179) {
//        return [UIColor blackColor];
//    }
//
//    return [UIColor whiteColor];
}

+(CGFloat)getLuminanceFromColor:(UIColor*)color {
    CGFloat c[3];
    [color getRed:&c[0] green:&c[1] blue:&c[2] alpha:nil];
    
    for (int iIndex = 0; iIndex < 3; iIndex++) {
        
        if (c[iIndex] <= 0.03928) {
            c[iIndex] = c[iIndex] / 12.92;
        } else {
            c[iIndex] =  pow( (c[iIndex]+0.055) / 1.055, 2.4);
        }
    }
    CGFloat luminance = 0.2126 * c[0] + 0.7152 * c[1] + 0.0722 * c[2];
    return luminance;
}

@end
