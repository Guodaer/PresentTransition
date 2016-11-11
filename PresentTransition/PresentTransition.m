//
//  PresentTransition.m
//  PresentTransition
//
//  Created by X-Designer on 16/11/9.
//  Copyright © 2016年 Guoda. All rights reserved.
//

#import "PresentTransition.h"
#import "RootViewController.h"
#import "PresentViewController.h"
@interface PresentTransition ()
{
    GDPresentOntTransitonType _type;
}

@end


@implementation PresentTransition

+ (instancetype)ShareInstance {
    
    static id _shareInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shareInstance = [[self alloc] init];
    });
    return _shareInstance;
}
- (instancetype)initWithTransitionType:(GDPresentOntTransitonType)type{
    _type = type;
    return self;
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case GDPresentOntTransitonTypePush:
            [self presentAnimation:transitionContext];
            break;
        case GDPresentOntTransitonTypePop:
            [self dismissAnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
#if 1
    PresentViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    RootViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempView = [fromVC.rootImageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [containerView convertRect:fromVC.rootImageView.frame toView:fromVC.view];
    fromVC.rootImageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;

    
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    [toVC.presentImgView layoutIfNeeded];
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        tempView.frame = toVC.presentImgView.frame;
        toVC.view.alpha = 1;
        [toVC.navigationController setNavigationBarHidden:YES animated:YES];

    } completion:^(BOOL finished) {
   
        fromVC.rootImageView.hidden = NO;
        toVC.presentImgView.image = fromVC.rootImageView.image;
        [tempView removeFromSuperview];
        
        //一定要记得动画完成后执行此方法，让系统管理 navigation
        [transitionContext completeTransition:YES];
        
    }];
#endif
#if 0
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 可以看做为来自那一页
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 添加toView到容器上
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0.0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        // 动画效果有很多,这里就展示个左偏移
        fromViewController.view.transform = CGAffineTransformMakeTranslation(-320, 0);
        toViewController.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        // 别忘了在过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
#endif
    
}
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContex{
    
    PresentViewController *fromVC = [transitionContex viewControllerForKey:UITransitionContextFromViewControllerKey];
    RootViewController *toVC = [transitionContex viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContex containerView];
    
    UIView *snapshotView = [fromVC.presentImgView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = [containerView convertRect:fromVC.presentImgView.frame toView:fromVC.view];
    fromVC.presentImgView.hidden = YES;
    
    toVC.view.frame = [transitionContex finalFrameForViewController:toVC];
    toVC.rootImageView.hidden = YES;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapshotView];
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContex] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        snapshotView.frame = [containerView convertRect:toVC.rootImageView.frame toView:toVC.view];
        fromVC.view.alpha = 0;
        [toVC.navigationController setNavigationBarHidden:NO animated:YES];
        
    } completion:^(BOOL finished) {
        
        toVC.rootImageView.hidden = NO;
        [snapshotView removeFromSuperview];
        fromVC.presentImgView.hidden = NO;
        [transitionContex completeTransition:YES];

        
    }];
    
    
    
}


@end
