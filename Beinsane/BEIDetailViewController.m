//
//  BEIDetailViewController.m
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import "BEIDetailViewController.h"
#import "BEIClient.h"
#import "BEIResponse.h"
#import "DetailCell.h"
#import "BEIWebViewController.h"

@interface BEIDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BEIResponseCustomQuery *queryResult;
@property (strong, nonatomic) NSMutableDictionary *photoCache;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation BEIDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _searchedText;
    self.navigationController.navigationBarHidden = NO;
    self.photoCache = [NSMutableDictionary dictionary];
    
    [BEIClient performQueryCall:_searchedText completionHandler:^(BEIResponse *response, NSError *error) {
        if (error) {
            [self performSelectorOnMainThread:@selector(handleError) withObject:nil waitUntilDone:NO];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.queryResult = (BEIResponseCustomQuery*)response;
                [_activityIndicator stopAnimating];
            });
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.photoCache = [NSMutableDictionary dictionary];
    self.queryResult = nil;
}

#pragma mark - setter

- (void) setQueryResult:(BEIResponseCustomQuery *)queryResult {
    _queryResult = queryResult;
    [_tableView reloadData];
}

#pragma mark - tableview data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _queryResult.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
    
    BEICustomQueryNode *response = _queryResult.items[indexPath.row];
    
    if (_photoCache[[NSNumber numberWithInteger:indexPath.row]]) {
        cell.cImageView.image = _photoCache[[NSNumber numberWithInteger:indexPath.row]];
    } else {
        cell.cImageView.image = [UIImage imageNamed:@"icn_noimage"];
        const NSNumber *key = [NSNumber numberWithInteger:indexPath.row];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:response.src]];
            if (data) {
                UIImage *downloadedImage = [UIImage imageWithData:data];
                if (downloadedImage) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_photoCache setObject:downloadedImage forKey:key];
                        cell.cImageView.image = downloadedImage;
                    });
                }
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    }
    cell.backgroundColor = [self bgColorForIndex:indexPath];
    cell.subtitleLabel.textColor = [self txtColorForIndex:indexPath];
    [cell configureCell:response];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BEICustomQueryNode *node = _queryResult.items[indexPath.row];
    
    const CGFloat topMargin = 40.0f;
    const CGFloat bottomMargin = 40.0f;
    const CGFloat minHeight = 120.0f;
    
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat width = bounds.size.width - 120.0f;
    
    CGRect boundingBoxBody = [node.title boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil];
    CGRect boundingBoxHeader = [node.snippet boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil];
    
    return MAX(minHeight, boundingBoxBody.size.height + boundingBoxHeader.size.height + topMargin + bottomMargin);
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"openWebViewSegue" sender:self];
}

- (void) handleError {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error occured" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - helper

- (UIColor*) bgColorForIndex: (NSIndexPath*)index{
    int itemCount = (int)_queryResult.items.count/2;
    CGFloat value = (CGFloat)index.row/(CGFloat)itemCount*0.6;
    return [UIColor colorWithRed:1.0 green:value blue:0.0 alpha:1.0];
}

-(UIColor*) txtColorForIndex: (NSIndexPath*)index{
    int itemCount = (int)_queryResult.items.count/2;
    CGFloat value = (CGFloat)itemCount*0.6/((CGFloat)index.row+1);
    return [UIColor colorWithRed:value green:value blue:value alpha:1.0];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"openWebViewSegue"]) {
        NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
        BEICustomQueryNode *node = _queryResult.items[indexPath.row];
        BEIWebViewController *controller = (BEIWebViewController*)segue.destinationViewController;
        controller.urlString = node.link;
        controller.title = node.title;
    }
}


@end
