//
//  ViewController.m
//  new-test
//
//  Created by Alvin on 17/5/24.
//  Copyright © 2017年 Alvin. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Test.h"
#import "objc/runtime.h"
#import "String.h"
#import "ViewController2.h"

@interface ViewController ()

@property(nonatomic, assign) void(^block)();
@property (nonatomic, copy) NSString *str;
@property (nonatomic, strong) Model *model;
@end

@implementation ViewController
/*
assign： 用于非指针变量。用于
基础数据类型 （例如NSInteger）和C数据类型（int, float, double, char, 等），另外还有id
 
 1.strong :除NSString\block以外的OC对象
 @property(nonatomic,strong) NSArray  *model;
 2.weak：各种UI控件(但不是绝对，也有控件要使用strong属性的，但是xib中必须使用weak，因为控件被拖进xib的时候就被strong修饰了)
 @property (nonatomic,weak) UIButton *button;
 3.assign：CGFloat，NSInteger等基本数据类型、枚举、结构体（非OC对象）
 @property(nonatomic,assign) CGFloat model;
 4.copy：
 <1. copy : 创建的是不可变副本(如NSString、NSArray、NSDictionary)
 <2.  mutableCopy :创建的是可变副本(如NSMutableString、NSMutableArray、NSMutableDictionary)
 <3. @property(nonatomic,copy)NSString *model;
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];

    [self test9];
   
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
}

- (void)click{
    [_model setModel];
    
    ViewController2 *vc = [ViewController2 new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)test1{
    int value = 10;
    
    void(^blockC)() = ^{
        NSLog(@"just a block === %d", value);
    };
    
    NSLog(@"%@", blockC);
    _block = blockC;

}

- (void)test3{
    int base = 100;
    int (^myBlockTwo)(int,int) = ^ (int a, int b) {
        return base + a + b;
    };
    base = 200;
    //103
    NSLog(@"%d", myBlockTwo(1, 2));
    
    
    
    static int base2 = 100;
    int (^myBlock)(int, int) = ^ (int a, int b) {
        return base2 + a + b;
    };
    base2 = 200;
    // base:200     myBlock:203
    NSLog(@"base:%d     myBlock:%d",base2,myBlock(1,2));
//    全局变量或静态变量。在内存中的地址是固定的，Block在读取该变量值的时候是直接从其所在内存读出，获取到的是最新值，而不是在定义时截获的值。
}

- (void)test4{
    
    int iCode = 10;
    NSString *strName = @"Tom";
    
    void (^myBlock)(void) = ^{
        // 结果:My name is Tom,my code is 10
        NSLog(@"My name is %@,my code is %d", strName, iCode);
    };
    
    iCode = 20;
    strName = @"Jim";
    
    myBlock();
    // 结果:My name is Jim,my code is 20
    NSLog(@"My name is %@,my code is %d", strName, iCode);
//    从代码中可以看到，Block表达式截获所使用的自动变量iCode和strName的值，即保存该自动变量的瞬间值。因为Block表达式保存了自动变量的值，所以在执行Block语法后，即使改写Block中所用的自动变量的值也不会影响Block执行时自动变量的值，这就是自动变量值的截获。
}
#pragma mark - 关联属性的作用，1.给分类添加属性（下面为每个对象添加属性）（可作为对象的标签或存储信息）2.在既有类中使用关联对象存放自定义数据
- (void)test2{
    
    NSString *str = @"niuliang";
    str.name = @"as";
    str.books = @[@"1",@"2"];
    NSLog(@"%@",str.name);
    NSLog(@"%@",str.books);
}

- (void)test6{
    unsigned int count;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
    
}
- (void)test7{
    Model *str = [[Model alloc]init];
//    [str performSelector:@selector(eat)];
}
- (void)test8{
    Model *model = [[Model alloc]init];
    
    model.name = @"123";
    model.block = ^{
        NSLog(@"block-block-%@",model.name);
  
    };
    //此处model没有被释放
    model.block();
}
-(void)test9{
    NSString *A = @"1";
    NSMutableString *B = [[NSMutableString alloc] initWithString:@"2"];
    NSLog(@"A:%p,B:%p",&A,&B);
    NSLog(@"内容:A:%p,B:%p",A,B);
    
    NSString *AA = [A copy];
    NSString *BB = [B copy];
    NSMutableString *BBB = [B copy];
    NSLog(@"AA:%p,BB:%p,BBB:%p",&AA,&BB,&BBB);
    NSLog(@"内容:AA:%p,BB:%p,BBB:%p",AA,BB,BBB);
    
//    NSString通过copy之后生成的新对象的内容还是和copy之前相同
//    NSMutableString通过copy之后生成的新对象和内容都和copy之前不相同
//    NSMutableString通过copy之后 生成的无论是NSString还是NSMutableString对象他们的内容也都相同
}
//1，下面代码在按钮点击后，在ARC下会发生什么，MRC下呢？为什么？
//
//@property(nonatomic, assign) void(^block)();
//
//- (void)viewDidLoad {
//    [superviewDidLoad];
//    int value = 10;
//    void(^blockC)() = ^{
//        NSLog(@"just a block === %d", value);
//    };
//    
//    NSLog(@"%@", blockC);
//    _block = blockC;
//    
//}
//
//- (IBAction)action:(id)sender {
//    NSLog(@"%@", _block);
//}
//
//2，在ARC环境下这段代码为什么不会崩溃？
//
//@property(nonatomic, weak) void(^block)();
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    void(^ __weak blockA)() = ^{
//        NSLog(@"just a block");
//    };
//    
//    _block = blockA;
//    
//}
//
//- (IBAction)action:(id)sender {
//    _block();
//}
//
//3，下面是一个员工表，manager_id表示对应的boss的ID。通过一个SQL找出下表中比boss工资还高的人。。。。
//id    name    salary    manager_id
//1    Noah    70000    NULL
//2    西兰花    80000    1
//3    椰菜花    80000    NULL
//4    没钱花    80000    3
//
//输出格式为：
//select b.name from table_name as a, table_name as b where a.id is b.manager_id and a.salary < b.salary
//name
//西兰花
//
//4，写一个函数，输入一个数如38，拆分 3 + 8 = 11，1 + 1 = 2，最后2无法拆分就返回（伪代码也行）
//
//5，通过runtime添加的“关联对象”和类的实例变量有什么区别？使用时要注意什么？
// 不能通过指针直接访问变量。访问效率比实例变量低。
//使用时注意，不能讲对象的实例变量当做关联对象关联到实例上。
//6，用一个生活中的例子来说说同步和异步。
//
//7，线程间通信在OC中有几种方式？分别是？常用那种？
//
//8，使用快速枚举迭代一个可变数组时需要注意什么问题？怎么避免？
//快速枚举时，不能改变数组中的元素。使用传统的 for 循环。
//9，什么是面向对象的多态性？
//多态性是指函数的方法签名相同，但是参数个数不同的情况下，可以根据传入的参数个数来调用不同函数的情况。OC 没有这种功能。
//10，UIViewController的presentViewController和UINavigationController的pushViewController方法分别多用于什么交互场景？
//presentViewController是模态窗口，模态窗口通常用来表示用户不可以跳过的操作。pushViewController是将当前窗口入栈并压入一个普通窗口。
//11，NSOperation和GCD的区别是什么？前者多用于什么场景？
// NSOperation是 GCD 的高级封装。NSOperationQueue 可以实现一个 operation 必须在另一个 operation 完成之后再运行的功能。
//12，面向接口编程指的是什么？为什么说面向实现编程是一种错误的编程方式？
// 面向接口编程是指，模块需要实现的功能由接口来指定。优势在于，可以将接口和实现分离开，有利于实现单一职责原则，在实现的时候，能将相关联的功能写在一起，也能避免类膨胀，可以在必要时将实现分离开。
//13，在iOS开发中遇到那些类族(Class Cluster) ？如NSNumber这种。为什么需要这种设计方式？
//NSString NSArray 之类的底层实现都是累族。有利于在不同情况下使用不同的算法与数据结构，提高效率。
//14，javascript的原型链和OC的继承有什么区别？
// Javascript 的原型链继承，只能继承方法不能继承成员变量。
//15，Hybrid开发的优势在哪里？目前有那些框架可以实现Hybrid开发？
//降低开发成本，提高速度。PhoneGap
//16，使用了ARC是不是就等于没有内存泄漏了？如果不是的话请举例。
//不是。block 造成循环引用。
//17，下面代码中为什么可以直接用self？
//[UIView animateWithDuration:1 animations:^{
//    self.view.backgroundColor = [UIColor yellowColor];
//}];
//可以，animation 运行完成后会释放 block。
//下面这段代码可以用self吗？为什么？
//- (void)doSomething {
//    [BlockClass doSomethingUseBlock:^{
//        NSLog(@"%@", self);
//    }];
//}
//最好不要，BlockClass 的+方法可能会一直持有这个 block 造成循环引用。
//18，进程的内存布局是怎样的？
//所有父类的成员变量和自己的成员变量都会存放在该对象所对应的存储空间中.
//每一个对象内部都有一个isa指针,指向他的类对象,类对象中存放着本对象的{对象方法列表（对象能够接收的消息列表，保存在它所对应的类对象中）、成员变量的列表、属性列表）
//    根对象就是NSObject，它的superclass指针指向nil
//    类对象既然称为对象，那它也是一个实例。类对象中也有一个isa指针指向它的元类(meta class)，即类对象是元类的实例
//19，在GCD中，那几种场景会出现死锁的现象？怎么避免？
//在同一个线程多次 dispatch_sync 会死锁。如果 GCD 中传入的 block 里面用了线程通信的机制也可能造成死锁
//20，怎么用NSOperation封装一个异步请求？这个Operation需要放到NSOperationQueue里调度的。
//
//21，CoreFoundation和Foundation有什么区别？
// Foundation 是对 CoreFoundation 的 OBJC 封装。
//22，怎么判断两个链表是双交的？
//(1)循环判断链表 b 节点的地址是否在链表 a 中。（2）将链表 a 节点地址做 hash，再将 b 的地址做 hash 看看是否有相同的 hash 值。
//23，怎么判断一个链表存在环?
//用指针 p 遍历节点，将 p 的值做 hash，如果遍历过程中存在相同 hash 值，表示链表有环。
//24，当一个View的bounds原点不为0的时候会出现什么情况？
//
//25，OC的数组是怎么实现的？和C的数组区别在？简单说一下即可。
//
//26，weak和assign有什么区别？
//
//27，setNeedLayout的作用是什么？
//
//28，什么时候用NS_OPTIONS，NS_ENUM?

@end
