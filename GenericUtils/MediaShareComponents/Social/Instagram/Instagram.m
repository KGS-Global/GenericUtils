//
//  Instagram.m
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "Instagram.h"
#import <UIKit/UIKit.h>
#define URL_INSTAGRAM @"instagram://library?AssetPath=%@&InstagramCaption=%@"

@interface Instagram ()
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, weak) UIViewController *presentingViewController;
@property (nonatomic, strong) NSURL *instaUrl;
@end

@implementation Instagram

- (instancetype)init{
    return [self initWithSourceUrl:nil andMessage:nil];
}

- (instancetype)initWithSourceUrl:(NSURL *)url andMessage : (NSString*) message{
    if (self = [super init]) {
        self.message = message;
        self.url = url;
    }
    return self;
}

- (NSURL*) instagramUrl{
    if (self.instaUrl == nil) {
        NSString *message = [self urlEncodedString:self.message];
        NSString *url = [self urlEncodedString:self.url.absoluteString];
        self.instaUrl = [NSURL URLWithString: [NSString stringWithFormat:@"instagram://library?AssetPath=%@&InstagramCaption=%@", url, message]];
    }
    return self.instaUrl;
}

- (BOOL)isComponentEnabled{
    if (self.url != nil) {
        return [[UIApplication sharedApplication] canOpenURL:[self instagramUrl]];
    }
    return false;
}

- (void)addUrl:(NSURL *)url{
    self.url = url;
}

- (void)addInitialText:(NSString *)text{
    self.message = text;
}

- (void)presentOn:(UIViewController *)viewController onCompletion:(ActionCompletion)block{
    self.presentingViewController = viewController;
    [[UIApplication sharedApplication] openURL:[self instagramUrl]];
}

-(NSString*) urlEncodedString: (NSString *) inputString {
    return [inputString stringByAddingPercentEncodingWithAllowedCharacters : [NSCharacterSet alphanumericCharacterSet]];
}

@end
