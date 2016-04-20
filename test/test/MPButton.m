//
//  MPButton.m
//  test
//
//  Created by Mikhail Prysiazhniy on 10.04.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPButton.h"

@interface MPButton ()

@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) CAGradientLayer *gradientLayerHighlighted;
@property (weak, nonatomic) MPColorManager *colorManager;

@end

@implementation MPButton

- (instancetype)init{
    self = [super init];
    if (self){
        [self setup];
    }
    return self;
}

- (void)layoutSubviews{
    _gradientLayer.frame = self.layer.bounds;
    _gradientLayerHighlighted.frame = self.layer.bounds;
    [super layoutSubviews];
}


#pragma mark - accessors

- (MPColorManager *)colorManager{
    if (!_colorManager){
        _colorManager = [MPColorManager sharedColorManager];
    }
    return _colorManager;
}

- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.cornerRadius = 20.f;
        _gradientLayer.frame = self.layer.bounds;
        _gradientLayer.colors = @[ (id)self.colorManager.purple_d8c9de.CGColor, (id)self.colorManager.purple_d8c9de.CGColor ];
        _gradientLayer.locations = @[ @0, @1 ];
    }
    return _gradientLayer;
}

- (CAGradientLayer *)gradientLayerHighlighted{
    if (!_gradientLayerHighlighted) {
        
        _gradientLayerHighlighted = [CAGradientLayer layer];
        _gradientLayerHighlighted.cornerRadius = 20.f;
        _gradientLayerHighlighted.frame = self.layer.bounds;
        _gradientLayerHighlighted.colors = @[ (id)self.colorManager.purple_9584a0.CGColor, (id)self.colorManager.purple_9584a0.CGColor ];
        _gradientLayerHighlighted.locations = @[ @0, @1 ];
    }
    return _gradientLayerHighlighted;
}

#pragma mark - setup

- (void)setup{
    MPColorManager *colorManager = [MPColorManager sharedColorManager];
    [self.layer insertSublayer:self.gradientLayer atIndex:0];
//    self.backgroundColor = colorManager.gray_f7f7f7;
    self.layer.borderWidth = 1;
    self.layer.borderColor = colorManager.purple_250f2e.CGColor;
    self.layer.cornerRadius = 20;
    [self setTitleColor:colorManager.purple_250f2e forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}

- (void) setHighlighted:(BOOL)highlighted{
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.layer.sublayers[0] removeFromSuperlayer];
        if (highlighted) {
            [self.layer insertSublayer:self.gradientLayerHighlighted atIndex:0];
        } else {
            [self.layer insertSublayer:self.gradientLayer atIndex:0];
        }
    }];
}



@end
