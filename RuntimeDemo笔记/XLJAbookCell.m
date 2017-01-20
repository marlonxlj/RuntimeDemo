//
//  XLJAbookCell.m
//  RuntimeDemo笔记
//
//  Created by m on 2017/1/19.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import "XLJAbookCell.h"

@interface XLJAbookCell ()

@end

@implementation XLJAbookCell

- (void)awakeFromNib {
    [self.callButton addTarget:self action:@selector(callTel:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)callTel:(UIButton *)btn
{
    if (self.callBlock) {
        self.callBlock(btn);
    }
}

- (IBAction)callAction:(id)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
