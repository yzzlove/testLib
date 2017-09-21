//
//  UIButton+YXEvent.m
//  YzzBaseLib
//
//  Created by yaozhengzheng on 2017/9/19.
//  Copyright © 2017年 yaozhengzheng. All rights reserved.
//

#import "UIButton+YXEvent.h"
#import <objc/runtime.h>
@interface UIButton ()
@property (nonatomic, assign) NSTimeInterval temp_timeInterval;
@end

@implementation UIButton (YXEvent)

+ (void)load {
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method SGMethod = class_getInstanceMethod(self, @selector(YX_sendAction:to:forEvent:));
    SEL SGSEL = @selector(YX_sendAction:to:forEvent:);
    
    BOOL addMethod = class_addMethod(self, SGSEL, method_getImplementation(SGMethod), method_getTypeEncoding(SGMethod));
    if (addMethod) {
        class_replaceMethod(self, sysSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    } else {
        method_exchangeImplementations(systemMethod, SGMethod);
    }
}

- (void)YX_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.temp_timeInterval >= self.YX_timeInterval);
    
    if (self.YX_timeInterval > 0) {
        self.temp_timeInterval = NSDate.date.timeIntervalSince1970;
    }
    
    if (needSendAction) {
        [self YX_sendAction:action to:target forEvent:event];
    }
}

#pragma mark - - - set、get
- (void)setYX_timeInterval:(NSTimeInterval)YX_timeInterval {
    objc_setAssociatedObject(self, "UIButton_YX_timeInterval", @(YX_timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)YX_timeInterval {
    return [objc_getAssociatedObject(self, "UIButton_YX_timeInterval") doubleValue];
}

- (void)setTemp_timeInterval:(NSTimeInterval)temp_timeInterval {
    objc_setAssociatedObject(self, "UIButton_temp_timeInterval", @(temp_timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)temp_timeInterval {
    return [objc_getAssociatedObject(self, "UIButton_temp_timeInterval") doubleValue];
}


@end
