//
//  ActionComponentProtocol.h
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ActionCompletion)(BOOL);

@protocol ActionComponentProtocol <NSObject>

@required
- (BOOL) isComponentEnabled;
- (void) presentOn:(UIViewController*)viewController onCompletion:(ActionCompletion)block;
@optional

@end
