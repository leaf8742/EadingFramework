/**
 * @file
 * @author 单宝华
 * @date 2013-09-07
 * @copyright 大连一丁芯智能技术有限公司
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <InputValidator/InputValidator.h>

/**
 * @class CustomTextField
 * @brief 自定义文本框
 * @author 单宝华
 * @date 2013-09-07
 */
@interface CustomTextField : UITextField

/// @brief 默认背景
@property (retain, nonatomic) UIImage *normalEditingImage;

/// @brief 选择之后的背景
@property (retain, nonatomic) UIImage *selectedEditingImage;

/// @brief 输入错误的提示框
@property (retain, nonatomic) UIImage *invalidImage;

/// @brief 从哪里开始显示输入文字
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

/// @brief 长度限制
@property (assign, nonatomic) NSUInteger maxLength;

/// @brief 验证策略组件
@property (retain, nonatomic) IBOutlet InputValidator *inputValidator;

/// @brief 设置selected图片
- (void)didBeginEditing:(NSNotification *)notification;

/// @brief 设置normal图片
- (void)didEndEditing:(NSNotification *)notification;

/// @brief 键盘触发事件
- (void)animationKeyboard:(NSNotification *)notification;

/// @brief 键盘未收起，获得焦点
- (void)reciveFocus:(NSNotification *)notification;

/// @brief 验证策略
- (BOOL)validate;

/// @brief 验证策略，但不显示alertview
- (BOOL)validateWithError:(NSError **)error;

/// @brief 运行时验证策略
- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/// @brief 结束输入
- (void)didEndEditing;

@end
