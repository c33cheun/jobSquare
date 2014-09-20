//
//  JSBaseViewController.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JSBaseViewController.h"

@interface JSBaseViewController ()

@end

@implementation JSBaseViewController

- (void)loadView {
    [super loadView];
    
    JSMapViewController *map = [[JSMapViewController alloc]
                                         initWithNibName:@"FirstViewController" bundle:nil];
    UIViewController *accountViewController = [[UIViewController alloc]
                                         initWithNibName:@"SecondViewController" bundle:nil];
    self.viewControllers = @[map,accountViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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
