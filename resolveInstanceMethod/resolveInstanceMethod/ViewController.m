//
//  ViewController.m
//  resolveInstanceMethod
//
//  Created by 钱俞辉 on 2020/4/16.
//  Copyright © 2020年 钱俞辉. All rights reserved.
//

#import "ViewController.h"
#import "objc/runtime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(foo:)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if(sel == @selector(foo:))
    {
        class_addMethod([self class], sel, (IMP)fooMethod, "v@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void fooMethod(id obj, SEL _cmd) {
    NSLog(@"Doing foo");
}


@end
