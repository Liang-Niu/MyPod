//
//  ViewController2.m
//  new-test
//
//  Created by Alvin on 17/5/26.
//  Copyright © 2017年 Alvin. All rights reserved.
//

#import "ViewController2.h"
#import "Model2.h"
#import "MacrosHead.h"
#import <WebKit/WebKit.h>
#import "JCBrightness.h"
#import "UIViewController+Loading.h"

@interface ViewController2 ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation ViewController2
{
    int i;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showLoadingView];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userDidTakeScreenshot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    Model2 *model = [[Model2 alloc]init];
//    [model setModel];
    
//    //创建异步串行队列
//    dispatch_queue_t queue = dispatch_queue_create("me.tutuge.test.gcd", DISPATCH_QUEUE_SERIAL);
//    //运行block3次
//    dispatch_apply(3, queue, ^(size_t i) {
//        NSLog(@"apply loop: %zu", i);
//    });
//    //打印信息
//    NSLog(@"After apply");
//    [self groupSync];

    
//    i = 1;
//    
}
//模糊
- (void)test2{
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"timg.jpg"];
        [self.view addSubview:imageView];
        imageView.frame = CGRectMake(0, 64, 300, 300);
    
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, 0, imageView.frame.size.width * 0.5, imageView.frame.size.height);
        [imageView addSubview:effectView];

}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if (i/2 == 0) {
//        // 设置亮度
//        [JCBrightness graduallySetBrightness:0.9];
//        i++;
//    }else{
//        // 设置亮度
//        [JCBrightness graduallyResumeBrightness];
//        i++;
//    }
//}
- (void)groupSync2
{
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        dispatch_async(globalQueue, ^{
            sleep(5);
            NSLog(@"任务一完成");
        });
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        dispatch_async(globalQueue, ^{
            sleep(8);
            NSLog(@"任务二完成");
        });
    });
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"notify：任务都完成了");
    });
}- (void)groupSync
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(5);
        NSLog(@"任务一完成");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(8);
        NSLog(@"任务二完成");
        dispatch_group_leave(group);
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务完成");
    });
}
- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    NSLog(@"检测到截屏");
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [self imageWithScreenshot];
    
    //添加显示
    UIImageView *imgvPhoto = [[UIImageView alloc]initWithImage:image_];
    imgvPhoto.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    //添加边框
    CALayer * layer = [imgvPhoto layer];
    layer.borderColor = [
                         [UIColor whiteColor] CGColor];
    layer.borderWidth = 5.0f;
    //添加四个边阴影
    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
    imgvPhoto.layer.shadowOffset = CGSizeMake(0, 0);
    imgvPhoto.layer.shadowOpacity = 0.5;
    imgvPhoto.layer.shadowRadius = 10.0;
    //添加两个边阴影
    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
    imgvPhoto.layer.shadowOffset = CGSizeMake(4, 4);
    imgvPhoto.layer.shadowOpacity = 0.5;
    imgvPhoto.layer.shadowRadius = 2.0;
    
    imgvPhoto.center = self.view.center;
    
    
    [self.view addSubview:imgvPhoto];
}
- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}
//1.搞清楚touch事件的传递(事件的响应链)
//2.fame，bounds，center，alpha,opaque,hidden
//3，nil,NSNULL,NULL区别
//4.KVC and KVO
//5.NSThread,NSOperation,GCD
//6.autorelease ,ARC 和非ARC
//
//autorelease 自动释放，与之相关联的是一个自动释放池（NSAutoReleasePool）.autorelease的变量会被放入自动释放池中。等到自动释放池释放时（drain）时，自动释放池中的自动释放变量会随之释放。ios系统应用程序在创建是有一个默认的NSAutoReleasePool，程序退出时会被销毁。但是对于每一个RunLoop，系统会隐含创建一个AutoReleasePool，所有的release pool会构成一个栈式结构，每一个RunLoop结束，当前栈顶的pool会被销毁。
//
//ARC，自动应用计数。（iOS 6加入）IOS内存管理是基于变量的应用计数的。这样系统帮你管理变量的release，retain等操作。
//
//非ARC，非自动应用计数。手动管理内存。自己负责系统变量的release，retain等操作。做到谁分配谁释放，及alloc和release像对应。函数返回对象时使用autorelease。
//
//可以使用Xcode将非ARC转化为ARC，ARC和非ARC混编。可在在编译ARC时使用－fno－objc－arc，-fobjc-arc标签。实际需要看工程是支持还是不支持ARC模式。

//8.loadView,viewDidLoad,ViewDidUnload,viewWillAppear,viewDidAppear,viewwilldDisappear,viewDidDisappear
//
//当view的nib文件为nil时，手动创建界面时调用loadView，当view的nib文件存在时，会在viewDidLoad中实现。但是当你的程序运行期间内存不足时，视图控制器收到didReceiveMemoryWarning时，系统会检查当前的视图控制器的view是否还在使用，如果不在，这个view会被release，再次调用loadView来创建一个新的View。viewDidLoad ,不论是从xib中加载视图，还是从loadview生成视图，都会被调用。但是如果改view在栈中下一次显示是不会被调用。ViewWillAppear，ViewDidAppear会在view每次即将可见和完全显示时都会调用。我们会在ViewWillAppear里面进行一些view显示的准备工作，ViewDidDi sappear 和ViewWillDisAppear时会在view每次消失时都会调用。当系统收到didReceiveMemoryWarning通知时显示内存不足时，会调用ViewDidUnload来清理View中的数据和release后置为nil。

//
//11，NSRunLoop 和NSOperationQueue
//
//NSRunLoop 是所有要监视的输入源和定时源以及要通知的注册观察者的集合.用来处理诸如鼠标，键盘事件等的输入源。每一个线程拥有自己的RunLoop有系统自动创建。你不应该自己去创建，只能获取。一般不会用NSRunLoop,因为它不是线程安全的。一般都用CFRunLoop，这个是线程安全的，是一种消息处理模式，我们一般不用进行处理。
//
//NSOperationQueue时一个管理NSOperation的队列。我们会把NSOperation放入queue中进行管理。
//
//
//
//12,IOS常用的设计模式
//13.内存管理和优化
//14，tableview的优化
//
//优化：
//
//1.1 正确的复用cell。
//
//1.2 减少在返回每个cell里面的处理逻辑和处理时间。尽量将数据进行缓存和复用。
//
//1.3，尽量减少处理加载和计算的时间，不阻塞UI线程。
//
//1.4，尽量使用绘制每个cell。
//
//1.5，设置每个cell的opaque属性。
//
//1.6，尽量返回每行固定的height。
//
//1.7，在每个cell减少图形效果。
//
//1.8，分段加载数据。


@end
