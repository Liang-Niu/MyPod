//
//  MacrosHead.h
//  new-test
//
//  Created by Alvin on 17/6/20.
//  Copyright © 2017年 Alvin. All rights reserved.
//

#ifndef MacrosHead_h
#define MacrosHead_h

//获取系统对象

#define KApplication [UIApplication sharedApplication]

#define KAppWindow [UIApplication sharedApplication].delegate.window

#define KAppDelegate [AppDelegate shareAppDelegate]

#define KRootViewController [UIApplication sharedApplication].delegate.window.rootViewController

#define KUserDefaults [NSUserDefaults standardUserDefaults]

#define KNotificationCenter [NSNotificationCenter defaultCenter]

//获取屏幕宽高

#define KScreenWidth [[UIScreen mainScreen]bounds].size.width

#define KScreenHeight [[UIScreen mainScreen]bounds].size.height

#define KScreen_Bounds [UIScreen mainScreen].bounds

//强弱引用

#define kWeakSelf(type)__weak typeof(type)weak##type = type;

#define kStrongSelf(type)__strong typeof(type)type = weak##type;

//当前系统版本

#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

//-------------------打印日志-------------------------

//DEBUG模式下打印日志,当前行

#ifdef DEBUG

#define DLog(fmt,...)NSLog((@"%s[Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__);

#else

#define DLog(...)

#endif

//拼接字符串

#define NSStringFormat(format,...)[NSString stringWithFormat:format,##__VA_ARGS__]

#define kRandomColorKRGBColor (arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)//随机色生成

//字体

#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]

#define SYSTEMFONT(FONTSIZE)[UIFont systemFontOfSize:FONTSIZE]

#define FONT(NAME,FONTSIZE)[UIFont fontWithName:(NAME)size:(FONTSIZE)]

//打印当前方法名

#define ITTDPRINTMETHODNAME()ITTDPRINT(@"%s",__PRETTY_FUNCTION__)

//GCD

#define kDISPATCH_ASYNC_BLOCK(block)dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),block)

#define kDISPATCH_MAIN_BLOCK(block)dispatch_async(dispatch_get_main_queue(),block)

//GCD -一次性执行

#define kDISPATCH_ONCE_BLOCK(onceBlock)static dispatch_once_t onceToken;dispatch_once(&onceToken,onceBlock);

#endif /* MacrosHead_h */
