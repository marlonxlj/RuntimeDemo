//
//  XLJAbookCell.h
//  RuntimeDemo笔记
//
//  Created by m on 2017/1/19.
//  Copyright © 2017年 XLJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBtnBlock)(UIButton *callBtn);

@interface XLJAbookCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lableString;

@property (weak, nonatomic) IBOutlet UIButton *callButton;

@property (nonatomic, copy) CallBtnBlock callBlock;

@end
