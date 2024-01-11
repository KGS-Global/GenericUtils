//
//  ImageExporter.h
//  MediaShareController
//
//  Created by Towhidul Islam on 12/14/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaExportProtocol.h"

@class ImageExportModel;

@interface ImageExporter : NSObject <MediaExportProtocol>
- (instancetype)initWithMedia:(ImageExportModel*)model;
@end
