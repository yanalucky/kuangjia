//
//  UA_Default_UI.h
//  demo
//
//  Created by perfayMini on 2018/11/23.
//  Copyright © 2018 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UA_Default_UI : UIControl

@property (nonatomic,copy)void(^reloadBlock)(void);//点击重新加载的control
@property (nonatomic,copy) NSString *titleString,*imageString;

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
