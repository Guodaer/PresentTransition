//
//  PresentTransition.h
//  PresentTransition
//
//  Created by X-Designer on 16/11/9.
//  Copyright © 2016年 Guoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GDPresentOntTransitonType) {
    GDPresentOntTransitonTypePush = 0,
    GDPresentOntTransitonTypePop
};

@interface PresentTransition : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

+ (instancetype)ShareInstance;

- (instancetype)initWithTransitionType:(GDPresentOntTransitonType)type;

@end
