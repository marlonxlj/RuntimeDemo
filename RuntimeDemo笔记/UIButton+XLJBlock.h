//
//  UIButton+XLJBlock.h
//  RuntimeDemo笔记
//
//  Created by m on 2017/1/19.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
typedef void (^TapBlock)(UIButton *sender);

@interface UIButton (XLJBlock)

- (void)tapWithEvent:(UIControlEvents )controlEvent withBlock:(TapBlock)tapBlock;

@end
