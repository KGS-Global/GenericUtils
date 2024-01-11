//
//  BaseSocial.h
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocialComponentProtocol.h"

@interface BaseSocial : NSObject <SocialComponentProtocol>
@property (nonatomic, weak) UIViewController *presentingViewController;
@end
