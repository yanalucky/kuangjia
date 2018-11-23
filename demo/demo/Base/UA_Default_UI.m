//
//  UA_Default_UI.m
//  demo
//
//  Created by perfayMini on 2018/11/23.
//  Copyright © 2018 huawei. All rights reserved.
//

#import "UA_Default_UI.h"

@interface UA_Default_UI()
@property (nonatomic,strong) UIImageView *notConnectImageView;
@property (nonatomic,strong) UILabel     *notConnectLabel;
@end

@implementation UA_Default_UI

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
        [self setupUI];
    }
    return self;
}

- (void)reload
{
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self addSubview:self.notConnectImageView];
    [self addSubview:self.notConnectLabel];
    [self.notConnectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_offset(kAutoWidth6(100));
        make.height.width.mas_offset(kAutoWidth6(120));
    }];
    [self.notConnectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.notConnectImageView.mas_bottom).mas_offset(kAutoWidth6(40));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
}

- (UIImageView *)notConnectImageView
{
    if (!_notConnectImageView) {
        _notConnectImageView = [[UIImageView alloc]init];
        
    }
    return _notConnectImageView;
}

- (UILabel *)notConnectLabel
{
    if (!_notConnectLabel) {
        _notConnectLabel = [[UILabel alloc]init];
        _notConnectLabel.font = [UIFont systemFontOfSize:14];
        _notConnectLabel.textColor = UIFontSortGrayColor;
        _notConnectLabel.textAlignment = NSTextAlignmentCenter;
        _notConnectLabel.numberOfLines = 2;
    }
    return _notConnectLabel;
}

- (void)setImageString:(NSString *)imageString
{
    _imageString = imageString;
    self.notConnectImageView.image = [UIImage imageNamed:imageString];
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.notConnectLabel.text = titleString;
}


@end
