//
//  String.h
//  new-test
//
//  Created by Alvin on 17/5/24.
//  Copyright © 2017年 Alvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) void (^block)();

- (void)setModel;

@end
