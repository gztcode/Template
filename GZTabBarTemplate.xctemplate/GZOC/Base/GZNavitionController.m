//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"

@interface ___FILEBASENAME___ ()<UINavigationControllerDelegate>


@end

@implementation ___FILEBASENAME___

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    __weak typeof (self)weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //        self.interactivePopGestureRecognizer.enabled = YES;
        /* UIGestureRecognizerDelegate */
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (void)initialize {
    // 1.appearance方法返回一个导航栏的外观对象
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = MAIN_COLOR;
    
    // 3.设置导航栏文字的主题
    NSShadow *shadow = [[NSShadow alloc]init];
    [shadow setShadowOffset:CGSizeZero];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                            NSShadowAttributeName : shadow}];
    //    [navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_cell_bg_selected"] forBarMetrics:UIBarMetricsDefault];
    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    [barButtonItem setTintColor:[UIColor whiteColor]];
    //修改返回按钮样式
    //    [barButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
    
    
}

//重写返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >1) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}
-(UIBarButtonItem *)creatBackButton
{
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cart"] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    
    
}
-(void)popSelf
{
    [self popViewControllerAnimated:YES];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
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
