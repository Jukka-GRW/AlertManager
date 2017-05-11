//
//  UIViewController+AlertManager.h
//  MainProject
//
//  Created by 甘瑞文 on 2017/5/10.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    ICON_TITLE_SUCCESS_TYPE = 0,        //成功类型的icon
    
    ICON_TITLE_FAIL_TYPE = 1,           //失败类型的icon
    
    ICON_TITLE_WARNING_TYPE = 2,        //警告类型的icon
    
} IconTitleType;

typedef void(^cancelClick)(void);
typedef void(^sureClick)(void);

typedef void(^SystemCancelClick)(UIAlertController *alertViewController);
typedef void(^SystemSureClick)(UIAlertController *alertViewController);
typedef void(^ConfigurationHandler)(UITextField *textField);

@interface UIViewController (AlertManager)

/**
 *  系统的提示框两个按钮的alert
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelButton 取消按钮名称
 *  @param sureButton   确认按钮名称
 *  @param sureClick    确认block
 *  @param cancelClick  取消block
 */
- (void)systemDoubleButtonAlertShowWithTitle:(NSString *)title
                                     message:(NSString *)message
                          titleTextAlignment:(NSTextAlignment)titleTextAlignment
                        messageTextAlignment:(NSTextAlignment)messageTextAlignment
                               haveTextField:(BOOL)haveTextField
                                cancelButton:(NSString *)cancelButton
                                  sureButton:(NSString *)sureButton
                        configurationHandler:(ConfigurationHandler)configurationHandler
                                   sureClick:(SystemSureClick)sureClick
                                 cancelClick:(SystemCancelClick)cancelClick;

/**
 *  系统的提示框可以改变两个按钮的字体颜色
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelButton 取消按钮名称
 *  @param sureButton   确认按钮名称
 *  @param cancelColor  取消按钮字体颜色
 *  @param sureColor    确认按钮字体颜色
 *  @param sureClick    确认block
 *  @param cancelClick  取消block
 */
- (void)systemDoubleButtonAlertShowWithTitle:(NSString *)title
                                     message:(NSString *)message
                          titleTextAlignment:(NSTextAlignment)titleTextAlignment
                        messageTextAlignment:(NSTextAlignment)messageTextAlignment
                               haveTextField:(BOOL)haveTextField
                                cancelButton:(NSString *)cancelButton
                                  sureButton:(NSString *)sureButton
                                 cancelColor:(UIColor *)cancelColor
                                   sureColor:(UIColor *)sureColor
                        configurationHandler:(ConfigurationHandler)configurationHandler
                                   sureClick:(SystemSureClick)sureClick
                                 cancelClick:(SystemCancelClick)cancelClick;

/**
 *  系统的提示框一个按钮的alert
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param cancelButton 取消按钮名称
 *  @param sureButton   确认按钮名称
 *  @param sureClick    确认block
 *  @param cancelClick  取消block
 */

- (void)systemSingleButtonAlertShowWithTitle:(NSString *)title
                                     message:(NSString *)message
                          titleTextAlignment:(NSTextAlignment)titleTextAlignment
                        messageTextAlignment:(NSTextAlignment)messageTextAlignment
                               haveTextField:(BOOL)haveTextField
                               defaultButton:(NSString *)defaultButton
                        configurationHandler:(ConfigurationHandler)configurationHandler
                                   sureClick:(SystemSureClick)sureClick;

- (void)systemSingleButtonAlertShowWithTitle:(NSString *)title
                            attributeMessage:(NSMutableAttributedString *)attributeMessage
                          titleTextAlignment:(NSTextAlignment)titleTextAlignment
                        messageTextAlignment:(NSTextAlignment)messageTextAlignment
                               haveTextField:(BOOL)haveTextField
                               defaultButton:(NSString *)defaultButton
                        configurationHandler:(ConfigurationHandler)configurationHandler
                                   sureClick:(SystemSureClick)sureClick;

/**
 *  title是图标的两个按钮的alert
 *
 *  @param iconType                  标题图标类型
 *  @param message                   提示内容
 *  @param messageTextAlignment      提示内容对齐方式
 *  @param cancelButton              取消按钮名称
 *  @param sureButton                确认按钮名称
 *  @param sureClick                 确认block
 *  @param cancelClick               取消block
 */

- (void)iConDoubleButtonAlertShowWithIconType:(IconTitleType)iconType
                                      message:(NSString *)message
                         messageTextAlignment:(NSTextAlignment)messageTextAlignment
                                 cancelButton:(NSString *)cancelButton
                                   sureButton:(NSString *)sureButton
                                    sureClick:(SystemSureClick)sureClick
                                  cancelClick:(SystemCancelClick)cancelClick;

/**
 *  title是图标的一个按钮的alert
 *
 *  @param iconType                  标题图标类型
 *  @param message                   提示内容
 *  @param messageTextAlignment      提示内容对齐方式
 *  @param defaultButton                确认按钮名称
 *  @param sureClick                 确认block
 */
- (void)iConSingleButtonAlertShowWithIconType:(IconTitleType)iconType
                                      message:(NSString *)message
                         messageTextAlignment:(NSTextAlignment)messageTextAlignment
                                defaultButton:(NSString *)defaultButton
                                    sureClick:(SystemSureClick)sureClick;

@end
