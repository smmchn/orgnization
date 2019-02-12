//
//  PUPadingTextField.m
//  PublicModule
//
//  Created by mzeng on 2017/8/1.
//  Copyright © 2017年 mzeng. All rights reserved.
//

#import "PUPadingTextField.h"

@implementation PUPadingTextField

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsZero;
        self.leftViewMargin = 0;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.edgeInsets = UIEdgeInsetsZero;
        self.leftViewMargin = 0;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(self.leftViewMargin, (bounds.size.height - 20) /2,100, 20);
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if (placeholderColor) {
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16]; // 设置font
        attrs[NSForegroundColorAttributeName] = placeholderColor; // 设置颜色
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs]; // 初始化富文本占位字符串
        self.attributedPlaceholder = attStr;
    }
}
@end
