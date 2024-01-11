//
//  MoreApps.m
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/12/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "MoreApps.h"
#import <UIKit/UIKit.h>

@interface MoreApps ()
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, assign) Class viewControllerType;
@property (nonatomic, weak) UIViewController *presenter;
@property (nonatomic, strong) ActionCompletion completion;
@end

@implementation MoreApps

- (instancetype)init{
    return [self initWithPlacementTag:@"" fallback: [UIViewController class]];
}

- (instancetype)initWithPlacementTag:(NSString*)tag fallback:(Class)viewController{
    if (self = [super init]) {
        self.tag = tag;
        self.viewControllerType = viewController;
    }
    return self;
}

- (void)presentOn:(UIViewController *)viewController onCompletion:(ActionCompletion)block{
    self.presenter = viewController;
    self.completion = block;
}

- (BOOL)isComponentEnabled{
    return YES;
}

@end
