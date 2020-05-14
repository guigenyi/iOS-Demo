//
//  ViewController.m
//  forwardInvocation
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
    // Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(foo)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return YES; //返回YES进入下一步转发
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil; //返回nil进入下一步转发
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if([NSStringFromSelector(aSelector) isEqualToString:@"foo"]) {
        return [NSMethodSignature signatureWithObjCTypes:"@v@:"]; // 签名进入forwardInvocation
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    
    Person *p = [Person new];
    if([p respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:p];
    }
    else {
        [self doesNotRecognizeSelector:sel];
    }
}

@end
