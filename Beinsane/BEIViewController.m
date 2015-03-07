//
//  ViewController.m
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import "BEIViewController.h"
#import "BEIQueryManager.h"
#import "BEIUtils.h"
#import "BEIResponse.h"
#import "BEIDetailViewController.h"

@interface BEIViewController()
@property (nonatomic,strong) NSArray *searchResult;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blurViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *blurView;
@property (weak, nonatomic) IBOutlet UIView *helperView;

@end

@implementation BEIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchField.keyboardAppearance = UIKeyboardAppearanceDark;
    _searchField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: [UIColor yellowColor]}];
    _blurViewTopConstraint.constant = (self.view.bounds.size.height) - (_blurView.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.searchResult = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    [super viewWillDisappear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
    self.searchResult = nil;
    _searchField.text = @"";
    [self.view layoutIfNeeded];
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}

#pragma mark - setter

- (void)setSearchResult:(NSArray *)searchResult {
    _searchResult = searchResult;
    [_tableView reloadData];
}

#pragma mark - textfield

- (IBAction)textFieldEdit:(id)sender {
    [BEIQueryManager queryWithString:_searchField.text block:^(NSArray *results) {
        self.searchResult = results;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - tableview data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
    
    NSString *result = _searchResult[indexPath.row];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:result];
    NSString *searchTerm = _searchField.text;
    NSRange boldRange = [result rangeOfString:searchTerm];
    [attributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:boldRange];
    [cell.textLabel setAttributedText: attributedString];
    return cell;
}

#pragma mark - tableview delegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor whiteColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.textLabel.textColor = [UIColor blackColor];
    });
   
    [self performSegueWithIdentifier:@"openResultSegue" sender:self];
}


#pragma mark - keyboard

- (void)registerForKeyboardNotifications {
    
    
    // Register notification when the keyboard will show
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    // Register notification when the keyboard will hide
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGSize keyboardSize = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
  
    [_helperView removeFromSuperview];
    
    [_blurViewTopConstraint setConstant:0];
    [_tableViewBottomConstraint setConstant:keyboardSize.height];
    
    [UIView animateWithDuration:duration animations:^{
        
        [UIView setAnimationCurve:curve];
        [self.view layoutIfNeeded];
        
    } completion:NULL];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [_tableViewBottomConstraint setConstant:0];
    
    [UIView animateWithDuration:duration animations:^{
            
        [UIView setAnimationCurve:curve];
        [self.view layoutIfNeeded];
        
    } completion:NULL];
}

#pragma mark - navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"openResultSegue"]) {
        BEIDetailViewController *controller = (BEIDetailViewController*)segue.destinationViewController;
        NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
        controller.searchedText = _searchResult[indexPath.row];
    }
}


@end
