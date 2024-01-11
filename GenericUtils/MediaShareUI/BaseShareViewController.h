//
//  BaseShareViewController.h
//  MediaShareController
//
//  Created by Tuhin Kumer on 12/14/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MediaExportProtocol;
@protocol SaveProtocol;
@protocol ActionComponentProtocol;

@interface BaseShareViewController : UIViewController

@property (nonatomic, strong) id<MediaExportProtocol> exporter;
@property (nonatomic, strong) id<SaveProtocol> save;
@property (nonatomic, strong) id<ActionComponentProtocol> facebook;
@property (nonatomic, strong) id<ActionComponentProtocol> instagram;
@property (nonatomic, strong) id<ActionComponentProtocol> twitter;
@property (nonatomic, strong) id<ActionComponentProtocol> contactus;
@property (nonatomic, strong) id<ActionComponentProtocol> moreapps;
@property (nonatomic, strong) id<ActionComponentProtocol> rateus;
@property (nonatomic, strong) id<ActionComponentProtocol> email;

+ (instancetype)shareViewController;
+ (instancetype)shareViewControllerFrom:(UIStoryboard *)storyboard usingIdentifier:(NSString*)identifier;


@end
