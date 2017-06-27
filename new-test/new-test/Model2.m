//
//  Model2.m
//  new-test
//
//  Created by Alvin on 17/5/26.
//  Copyright © 2017年 Alvin. All rights reserved.
//

#import "Model2.h"

@implementation Model2

-(void)dealloc{
    NSLog(@"2%s",__func__);
    NSLog(@"摧毁了2");
}
- (void)setModel{
    NSLog(@"setmodel2");
}
@end
