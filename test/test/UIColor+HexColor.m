//
//  UIColor+HexColor.m
//  test
//
//  Created by Mikhail Prysiazhniy on 10.04.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)colorFromHEX:(NSString *)hex{
    return [UIColor colorFromHEX:hex alpha:1.f];
}

+ (UIColor *)colorFromHEX:(NSString *)hex alpha:(CGFloat)alpha{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.f
                           green:((rgbValue & 0xFF00) >> 8) / 255.f
                            blue:(rgbValue & 0xFF) / 255.f
                           alpha:1.0];
}



@end
