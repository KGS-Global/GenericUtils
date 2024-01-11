//
//  Twitter.m
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/12/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "KGSTwitter.h"

@interface KGSTwitter ()
@property (nonatomic, strong) SLComposeViewController *composser;
@property (nonatomic, strong) ActionCompletion onCompletion;
@end

@implementation KGSTwitter
@synthesize composser = _composser;

- (SLComposeViewController *)composser{
    if (_composser == nil) {
        _composser = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        __weak KGSTwitter *weakSelf = self;
        _composser.completionHandler = ^(SLComposeViewControllerResult result)
        {
            [weakSelf.presentingViewController dismissViewControllerAnimated:NO completion:^{
                if (weakSelf.onCompletion != nil) {
                    weakSelf.onCompletion(result == SLComposeViewControllerResultDone);
                }
            }];
        };
    }
    return _composser;
}

- (BOOL)isComponentEnabled{
    return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
}

- (void)presentOn:(UIViewController *)viewController onCompletion:(ActionCompletion)block{
    self.onCompletion = block;
    [super presentOn:viewController onCompletion:block];
}

@end
