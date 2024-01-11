//
//  BaseSocial.m
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "BaseSocial.h"

@interface BaseSocial ()
@property (nonatomic, strong) SLComposeViewController *composser;
@end

@implementation BaseSocial

- (void)presentOn:(UIViewController *)viewController onCompletion:(ActionCompletion)block{
    self.presentingViewController = viewController;
    self.composser.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.presentingViewController presentViewController:self.composser animated:YES completion:nil];
}

- (BOOL)isComponentEnabled{
    return false;
}

- (void)addUrl:(NSURL *)url{
    [self.composser addURL:url];
}

- (void)addImage:(UIImage *)image{
    [self.composser addImage:image];
}

- (void)addInitialText:(NSString *)text{
    [self.composser setInitialText:text];
}

@end
