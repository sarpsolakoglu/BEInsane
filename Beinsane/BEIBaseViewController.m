//
//  BEIBaseViewController.m
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import "BEIBaseViewController.h"

@interface BEIBaseViewController ()

@end

@implementation BEIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Make the same gradient color for all UIViewControllers
    //SARI. KIRMIZI. EN BÜYÜK. CİMBOM.
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor], (id)[[UIColor yellowColor] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
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
