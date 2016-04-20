//
//  MPColorManager.m
//  test
//
//  Created by Mikhail Prysiazhniy on 10.04.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPColorManager.h"

@implementation MPColorManager

+ (instancetype)sharedColorManager{
    static MPColorManager *colorManager = nil;
    static dispatch_once_t oneToken = 0;
    dispatch_once(&oneToken, ^{
        colorManager = [[MPColorManager alloc] initDefault];
    });
    return colorManager;
}

- (instancetype)initDefault{
    self = [super init];
    if (self) {
    }
    return self;
}


#pragma mark - new colors from Style Guide


- (UIColor *)greenButtonFillColor{
    static UIColor *color49aa34 = nil;
    if (!color49aa34) {
        color49aa34 = [UIColor colorFromHEX:@"#49aa34"];
    }
    return color49aa34;
}

- (UIColor *)greenButtonStroleColor{
    static UIColor *color3e9f29 = nil;
    if (!color3e9f29) {
        color3e9f29 = [UIColor colorFromHEX:@"#3e9f29"];
    }
    return color3e9f29;
}

- (UIColor *)redButtonFillColor{
    static UIColor *colore6030a = nil;
    if (!colore6030a) {
        colore6030a = [UIColor colorFromHEX:@"#e6030a"];
    }
    return colore6030a;
}

- (UIColor *)redButtonStroleColor{
    static UIColor *colorc80a10 = nil;
    if (!colorc80a10) {
        colorc80a10 = [UIColor colorFromHEX:@"#c80a10"];
    }
    return colorc80a10;
}

- (UIColor *)goldColor{
    static UIColor *colorecbf37 = nil;
    if (!colorecbf37) {
        colorecbf37 = [UIColor colorFromHEX:@"#ecbf37"];
    }
    return colorecbf37;
}

- (UIColor *)blueLightTextColor{
    static UIColor *color62bdfb = nil;
    if (!color62bdfb) {
        color62bdfb = [UIColor colorFromHEX:@"#62bdfb"];
    }
    return color62bdfb;
}

- (UIColor *)blueDarkTextColor{
    static UIColor *color067ccc = nil;
    if (!color067ccc) {
        color067ccc = [UIColor colorFromHEX:@"#067ccc"];
    }
    return color067ccc;
}

- (UIColor *)darkGradienColor{
    static UIColor *color067ccc = nil;
    if (!color067ccc) {
        color067ccc = [UIColor colorFromHEX:@"#310507"];
    }
    return color067ccc;
    
}

- (UIColor *)purple_250f2e{
    static UIColor *color250f2e = nil;
    if (!color250f2e) {
        color250f2e = [UIColor colorFromHEX:@"#250f2e"];
    }
    return color250f2e;
}

- (UIColor *)purple_3e1d4f{
    static UIColor *color3e1d4f = nil;
    if (!color3e1d4f) {
        color3e1d4f = [UIColor colorFromHEX:@"#3e1d4f"];
    }
    return color3e1d4f;
}

- (UIColor *)purple_67327f{
    static UIColor *color67327f = nil;
    if (!color67327f) {
        color67327f = [UIColor colorFromHEX:@"#67327f"];
    }
    return color67327f;
}

- (UIColor *)purple_9f6cb5{
    static UIColor *color9f6cb5 = nil;
    if (!color9f6cb5) {
        color9f6cb5 = [UIColor colorFromHEX:@"#9f6cb5"];
    }
    return color9f6cb5;
}

- (UIColor *)purple_9584a0{
    static UIColor *color9584a0 = nil;
    if (!color9584a0) {
        color9584a0 = [UIColor colorFromHEX:@"#9584a0"];
    }
    return color9584a0;
}
- (UIColor *)purple_d8c9de{
    static UIColor *colord8c9de = nil;
    if (!colord8c9de) {
        colord8c9de = [UIColor colorFromHEX:@"#d8c9de"];
    }
    return colord8c9de;
}

- (UIColor *)gray_858585{
    static UIColor *color858585 = nil;
    if (!color858585) {
        color858585 = [UIColor colorFromHEX:@"#858585"];
    }
    return color858585;
}

- (UIColor *)gray_afafaf{
    static UIColor *colorafafaf = nil;
    if (!colorafafaf) {
        colorafafaf = [UIColor colorFromHEX:@"#afafaf"];
    }
    return colorafafaf;
}

- (UIColor *)gray_c8c7cc{
    static UIColor *colorc8c7cc = nil;
    if (!colorc8c7cc) {
        colorc8c7cc = [UIColor colorFromHEX:@"#c8c7cc"];
    }
    return colorc8c7cc;
}

- (UIColor *)gray_e5e5e5{
    static UIColor *colore5e5e5 = nil;
    if (!colore5e5e5) {
        colore5e5e5 = [UIColor colorFromHEX:@"#e5e5e5"];
    }
    return colore5e5e5;
}

- (UIColor *)gray_f7f7f7{
    static UIColor *colorf7f7f7 = nil;
    if (!colorf7f7f7) {
        colorf7f7f7 = [UIColor colorFromHEX:@"#f7f7f7"];
    }
    return colorf7f7f7;
}

- (UIColor *)gray_f7f8fc{
    static UIColor *colorf7f8fc = nil;
    if (!colorf7f8fc) {
        colorf7f8fc = [UIColor colorFromHEX:@"#f7f8fc"];
    }
    return colorf7f8fc;
}

- (UIColor *)grayLight_f2f2fa{
    static UIColor *colorf2f2fa = nil;
    if (!colorf2f2fa) {
        colorf2f2fa = [UIColor colorFromHEX:@"#f2f2fa"];
    }
    return colorf2f2fa;
}

- (UIColor *)grayLight_f7f8fc{
    static UIColor *colorf7f8fc = nil;
    if (!colorf7f8fc) {
        colorf7f8fc = [UIColor colorFromHEX:@"#f7f8fc"];
    }
    return colorf7f8fc;
}



#pragma mark - colors


- (UIColor *)raiseColor{
    static UIColor *raiseColor = nil;
    if (!raiseColor) {
        raiseColor = [UIColor colorWithRed:61.f/255.f green:155.f/255.f blue:37.f/255.f alpha:1.f];
    }
    return raiseColor;
}

- (UIColor *)failingColor{
    static UIColor *failingColor = nil;
    if (!failingColor) {
        failingColor = [UIColor colorWithRed:237.f/255.f green:0/255.f blue:19.f/255.f alpha:1.f];
    }
    return failingColor;
}

- (UIColor *)grayColor{
    static UIColor *grayColor = nil;
    if (!grayColor) {
        grayColor = [UIColor colorFromHEX:@"#c7c8ca"];
    }
    return grayColor;
}

- (UIColor *)lineSeparator{
    static UIColor *lineSeparator = nil;
    if (!lineSeparator) {
        lineSeparator = [UIColor colorWithRed:0.769f green:0.765f blue:0.788f alpha:1.f];
    }
    return lineSeparator;
}

- (UIColor *)nonActiveColor{
    static UIColor *nonActiveColor = nil;
    if (!nonActiveColor) {
        nonActiveColor = [UIColor colorWithWhite:0.784f alpha:1.f];
    }
    return nonActiveColor;
}

- (UIColor *)blueTextColor{
    static UIColor *textColor = nil;
    if (!textColor) {
        textColor = [UIColor colorFromHEX:@"#61AEE0"];
    }
    return textColor;
}

- (UIColor *)darkTextColor{
    static UIColor *darkTextColor = nil;
    if (!darkTextColor) {
        darkTextColor = [UIColor blackColor];
    }
    return darkTextColor;
}

- (UIColor *)purpleColor{
    static UIColor *purpleColor = nil;
    if (!purpleColor) {
        purpleColor = [UIColor colorWithRed:146.f/255.f green:110.f/255.f blue:161.f/255.f alpha:1.f];
    }
    return purpleColor;
}

- (UIColor *)textFieldTextColor{
    static UIColor *textFieldTextColor = nil;
    if (!textFieldTextColor) {
        textFieldTextColor = [UIColor colorFromHEX:@"#61AEE0"];
    }
    return textFieldTextColor;
}

- (UIColor *)globalTintColor{
    static UIColor *globalTintColor = nil;
    if (!globalTintColor) {
        globalTintColor = [UIColor colorWithRed:38.f/255.f green:14.f/255.f blue:46.f/255.f alpha:1.f];
    }
    return globalTintColor;
}


- (UIColor *)disabledColor{
    return self.gray_afafaf;
    //    static UIColor *disabledColor = nil;
    //    if (!disabledColor) {
    //        disabledColor = [UIColor colorWithWhite:0.416f alpha:0.6f];
    //    }
    //    return disabledColor;
}

- (UIColor *)switchOnColor{
    static UIColor *switchOnColor = nil;
    if (!switchOnColor) {
        switchOnColor = [UIColor colorFromHEX:@"#260E2E"];
    }
    return switchOnColor;
}


- (UIColor *)colorForPlotLineStartGradient{
    static UIColor *colorForPlotLineStartGradient = nil;
    if (!colorForPlotLineStartGradient) {
        colorForPlotLineStartGradient = [UIColor colorWithRed:39.f/255.f green:15.f/255.f blue:49.f/255.f alpha:1.f];
    }
    return colorForPlotLineStartGradient;
}

- (UIColor *)colorForPlotLineEndGradient{
    static UIColor *colorForPlotLineEndGradient = nil;
    if (!colorForPlotLineEndGradient) {
        colorForPlotLineEndGradient = [UIColor colorWithRed:146.f/255.f green:110.f/255.f blue:161.f/255.f alpha:1.f];
    }
    return colorForPlotLineEndGradient;
}

- (UIColor *)increaseColor{
    static UIColor *increaseColor = nil;
    if (!increaseColor) {
        increaseColor = [UIColor colorWithRed:98.f/255.f green:196.f/255.f blue:77.f/255.f alpha:1.f];
    }
    return increaseColor;
}

- (UIColor *)decreaseColor{
    static UIColor *decreaseColor = nil;
    if (!decreaseColor) {
        decreaseColor = [UIColor colorWithRed:230.f/255.f green:21.f/255.f blue:5.f/255.f alpha:1.f];
    }
    return decreaseColor;
}


- (UIColor *)dashLineColor{
    static UIColor *dashLineColor = nil;
    if (!dashLineColor) {
        dashLineColor = [UIColor lightGrayColor];
    }
    return dashLineColor;
}

- (UIColor *)darkColor{
    static UIColor *darkColor = nil;
    if (!darkColor) {
        darkColor = [UIColor colorWithRed:39.f/255.f green:13.f/255.f blue:45.f/255.f alpha:1.f];
    }
    return darkColor;
}

- (UIColor *)winColor{
    static UIColor *winColor = nil;
    if (!winColor) {
        winColor = [UIColor colorWithRed:88.f/255.f green:46.f/255.f blue:99.f/255.f alpha:1.000];
    }
    return winColor;
}


- (UIColor *)textColorNormal{
    static UIColor *textColorNormal = nil;
    if (!textColorNormal) {
        textColorNormal = [UIColor blackColor];
    }
    return textColorNormal;
}

- (UIColor *)textColorSelected{
    static UIColor *textColorSelected = nil;
    if (!textColorSelected) {
        textColorSelected = [UIColor whiteColor];
    }
    return textColorSelected;
}

- (UIColor *)normalColor{
    static UIColor *normalColor = nil;
    if (!normalColor) {
        normalColor = [UIColor colorFromHEX:@"#e0e1e4"];
    }
    return normalColor;
}

- (UIColor *)selectedColor{
    static UIColor *selectedColor = nil;
    if (!selectedColor) {
        selectedColor = [UIColor colorFromHEX:@"#4f4753"];
    }
    return selectedColor;
}

- (UIColor *)backgroundColorPurpleEnd{
    static UIColor *backgroundColorPurpleEnd = nil;
    if (!backgroundColorPurpleEnd) {
        backgroundColorPurpleEnd = [UIColor colorWithRed:65.f/255.f green:22.f/255.f blue:72.f/255.f alpha:1.f];
    }
    return backgroundColorPurpleEnd;
}

- (UIColor *)backgroundColorPurpleStart{
    static UIColor *backgroundColorPurpleStart = nil;
    if (!backgroundColorPurpleStart) {
        backgroundColorPurpleStart = [UIColor colorWithRed:135.f/255.f green:97.f/255.f blue:154.f/255.f alpha:1.f];
    }
    return backgroundColorPurpleStart;
}

@end
