//
//  ViewController.m
//  RuntimeDemo笔记
//
//  Created by m on 2017/1/6.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "ViewController.h"
#import "XLJAbookCell.h"
#import <objc/runtime.h>
#import "UIButton+XLJBlock.h"
#import <objc/message.h>

#define XLJScreenWeight [UIScreen mainScreen].bounds.size.width

#define XLJScreenHeight [UIScreen mainScreen].bounds.size.height
static NSString *Identifer = @"XLJAbookCell";

static const void *CallBtnKey=&CallBtnKey;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] initWithArray:@[@"10086",@"10000",@"10001",@"https://my.oschina.net/carson6931/blog/506050"]];
//    [self initTable];
    
    //测试Category
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0, 0, 100, 40);
    btn.center = self.view.center;
    [self.view addSubview:btn];
    btn.tag = 10000;
    [btn tapWithEvent:UIControlEventTouchUpInside withBlock:^(UIButton *sender) {
        NSLog(@"sender.tag = %ld",sender.tag);
    }];
    
    //消息事件,修改按钮的背景颜色为橙色;原来为红色
    objc_msgSend(btn, @selector(setBackgroundColor:), [UIColor orangeColor]);
    
    /**
     * 1.动态绑定传递参数
     * 2.Category分类添加事件
     * 3.在不知的源码里面通过set和get方法，添加属性
     * 4.objc消息机制 objc_msgSend(btn,btnSel,[UIColor orangeColor])
     * 5.交换方法:exchangeIMP
     */
    
    
    [self funcTest1];
}

+ (void)load
{
    SEL sel1 = @selector(funcTest1);
    
    Method m1 = class_getInstanceMethod([self class], sel1);
    
    SEL sel2 = @selector(funcTest2);
    
    Method m2 = class_getInstanceMethod([self class], sel2);
    
    method_exchangeImplementations(m1, m2);

}

- (void)funcTest1{
    NSLog(@"我是测试1");
}

- (void)funcTest2
{
    NSLog(@"我是测试2");
}

- (void)initTable
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XLJScreenWeight, XLJScreenHeight-64) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"XLJAbookCell"  bundle:nil] forCellReuseIdentifier:Identifer];
}

#pragma mark DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLJAbookCell *cell = (XLJAbookCell *)[tableView dequeueReusableCellWithIdentifier:Identifer];
    
    cell.lableString.text = _dataSource[indexPath.row];

    cell.callBlock = ^(UIButton *sender){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:[NSString stringWithFormat:@"%@",_dataSource[indexPath.row]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        
        [alert show];
        
        //关联对象,绑定
        /**
         * 1.目标
         * 2.标识id
         * 3.value就是值，在此处是号码
         * 4.策略
         */
        objc_setAssociatedObject(alert, CallBtnKey,[NSString stringWithFormat:@"%@",_dataSource[indexPath.row]], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    };
    return cell;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex) {
        //取出关联的值
        NSString *str = objc_getAssociatedObject(alertView, CallBtnKey);
        NSString *callStr = [NSString stringWithFormat:@"tel://%@",str];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callStr]];
        
    }else{
        NSLog(@"fff11");
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
@end
