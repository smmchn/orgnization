//
//  FXAnimationField.m
//  模仿安卓studio登录动画
//
//  Created by 可米小子 on 17/1/16.
//  Copyright © 2017年 可米小子. All rights reserved.
//

#import "FXAnimationField.h"

#define KLabelX 5
#define KLabelH 20
#define angle2radian(angle) ((angle) / 180.0 * M_PI)

@interface FXAnimationField ()

@property (assign,nonatomic) BOOL isNull;

@property (assign,nonatomic) CGFloat labelHeight;

@property (assign,nonatomic) CGFloat textFiledHeight;

@property (strong,nonatomic) UILabel *placeLabel;

@property (strong, nonatomic)UILabel *bottoomLabel;


@end

@implementation FXAnimationField


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.isNull = YES;//默认为空
        //默认动画
        self.placeLabel = [[UILabel alloc] init];
        self.animationType = FXAnimationTypeUp;
        self.placeLabel.font = [UIFont systemFontOfSize:15];
        
        //添加占位符
        self.placeholderColor = [UIColor kkBlue];
        [self addSubview:self.placeLabel];
        
        //添加输入框
        self.textFiled = [[PUPadingTextField alloc] init];
        self.textFiled.clearButtonMode  = UITextFieldViewModeWhileEditing;
        self.textFiled.backgroundColor = [UIColor clearColor];
        [self.textFiled addTarget:self
                           action:@selector(valueChange:)
                 forControlEvents:UIControlEventEditingDidBegin];
        [self.textFiled addTarget:self
                           action:@selector(valueEnd:)
                 forControlEvents:UIControlEventEditingDidEnd];
        [self addSubview:self.textFiled];
        
        //添加底部线
        self.bottoomLabel = [[UILabel alloc]init];
        self.bottoomLabel.backgroundColor = [UIColor kkSeparateLineColor];
        [self addSubview:self.bottoomLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textFiledHeight = self.frame.size.height - self.labelHeight;
    CGRect rectPlacer = CGRectMake(KLabelX ,self.labelHeight ,self.frame.size.width ,self.textFiledHeight);
    self.placeLabel.frame = rectPlacer;
    CGRect rect_tf = CGRectMake(0 ,self.labelHeight ,self.frame.size.width ,self.textFiledHeight );
    self.textFiled.frame = rect_tf;
    self.bottoomLabel.frame =CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
}
#pragma mark -监测textField的输入
- (void)valueChange:(UITextField*)textField
{
    [self animationStart];
    //取出当前输入的文字
    _textInput = textField.text;
}

- (void)animationStart
{
    switch (self.animationType)
    {
        case FXAnimationTypeBound: [self animationBound]; break;
        case FXAnimationTypeShake: [self animationShake]; break;
        case FXAnimationTypeUp:    [self animationUp];    break;
    }
}

#pragma mark -监听textField的结束

- (void)valueEnd:(UITextField *)textField {
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX;
    if (textField.text.length == 0) {
        self.isNull = YES;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.placeLabel.frame = labelRect;
            self.placeLabel.font = [UIFont systemFontOfSize:15];
        } completion:nil];
    }
    
}
#pragma mark - 占位符颜色
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    _placeLabel.textColor = _placeholderColor;
}

#pragma mark - 对齐方式
-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    _placeLabel.textAlignment = _textAlignment;
    _textFiled.textAlignment = _textAlignment;
}
#pragma mark - 占位符
-(void)setPlaceStr:(NSString *)placeStr
{
    _placeStr = placeStr;
    _placeLabel.text = _placeStr;
}
#pragma mark - 字体
-(void)setPlacerholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    _placeLabel.font = _placeholderFont;
    _textFiled.font = _placeholderFont;
}
#pragma mark - 输入框文字颜色
-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _textFiled.textColor = _textColor;
}
#pragma mark - 动画效果
-(void)setAnimationType:(FXAnimationType)animationType
{
    _animationType = animationType;
}

#pragma mark -向上的动画
-(void)animationUp
{
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX;
    if (self.isNull)
    {
        self.isNull = NO;
        labelRect.origin.y = self.textFiled.frame.origin.y - self.textFiled.frame.size.height;
        //开始描写动画效果
        [UIView animateWithDuration:0.3  animations:^{
            self.placeLabel.frame = labelRect;
            self.placeLabel.font = [UIFont systemFontOfSize:11];
            //self.placeLabel.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
    }
}
#pragma mark -抖动的动画
-(void)animationShake
{
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX;
    if (self.isNull)
    {
        self.isNull = NO;
        labelRect.origin.y = self.textFiled.frame.origin.y - self.textFiled.frame.size.height;
        //开始描写动画效果
        [UIView animateWithDuration:0.3  animations:^{
            self.placeLabel.frame = labelRect;
            CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
            rotation.keyPath = @"transform.rotation";
            rotation.values = @[@(angle2radian(-5)),@(angle2radian(5)),@(angle2radian(-5))];
            
            [self.placeLabel.layer addAnimation:rotation forKey:nil];
        }];
    }
}

#pragma mark -弹簧的动画
-(void)animationBound
{
    CGRect labelRect = self.textFiled.frame ;
    labelRect.origin.x = KLabelX;
    if (self.isNull)
    {
        self.isNull = NO;
        labelRect.origin.y = self.textFiled.frame.origin.y - self.textFiled.frame.size.height;
        //开始描写动画效果
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.placeLabel.frame = labelRect;
        } completion:nil];
    }
}

- (void)setTextField_text:(NSString *)textField_text
{
    self.textFiled.text = textField_text;
    [self valueEnd:self.textFiled];
}


@end
