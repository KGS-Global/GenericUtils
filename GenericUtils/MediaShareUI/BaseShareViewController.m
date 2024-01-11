//
//  BaseShareViewController.m
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/14/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "BaseShareViewController.h"
#import "MediaShareComponents.h"

@interface BaseShareViewController ()

@end

@implementation BaseShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.save = [[ALAssetLibrarySave alloc] init];
    self.facebook = [[KGSFacebook alloc] init];
    self.instagram = [[Instagram alloc] init];
    self.twitter = [[KGSTwitter alloc] init];
    self.moreapps = [[MoreApps alloc] init];
    self.contactus = [[ContactUs alloc] init];
    self.email = [[EmailShare alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)shareViewController{
    BaseShareViewController *controller = [BaseShareViewController new];
    return controller;
}

+ (instancetype)shareViewControllerFrom:(UIStoryboard *)storyboard usingIdentifier:(NSString*)identifier{
    
    if (identifier == nil) {
        identifier = NSStringFromClass([BaseShareViewController class]);
    }
    
    BaseShareViewController *controller = [storyboard instantiateViewControllerWithIdentifier:identifier];
    
    return controller;
}

@end
