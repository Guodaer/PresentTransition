//
//  PresentViewController.m
//  PresentTransition
//
//  Created by X-Designer on 16/11/9.
//  Copyright © 2016年 Guoda. All rights reserved.
//

#import "PresentViewController.h"
#import "PresentTransition.h"
@interface PresentViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;


@end

@implementation PresentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.presentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, (self.view.frame.size.width*33)/44)];
    [self.view addSubview:self.presentImgView];
    self.presentImgView.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.presentImgView addGestureRecognizer:tap];
    
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;

    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    edgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePan];
    

}
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer*)edgePan {
    
    float progress = [edgePan translationInView:self.view].x/self.view.frame.size.width;
    progress = MIN(1.0, MAX(0.0, progress));
    
    
    if (edgePan.state == UIGestureRecognizerStateBegan) {

        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (edgePan.state == UIGestureRecognizerStateChanged){
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if (edgePan.state == UIGestureRecognizerStateCancelled||edgePan.state == UIGestureRecognizerStateEnded){
//        if (progress > 0.3) {
            [self.percentDrivenTransition finishInteractiveTransition];
//        }else{
//            [self.percentDrivenTransition cancelInteractiveTransition];
//        }
        self.percentDrivenTransition = nil;
    }
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if ([animationController isKindOfClass:[PresentTransition class]]) {
        return self.percentDrivenTransition;
    }
    return nil;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return [[PresentTransition ShareInstance] initWithTransitionType:GDPresentOntTransitonTypePop];
    }else {
        return [[PresentTransition ShareInstance] initWithTransitionType:GDPresentOntTransitonTypePush];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
//#pragma mark - UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    BOOL isShow = [viewController isKindOfClass:[self class]];
//    [self.navigationController setNavigationBarHidden:isShow animated:YES];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
