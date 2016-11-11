//
//  RootViewController.m
//  PresentTransition
//
//  Created by X-Designer on 16/11/9.
//  Copyright © 2016年 Guoda. All rights reserved.
//

#import "RootViewController.h"
#import "PresentViewController.h"
#import "PresentTransition.h"
@interface RootViewController ()<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>
{
    BOOL isShowNavigation;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
        
    //440:330
    self.rootImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 220, 165)];
    self.rootImageView.image = [UIImage imageNamed:@"youknow.jpg"];
    [self.view addSubview:self.rootImageView];
    self.rootImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.rootImageView addGestureRecognizer:tap];

}
- (void)tap:(UITapGestureRecognizer*)tap {
    PresentViewController *present = [[PresentViewController alloc] init];
    present.transitioningDelegate = self;
    present.modalPresentationStyle = UIModalPresentationCustom;
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:present animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return [[PresentTransition ShareInstance]initWithTransitionType:GDPresentOntTransitonTypePush];
    }else{
        return nil;
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
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
