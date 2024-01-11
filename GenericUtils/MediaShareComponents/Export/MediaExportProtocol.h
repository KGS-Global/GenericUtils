//
//  MediaExportProtocol.h
//  MediaShareController
//
//  Created by Towhidul Islam on 12/13/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ExportProgress)(float);
typedef void(^ExportCompletion)(BOOL, id);

@protocol MediaExportProtocol <NSObject>

@required
- (void) exportMedia:(ExportProgress)progress onCompletion:(ExportCompletion)block;
- (void) cancelExport;
@optional

@end
