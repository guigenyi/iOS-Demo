//
//  ViewController.m
//  forwardingTargetForSelector
//
//  Created by 钱俞辉 on 2020/4/15.
//  Copyright © 2020年 钱俞辉. All rights reserved.
//

#import "ViewController.h"

@interface Person : NSObject

@end

@implementation Person

- (void)foo {
    NSLog(@"Doing foo");
}

@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(foo)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;//返回YES进入下一步转发
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if(aSelector == @selector(foo)) {
        return [Person new]; //返回Person对象，让Person对象接受这个消息
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end
