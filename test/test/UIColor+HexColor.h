//
//  UIColor+HexColor.h
//  test
//
//  Created by Mikhail Prysiazhniy on 10.04.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)colorFromHEX:(NSString *)hex;
+ (UIColor *)colorFromHEX:(NSString *)hex alpha:(CGFloat)alpha;

@end
