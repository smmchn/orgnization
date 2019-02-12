//
//  PUPadingTextField.h
//  PublicModule
//
//  Created by mzeng on 2017/8/1.
//  Copyright © 2017年 mzeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PUPadingTextField : UITextField

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat leftViewMargin;
@property (nonatomic, strong) UIColor *placeholderColor;
@end
