//
//  NSString+Test.h
//  new-test
//
//  Created by Alvin on 17/5/24.
//  Copyright © 2017年 Alvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Test)
/**
 *  为每一个对象添加一个name属性
 */
@property (nonatomic,copy) NSString *name;
/**
 *  为每个对象添加一个数组属性
 */
@property (nonatomic,strong) NSArray *books;

- (NSArray *)getArray;


@end
