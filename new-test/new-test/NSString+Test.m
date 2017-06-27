//
//  NSString+Test.m
//  new-test
//
//  Created by Alvin on 17/5/24.
//  Copyright © 2017年 Alvin. All rights reserved.
//

#import "NSString+Test.h"
#import "objc/runtime.h"

@implementation NSString (Test)

// 用一个字节来存储key值，设置为静态私有变量，避免外界修改
static char nameKey;
- (void)setName:(NSString *)name
{
    // 将某个值与某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, &nameKey);
}

static char booksKey;
- (void)setBooks:(NSArray *)books
{
    objc_setAssociatedObject(self, &booksKey, books, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)books
{
    return objc_getAssociatedObject(self, &booksKey);
}

- (NSArray *)getArray{
    return @[@"sasa"];
}

@end
