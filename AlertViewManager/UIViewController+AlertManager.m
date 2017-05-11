//
//  UIViewController+AlertManager.m
//  MainProject
//
//  Created by 甘瑞文 on 2017/5/10.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "UIViewController+AlertManager.h"

#define RGB_COLOR(_A,_B,_C,_ALPHA) [UIColor colorWithRed:_A/255.0 green:_B/255.0 blue:_C/255.0 alpha:_ALPHA]

#define TITLE_COLOR RGB_COLOR(34, 34, 34, 1)
#define MESSAGE_COLOR RGB_COLOR(34, 34, 34, 1)
#define TITLE_FONT [UIFont boldSystemFontOfSize:18]
#define MESSAGE_FONT [UIFont systemFontOfSize:15]
#define BUTTON_FONT [UIFont systemFontOfSize:15]
#define ALERT_CORNERRADIUS 4

#define ACTION_SURE_COLOR RGB_COLOR(0, 173, 230, 1)
#define ACTION_CANCEL_COLOR RGB_COLOR(34, 34, 34, 1)
#define ALERT_TITLE_COLOR RGB_COLOR(34, 34, 34, 1)
#define ALERT_MESSAGE_COLOR RGB_COLOR(34, 34, 34, 1)

@implementation UIViewController (AlertManager)

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
                                 cancelClick:(SystemCancelClick)cancelClick
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    alertVC.view.backgroundColor = [UIColor whiteColor];
    alertVC.view.layer.cornerRadius = ALERT_CORNERRADIUS;
    
    /* 1.title */
    if (title) {
        
        @try
        {
            //下面是取title和message的父视图的代码：
            UIView *subView1 = alertVC.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            //获取message：
            UILabel *titleLabel = subView5.subviews[0];
            //然后设置message内容居左：
            titleLabel.textAlignment = titleTextAlignment;
        }@catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
        
        NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[title rangeOfString:title]];
        [alertTitleStr addAttribute:NSForegroundColorAttributeName value:ALERT_TITLE_COLOR range:[title rangeOfString:title]];
        [alertVC setValue:alertTitleStr forKey:@"attributedTitle"];
    }
    
    /* 2.message */
    if (message) {
        @try
        {
            //下面是取title和message的父视图的代码：
            UIView *subView1 = alertVC.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            UILabel *messageLabel;
            if (title)
            {
                //获取message：
                messageLabel = subView5.subviews[1];
            }
            else
            {
                //获取message：
                messageLabel = subView5.subviews[0];
            }
            //然后设置message内容居左：
            messageLabel.textAlignment = messageTextAlignment;
            
        }@catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
        
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[message rangeOfString:message]];
        [alertMessageStr addAttribute:NSForegroundColorAttributeName value:ALERT_MESSAGE_COLOR range:[message rangeOfString:message]];
        [alertVC setValue:alertMessageStr forKey:@"attributedMessage"];
    }
    
    /* 3.textField */
    if (haveTextField)
    {
        // 创建文本框
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField){
            if (configurationHandler)
            {
                configurationHandler(textField);
            }
        }];
    }
    
    /* 4.配置左边按钮 */
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelButton style:[cancelButton isEqualToString:@"取消"] ? UIAlertActionStyleCancel : UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                             {
                                 if (cancelClick)
                                 {
                                     cancelClick(alertVC);
                                     [alertVC dismissViewControllerAnimated:NO completion:nil];
                                 }
                             }];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [cancel setValue:ACTION_SURE_COLOR forKey:@"_titleTextColor"];
    }
    
    /* 5.配置右边按钮 */
    UIAlertAction *defult = [UIAlertAction actionWithTitle:sureButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                             {
                                 if (sureClick)
                                 {
                                     sureClick(alertVC);
                                     [alertVC dismissViewControllerAnimated:NO completion:nil];
                                 }
                             }];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [defult setValue:ACTION_SURE_COLOR forKey:@"_titleTextColor"];
    }
    [alertVC addAction:cancel];
    [alertVC addAction:defult];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)systemDoubleButtonAlertShowWithTitle:(NSString *)title message:(NSString *)message titleTextAlignment:(NSTextAlignment)titleTextAlignment messageTextAlignment:(NSTextAlignment)messageTextAlignment haveTextField:(BOOL)haveTextField cancelButton:(NSString *)cancelButton sureButton:(NSString *)sureButton cancelColor:(UIColor *)cancelColor sureColor:(UIColor *)sureColor configurationHandler:(ConfigurationHandler)configurationHandler sureClick:(SystemSureClick)sureClick cancelClick:(SystemCancelClick)cancelClick
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    alertVC.view.backgroundColor = [UIColor whiteColor];
    alertVC.view.layer.cornerRadius = ALERT_CORNERRADIUS;
    
    /* 1.title */
    if (title) {
        
        @try
        {
            //下面是取title和message的父视图的代码：
            UIView *subView1 = alertVC.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            //获取message：
            UILabel *titleLabel = subView5.subviews[0];
            //然后设置message内容居左：
            titleLabel.textAlignment = titleTextAlignment;
        }@catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
        
        NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[title rangeOfString:title]];
        [alertTitleStr addAttribute:NSForegroundColorAttributeName value:ALERT_TITLE_COLOR range:[title rangeOfString:title]];
        [alertVC setValue:alertTitleStr forKey:@"attributedTitle"];
    }
    
    /* 2.message */
    if (message) {
        @try
        {
            //下面是取title和message的父视图的代码：
            UIView *subView1 = alertVC.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            UILabel *messageLabel;
            if (title)
            {
                //获取message：
                messageLabel = subView5.subviews[1];
            }
            else
            {
                //获取message：
                messageLabel = subView5.subviews[0];
            }
            //然后设置message内容居左：
            messageLabel.textAlignment = messageTextAlignment;
            
        }@catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
        
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[message rangeOfString:message]];
        [alertMessageStr addAttribute:NSForegroundColorAttributeName value:ALERT_MESSAGE_COLOR range:[message rangeOfString:message]];
        [alertVC setValue:alertMessageStr forKey:@"attributedMessage"];
    }
    
    /* 3.textField */
    if (haveTextField)
    {
        // 创建文本框
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField){
            if (configurationHandler)
            {
                configurationHandler(textField);
            }
        }];
    }
    
    /* 4.配置取消按钮 */
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelButton style:[cancelButton isEqualToString:@"取消"] ? UIAlertActionStyleCancel : UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                             {
                                 if (cancelClick)
                                 {
                                     cancelClick(alertVC);
                                 }
                             }];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [cancel setValue:cancelColor forKey:@"_titleTextColor"];
    }
    
    /* 5.配置确认按钮 */
    UIAlertAction *defult = [UIAlertAction actionWithTitle:sureButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                             {
                                 if (sureClick)
                                 {
                                     sureClick(alertVC);
                                 }
                             }];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [defult setValue:sureColor forKey:@"_titleTextColor"];
    }
    
    [alertVC addAction:cancel];
    [alertVC addAction:defult];
    [self presentViewController:alertVC animated:YES completion:nil];
}

/**
 *  系统的提示框一个按钮的alert
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param sureButton   确认按钮名称
 *  @param sureClick    确认block
 */
- (void)systemSingleButtonAlertShowWithTitle:(NSString *)title
                                     message:(NSString *)message
                          titleTextAlignment:(NSTextAlignment)titleTextAlignment
                        messageTextAlignment:(NSTextAlignment)messageTextAlignment
                               haveTextField:(BOOL)haveTextField
                               defaultButton:(NSString *)defaultButton
                        configurationHandler:(ConfigurationHandler)configurationHandler
                                   sureClick:(SystemSureClick)sureClick
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    alertVC.view.backgroundColor = [UIColor whiteColor];
    alertVC.view.layer.cornerRadius = ALERT_CORNERRADIUS;
    
    /* 1.title */
    if (title) {
        
        @try
        {
            //下面是取title和message的父视图的代码：
            UIView *subView1 = alertVC.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            //获取title：
            UILabel *titleLabel = subView5.subviews[0];
            //然后设置title内容对齐方式：
            titleLabel.textAlignment = titleTextAlignment;
        }@catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
        
        NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[title rangeOfString:title]];
        [alertTitleStr addAttribute:NSForegroundColorAttributeName value:ALERT_TITLE_COLOR range:[title rangeOfString:title]];
        [alertVC setValue:alertTitleStr forKey:@"attributedTitle"];
    }
    
    /* 2.message */
    if (message) {
        
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[message rangeOfString:message]];
        [alertMessageStr addAttribute:NSForegroundColorAttributeName value:ALERT_MESSAGE_COLOR range:[message rangeOfString:message]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2];
        [alertMessageStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [alertMessageStr.string length])];
        [alertVC setValue:alertMessageStr forKey:@"attributedMessage"];
        
        @try
        {
            //下面是取title和message的父视图的代码：
            UIView *subView1 = alertVC.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            UILabel *messageLabel;
            if (title)
            {
                //获取message：
                messageLabel = subView5.subviews[1];
            }
            else
            {
                //获取message：
                messageLabel = subView5.subviews[0];
            }
            //然后设置message内容居左：
            messageLabel.textAlignment = messageTextAlignment;
            
        }@catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
    }
    
    /* 3.textField */
    if (haveTextField)
    {
        // 创建文本框
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField){
            if (configurationHandler)
            {
                configurationHandler(textField);
            }
        }];
    }
    
    /* 4.配置确认按钮 */
    UIAlertAction *defult = [UIAlertAction actionWithTitle:defaultButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureClick) {
            sureClick(alertVC);
        }
    }];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [defult setValue:ACTION_SURE_COLOR forKey:@"_titleTextColor"];
    }
    
    [alertVC addAction:defult];
    [self presentViewController:alertVC animated:YES completion:nil];
}

/**
 *  系统的提示框一个按钮的alert
 *
 *  @param title        标题
 *  @param message      提示内容
 *  @param sureButton   确认按钮名称
 *  @param sureClick    确认block
 */
- (void)systemSingleButtonAlertShowWithTitle:(NSString *)title
                            attributeMessage:(NSMutableAttributedString *)attributeMessage
                          titleTextAlignment:(NSTextAlignment)titleTextAlignment
                        messageTextAlignment:(NSTextAlignment)messageTextAlignment
                               haveTextField:(BOOL)haveTextField
                               defaultButton:(NSString *)defaultButton
                        configurationHandler:(ConfigurationHandler)configurationHandler
                                   sureClick:(SystemSureClick)sureClick
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:attributeMessage.string preferredStyle:UIAlertControllerStyleAlert];
    alertVC.view.backgroundColor = [UIColor whiteColor];
    alertVC.view.layer.cornerRadius = ALERT_CORNERRADIUS;
    
    /* 1.title */
    if (title) {
        
        @try
        {
            //下面是取title和message的父视图的代码：
            UIView *subView1 = alertVC.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            //获取title：
            UILabel *titleLabel = subView5.subviews[0];
            //然后设置title内容对齐方式：
            titleLabel.textAlignment = titleTextAlignment;
        }@catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
        
        NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[title rangeOfString:title]];
        [alertTitleStr addAttribute:NSForegroundColorAttributeName value:ALERT_TITLE_COLOR range:[title rangeOfString:title]];
        [alertVC setValue:alertTitleStr forKey:@"attributedTitle"];
    }
    
    /* 2.message */
    if (attributeMessage) {
        
        [attributeMessage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[attributeMessage.string rangeOfString:attributeMessage.string]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2];
        [attributeMessage addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributeMessage.string length])];
        [alertVC setValue:attributeMessage forKey:@"attributedMessage"];
        
        @try
        {
            //下面是取title和message的父视图的代码：
            UIView *subView1 = alertVC.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            UILabel *messageLabel;
            if (title)
            {
                //获取message：
                messageLabel = subView5.subviews[1];
            }
            else
            {
                //获取message：
                messageLabel = subView5.subviews[0];
            }
            //然后设置message内容居左：
            messageLabel.textAlignment = messageTextAlignment;
            
        } @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
    }
    
    /* 3.textField */
    if (haveTextField)
    {
        // 创建文本框
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField){
            if (configurationHandler)
            {
                configurationHandler(textField);
            }
        }];
    }
    
    /* 4.配置确认按钮 */
    UIAlertAction *defult = [UIAlertAction actionWithTitle:defaultButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureClick) {
            sureClick(alertVC);
        }
    }];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [defult setValue:ACTION_SURE_COLOR forKey:@"_titleTextColor"];
    }
    
    [alertVC addAction:defult];
    [self presentViewController:alertVC animated:YES completion:nil];
}


/**
 *  title是图标的两个按钮的alert
 *
 *  @param IconType                  标题图标类型
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
                                  cancelClick:(SystemCancelClick)cancelClick
{
    NSString *messageStr = [NSString stringWithFormat:@"\n%@\n",message];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"1" message:messageStr preferredStyle:UIAlertControllerStyleAlert];
    alertVC.view.backgroundColor = [UIColor whiteColor];
    alertVC.view.layer.cornerRadius = ALERT_CORNERRADIUS;
    
    /* 1.title */
    UIImage *titleIcon;
    switch (iconType) {
        case ICON_TITLE_SUCCESS_TYPE:
            titleIcon = [self imageNamed:@"alert_success_icon" ofBundle:@"CDDAlert.bundle"];
            break;
        case ICON_TITLE_FAIL_TYPE:
            titleIcon = [self imageNamed:@"alert_fail_icon" ofBundle:@"CDDAlert.bundle"];
            break;
        case ICON_TITLE_WARNING_TYPE:
            titleIcon = [self imageNamed:@"alert_warning_icon" ofBundle:@"CDDAlert.bundle"];
            break;
        default:
            break;
    }
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = titleIcon;
    // 设置图片大小
    attch.bounds = CGRectMake(-2, -10, titleIcon.size.width / 4 * 3, titleIcon.size.height / 4 * 3);
    
    NSAttributedString *iconStr = [NSAttributedString attributedStringWithAttachment:attch];
    
    NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithAttributedString:iconStr];
    
    [alertVC setValue:alertTitleStr forKey:@"attributedTitle"];
    
    /* 2.message */
    if (messageStr) {
        @try
        {
            //下面是取title和message的父视图的代码：
            UIView *subView1 = alertVC.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            UILabel *messageLabel;
            //获取message：
            messageLabel = subView5.subviews[1];
            //然后设置message内容居左：
            messageLabel.textAlignment = messageTextAlignment;
            
        }@catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
        
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:messageStr];
        [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[messageStr rangeOfString:messageStr]];
        [alertMessageStr addAttribute:NSForegroundColorAttributeName value:ALERT_MESSAGE_COLOR range:[messageStr rangeOfString:messageStr]];
        [alertVC setValue:alertMessageStr forKey:@"attributedMessage"];
    }
    
    /* 3.配置取消按钮 */
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelButton style:[cancelButton isEqualToString:@"取消"] ? UIAlertActionStyleCancel : UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                             {
                                 if (cancelClick)
                                 {
                                     cancelClick(alertVC);
                                 }
                             }];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [cancel setValue:ACTION_CANCEL_COLOR forKey:@"_titleTextColor"];
    }
    
    /* 4.配置确认按钮 */
    UIAlertAction *defult = [UIAlertAction actionWithTitle:sureButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                             {
                                 if (sureClick)
                                 {
                                     sureClick(alertVC);
                                 }
                             }];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [defult setValue:ACTION_SURE_COLOR forKey:@"_titleTextColor"];
    }
    
    [alertVC addAction:cancel];
    [alertVC addAction:defult];
    [self presentViewController:alertVC animated:YES completion:nil];
}

/**
 *  title是图标的一个按钮的alert
 *
 *  @param IconType                  标题图标类型
 *  @param message                   提示内容
 *  @param messageTextAlignment      提示内容对齐方式
 *  @param sureButton                确认按钮名称
 *  @param sureClick                 确认block
 */
- (void)iConSingleButtonAlertShowWithIconType:(IconTitleType)iconType
                                      message:(NSString *)message
                         messageTextAlignment:(NSTextAlignment)messageTextAlignment
                                defaultButton:(NSString *)defaultButton
                                    sureClick:(SystemSureClick)sureClick
{
    NSString *messageStr = [NSString stringWithFormat:@"\n\n%@\n",message];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"1" message:messageStr preferredStyle:UIAlertControllerStyleAlert];
    
    alertVC.view.backgroundColor = [UIColor whiteColor];
    alertVC.view.layer.cornerRadius = ALERT_CORNERRADIUS;
    
    /* 1.title */
    UIImage *titleIcon;
    switch (iconType) {
        case ICON_TITLE_SUCCESS_TYPE:
            titleIcon = [self imageNamed:@"alert_success_icon" ofBundle:@"CDDAlert.bundle"];
            break;
        case ICON_TITLE_FAIL_TYPE:
            titleIcon = [self imageNamed:@"alert_fail_icon" ofBundle:@"CDDAlert.bundle"];
            break;
        case ICON_TITLE_WARNING_TYPE:
            titleIcon = [self imageNamed:@"alert_warning_icon" ofBundle:@"CDDAlert.bundle"];
            break;
        default:
            break;
    }
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = titleIcon;
    // 设置图片大小
    attch.bounds = CGRectMake(-2, -20, titleIcon.size.width / 10.0 * 9, titleIcon.size.height / 10.0 * 9);
    
    NSAttributedString *iconStr = [NSAttributedString attributedStringWithAttachment:attch];
    
    NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithAttributedString:iconStr];
    
    [alertVC setValue:alertTitleStr forKey:@"attributedTitle"];
    
    /* 2.message */
    if (messageStr) {
        @try
        {
            //下面是取title和message的父视图的代码：
            UIView *subView1 = alertVC.view.subviews[0];
            UIView *subView2 = subView1.subviews[0];
            UIView *subView3 = subView2.subviews[0];
            UIView *subView4 = subView3.subviews[0];
            UIView *subView5 = subView4.subviews[0];
            UILabel *messageLabel;
            //获取message：
            messageLabel = subView5.subviews[1];
            //然后设置message内容居左：
            messageLabel.textAlignment = messageTextAlignment;
            
        }@catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
        
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:messageStr];
        [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[messageStr rangeOfString:messageStr]];
        [alertMessageStr addAttribute:NSForegroundColorAttributeName value:ALERT_MESSAGE_COLOR range:[messageStr rangeOfString:messageStr]];
        [alertVC setValue:alertMessageStr forKey:@"attributedMessage"];
    }
    
    /* 3.配置确认按钮 */
    UIAlertAction *defult = [UIAlertAction actionWithTitle:defaultButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                             {
                                 if (sureClick)
                                 {
                                     sureClick(alertVC);
                                 }
                             }];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [defult setValue:ACTION_SURE_COLOR forKey:@"_titleTextColor"];
    }
    
    [alertVC addAction:defult];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (UIImage *)imageNamed:(NSString *)name ofBundle:(NSString *)bundleName
{
    UIImage *image = nil;
    NSString *image_name = [NSString stringWithFormat:@"%@", name];
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    NSString *image_path = [bundlePath stringByAppendingPathComponent:image_name];
    image = [[UIImage alloc] initWithContentsOfFile:image_path];
    return image;
}

@end
