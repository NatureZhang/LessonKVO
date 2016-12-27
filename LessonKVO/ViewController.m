//
//  ViewController.m
//  LessonKVO
//
//  Created by zhangdong on 16/12/27.
//  Copyright © 2016年 __Nature__. All rights reserved.
//

#import "ViewController.h"

@interface Sark : NSObject
@property (nonatomic, copy) NSString *name;
@end
@implementation Sark

- (void)willChangeValueForKey:(NSString *)key {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super didChangeValueForKey:key];
}

@end

//http://blog.sunnyxx.com/2014/03/09/objc_kvo_secret/

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testKVO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)testKVO {
    
    Sark *sark = [Sark new];
    
    // 当一个object有观察者时，动态创建一个子类，对象的isa 指针 指向新的类型
    [sark addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    // 重写被观察属性的set方法，在setter方法中调用willChangeValueForKey和didChangeValueForKey
    sark.name = @"zhangsan";
    
    // 当一个property没有重写观察者时，删除重写的方法
    // 当没有observer观察任何一个property时，删除动态创建的子类
    [sark removeObserver:self forKeyPath:@"name"];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
}
@end
