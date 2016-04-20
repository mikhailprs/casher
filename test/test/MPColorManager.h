//
//  MPColorManager.h
//  test
//
//  Created by Mikhail Prysiazhniy on 10.04.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+HexColor.h"

@interface MPColorManager : NSObject


/*
 *  Unavailable
 */

- (instancetype)init __attribute__((unavailable("use shared manager")));
- (instancetype)copy UNAVAILABLE_ATTRIBUTE;

/**
 *  singleton class for handling colors
 *
 *  @return self
 */
+ (instancetype)sharedColorManager;


/**
 *  49aa34
 *  http://screencast.com/t/Jc4Bbq9fC2t
 */
- (UIColor *)greenButtonFillColor;
/**
 *  3e9f29
 */
- (UIColor *)greenButtonStroleColor;
/**
 *  e6030a
 *  http://screencast.com/t/Jc4Bbq9fC2t
 */
- (UIColor *)redButtonFillColor;
/**
 *  c80a10
 *  http://screencast.com/t/Jc4Bbq9fC2t
 */
- (UIColor *)redButtonStroleColor;
/**
 *  ecbf37
 *  http://screencast.com/t/Jc4Bbq9fC2t
 */
- (UIColor *)goldColor;

/**
 *  62bdfb
 *  http://screencast.com/t/Jc4Bbq9fC2t
 */
- (UIColor *)blueLightTextColor;
/**
 *  067ccc
 *  http://screencast.com/t/Jc4Bbq9fC2t
 */
- (UIColor *)blueDarkTextColor;
- (UIColor *)darkGradienColor;

- (UIColor *)purple_250f2e;
- (UIColor *)purple_3e1d4f;
- (UIColor *)purple_67327f;
- (UIColor *)purple_9f6cb5;
- (UIColor *)purple_9584a0;
- (UIColor *)purple_d8c9de;

- (UIColor *)gray_858585;
- (UIColor *)gray_afafaf;
- (UIColor *)gray_c8c7cc;
- (UIColor *)gray_e5e5e5;
- (UIColor *)gray_f7f7f7;
- (UIColor *)gray_f7f8fc;
- (UIColor *)grayLight_f2f2fa;
- (UIColor *)grayLight_f7f8fc;


- (UIColor *)raiseColor;
- (UIColor *)failingColor;
- (UIColor *)grayColor;
- (UIColor *)lineSeparator;
- (UIColor *)nonActiveColor;
- (UIColor *)purpleColor;
- (UIColor *)textFieldTextColor;
- (UIColor *)blueTextColor;
- (UIColor *)darkTextColor;
- (UIColor *)globalTintColor;
- (UIColor *)disabledColor;
- (UIColor *)switchOnColor;
- (UIColor *)colorForPlotLineStartGradient;
- (UIColor *)colorForPlotLineEndGradient;
- (UIColor *)increaseColor;
- (UIColor *)decreaseColor;
- (UIColor *)dashLineColor;
- (UIColor *)darkColor;
- (UIColor *)winColor;
- (UIColor *)textColorNormal;
- (UIColor *)textColorSelected;
- (UIColor *)normalColor;
- (UIColor *)selectedColor;
- (UIColor *)backgroundColorPurpleEnd;
- (UIColor *)backgroundColorPurpleStart;

@end
