//
//  AppDelegate.m
//  RSSReader
//
//  Created by Kenji TAMAKI on 1/7/16.
//  Copyright (c) 2016 Brother Industries, Ltd. All rights reserved.
//

#import "AppDelegate.h"

static NSString * const yahooRssURL = @"http://rss.dailynews.yahoo.co.jp/fc/rss.xml";
static NSString * const googleFeedApiURLFormat = @"http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=%@&num=%@";

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow * window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:googleFeedApiURLFormat, yahooRssURL, @"3"]];
    
    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary * responseData = dict[@"responseData"];
        NSDictionary * feed = responseData[@"feed"];
        NSArray * entries = feed[@"entries"];
        
        NSLog(@"%@", entries);
        for (NSDictionary * entry in entries) {
            NSLog(@"title: %@", entry[@"title"]);
        }
    }];
    [task resume];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    
}

@end
