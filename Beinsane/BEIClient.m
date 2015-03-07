//
//  BEIClient.m
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import "BEIClient.h"
#import "BEIResponse.h"

static NSString* const kBaseURLString = @"https://www.googleapis.com/customsearch/v1";
static NSString* const kCustomSearchID = @"000981168314439699038:zb3h5zte298";
static NSString* const kAPIKey = @"AIzaSyBjD8zDuS5BnzD813ZnohSrvuuLvtmiIeQ";
static NSString* const kRequestFields = @"items(title,link,snippet,pagemap(cse_image))";

#define CALL_ERROR [NSError errorWithDomain:@"com.sarpsolakoglu.BeinsaneErrorDomain" code:1000 userInfo:@{}]

@interface BEIClient()
@property (nonatomic,strong) NSURLSession *session;
@end

@implementation BEIClient

+ (BEIClient*) sharedClient {
    static BEIClient *sharedClient;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        sharedClient = [[BEIClient alloc]init];
    });
    return sharedClient;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.HTTPMaximumConnectionsPerHost = 1;
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

#pragma mark - call

+ (void) performQueryCall:(NSString*)query completionHandler:(BEIClientCompletionHandler)handler {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self constructCallURL:query]];
    [request setHTTPMethod:@"GET"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[[BEIClient sharedClient].session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                if (jsonError) {
                    handler(nil,jsonError);
                } else {
                    BEIResponseCustomQuery *customResponse = [BEIResponseCustomQuery createWithJson:json];
                    handler(customResponse,nil);
                }
            } else {
                handler(nil,CALL_ERROR);
            }
        } else {
            handler(nil,error);
        }
    }] resume];
}

#pragma mark - helper
+ (NSURL*) constructCallURL:(NSString*)query {
    NSString *urlString = [NSString stringWithFormat:@"%@?key=%@&cx=%@&q=%@&fields=%@",kBaseURLString,kAPIKey,kCustomSearchID,query,kRequestFields];
    return [NSURL URLWithString:urlString];
}


@end
