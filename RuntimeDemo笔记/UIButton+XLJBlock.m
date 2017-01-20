//
//  UIButton+XLJBlock.m
//  RuntimeDemo笔记
//
//  Created by m on 2017/1/19.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "UIButton+XLJBlock.h"

static const void *ButtonKey = &ButtonKey;

@implementation UIButton (XLJBlock)

- (void)tapWithEvent:(UIControlEvents)controlEvent withBlock:(TapBlock)tapBlock
{
    objc_setAssociatedObject(self, ButtonKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:controlEvent];
}

- (void)buttonClick:(UIButton *)sender
{
   TapBlock tapBlock = objc_getAssociatedObject(sender, ButtonKey);
    
    if (tapBlock) {
        tapBlock(sender);
    }
}

@end
