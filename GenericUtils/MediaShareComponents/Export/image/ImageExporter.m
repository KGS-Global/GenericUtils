//
//  ImageExporter.m
//  MediaShareController
//
//  Created by Towhidul Islam on 12/14/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "ImageExporter.h"
#import "ImageExportModel.h"

@interface ImageExporter ()
@property (nonatomic, strong) ImageExportModel *imageModel;
//@property (nonatomic, strong) ExportCompletion onCompletion;
//@property (nonatomic, strong) ExportProgress progressHandler;
@property (nonatomic, strong) NSTimer *progressTimer;
@end

@implementation ImageExporter

- (instancetype)init{
    return [self initWithMedia:nil];
}

- (instancetype)initWithMedia:(ImageExportModel *)model{
    if (self = [super init]) {
        self.imageModel = (model == nil) ? [ImageExportModel new] : model;
    }
    return self;
}

- (void)exportMedia:(ExportProgress)progress onCompletion:(ExportCompletion)block{
    //self.onCompletion = block;
    //self.progressHandler = progress;
    if (self.imageModel.view != nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UIGraphicsBeginImageContextWithOptions(self.imageModel.view.bounds.size, self.imageModel.view.opaque, 1.0);
            [self.imageModel.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            if (block != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(YES, screenshot);
                });
            }
        });
    }
}

- (void)cancelExport{
    //TODO
}

@end
