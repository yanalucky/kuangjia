//
//  AU_Header.h
//  demo
//
//  Created by perfayMini on 2018/11/23.
//  Copyright © 2018 huawei. All rights reserved.
//

#ifndef AU_Header_h
#define AU_Header_h


#define  NSFormatHeardMeThodUrl(methodName,urlString) [NSString stringWithFormat:@"%@%@%@.html",NSServiceHeaderUrl,methodName,urlString]

//防止循环引用weak
#define WEAKSELF(weakSelf)      __weak __typeof(&*self)weakSelf = self;
//防止提前释放strong
#define STRONGSELF(strongSelf)  __strong __typeof(&*self)strongSelf = weakSelf;

//单例类
#define  OBJC_Defaults   [NSUserDefaults  standardUserDefaults]

//输出宏
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

//获取屏幕大小
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

//屏幕适配比例
#define kAutoWidth6(width)      (width) *(kScreenWidth/375)
#define kAutoHeight6(height)    (height)*(KScreenHeight/667)

#define kAutoWidth6px(width)     (width)*(kScreenWidth/1242)
#define kAutoWidth6px_h(height)  (height)*(KScreenHeight/2208)


//判断设备
#define IPHONE4  ((int)KScreenHeight%480==0)
#define IPHONE5  ((int)KScreenHeight%568==0)
#define IPHONE6  ((int)KScreenHeight%667==0)
#define IPHONE6P ((int)KScreenHeight%736==0)
#define IPHONEX  ((int)KScreenHeight%812==0)


#define IOS10_Early    ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)

//颜色
#define UIStringColorAlpha(kcolor,kalpha) [UIColor colorWithString:kcolor alpha:kalpha]
#define UIStringColor(kcolor) [UIColor colorWithString:kcolor]

#define UIRGBColor(r,g,b,a)   [UIColor colorWithRed:(r) / 255. green:(g) / 255. blue:(b) / 255. alpha:(a)]

/*常使用颜色*/
#define UIBackGroundColor       UIStringColor(@"#f7f4f2")  //背景色

#define UISepratorLineColor     UIRGBColor(234,234,234,1) //分割线 灰
#define UINavSepratorLineColor  UIStringColor(@"eaeaea") //分割线 灰

#define UIFontBlack1Color       UIStringColor(@"#090909") //字体黑
#define UIFontRedColor          UIStringColor(@"#f63378")  //字体红
#define UIFontRed_newColor      UIStringColor(@"#e5486a")  //字体红
#define UIFontNone_newColor     UIStringColor(@"#636363")  //无货背景
#define UIFontBlack282828       UIStringColor(@"#282828") // 字体黑 新加

#define UIFontMainGrayColor     UIRGBColor(40, 40, 40, 1) //常规深灰
#define UIFontSortGrayColor     UIRGBColor(90, 90, 90, 1) //首页分类深灰
#define UIFontMiddleGrayColor   UIRGBColor(123, 123, 123, 1) //中灰
#define UIFontPlaceholderColor  UIRGBColor(190, 190, 190, 1) //输入框占位符

#define UIFontBlackColor        [UIColor blackColor]
#define UIFontWhiteColor        [UIColor whiteColor]
#define UIFontClearColor        [UIColor clearColor]
#define UIFontPhotoColor        [UIColor colorWithRed:253/255.0 green:142/255.0 blue:36/255.0 alpha:1]

//尺寸
#define UIFontSacleSize(size)  [Fcgo_Tools getFontWithFontSize:size]
#define UIFontSize(size)       [Fcgo_Tools getFontWithFontSize:size bold:NO]
#define UIBoldFontSize(size)   [Fcgo_Tools getFontWithFontSize:size bold:YES]


//提示框
#define alert(msg) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];\
[alert show];

#endif /* AU_Header_h */
