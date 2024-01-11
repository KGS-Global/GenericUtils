//
//  VideoExporter.h
//  MediaShareController
//
//  Created by Towhidul Islam on 12/13/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaExportProtocol.h"

@class VideoExportModel;

@interface VideoExporter : NSObject <MediaExportProtocol>
- (instancetype)initWithMedia:(VideoExportModel*)model;
@end
