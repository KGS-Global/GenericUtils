//
//  Facebook.m
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "KGSFacebook.h"

@interface KGSFacebook ()
@property (nonatomic, strong) SLComposeViewController *composser;
@property (nonatomic, strong) ActionCompletion onCompletion;
@end

@implementation KGSFacebook
@synthesize composser = _composser;


- (SLComposeViewController *)composser{
    if (_composser == nil) {
        _composser = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        __weak KGSFacebook *weakSelf = self;
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
    return [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook];
}

- (void)presentOn:(UIViewController *)viewController onCompletion:(ActionCompletion)block{
    self.onCompletion = block;
    [super presentOn:viewController onCompletion:block];
}

@end
