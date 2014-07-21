//
//  DKCircleButton.h
//  DKCircleButton
//
//  Created by Dmitry Klimkin on 23/4/14.
//  Copyright (c) 2014 Dmitry Klimkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKCircleButton : UIButton

@property (nonatomic, strong) UIColor * circleBorderColor;
@property (nonatomic) BOOL animateTap;
@property (nonatomic) BOOL displayShading;
@property (nonatomic) CGFloat borderSize;

- (void)blink;
- (void)initWithXib;
- (void)setImage:(UIImage *)image animated: (BOOL)animated;
- (void)setCircleBorderColor:(UIColor *)borderColor;
@end
