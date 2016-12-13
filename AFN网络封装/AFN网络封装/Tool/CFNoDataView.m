//
//  CFNoDataView.m
//  AFN网络封装
//
//  Created by chaofan on 2016/12/13.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import "CFNoDataView.h"

@interface CFNoDataView ()

@end

@implementation CFNoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    self.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadBtn setImage:[UIImage imageNamed:@"sure_placeholder_error"] forState:UIControlStateNormal];
//    [reloadBtn addTarget:self action:@selector(reloadClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reloadBtn];
    self.reloadBtn = reloadBtn;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.reloadBtn.frame = [UIScreen mainScreen].bounds;
}

@end
