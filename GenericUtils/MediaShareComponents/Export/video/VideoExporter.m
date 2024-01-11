//
//  VideoExporter.m
//  MediaShareController
//
//  Created by Towhidul Islam on 12/13/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "VideoExporter.h"
#import "VideoExportModel.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoExporter ()
@property (nonatomic, strong) AVAssetExportSession *exportSession;
@property (nonatomic, strong) VideoExportModel *videoModel;
@property (nonatomic, strong) ExportCompletion onCompletion;
@property (nonatomic, strong) ExportProgress progressHandler;
@property (nonatomic, strong) NSTimer *progressTimer;
@end

@implementation VideoExporter

- (void)dealloc{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (instancetype)init{
    return [self initWithMedia:nil];
}

- (instancetype)initWithMedia:(VideoExportModel *)model{
    if (self = [super init]) {
        self.videoModel = (model == nil) ? [VideoExportModel new] : model;
        self.exportSession = [[AVAssetExportSession alloc] initWithAsset:self.videoModel.composition presetName:self.videoModel.videoExportQuality];
    }
    return self;
}

- (void)exportMedia:(ExportProgress)progress onCompletion:(ExportCompletion)block{
    self.onCompletion = block;
    self.progressHandler = progress;
    self.exportSession.videoComposition  = self.videoModel.videoComposition;
    self.exportSession.audioMix          = self.videoModel.audioMix;
    self.exportSession.outputURL         = self.videoModel.outputURL;
    self.exportSession.outputFileType    = self.videoModel.outputFileType;
    self.exportSession.timeRange = (self.videoModel.compositionInstruction != nil) ? self.videoModel.compositionInstruction.timeRange : CMTimeRangeMake(kCMTimeZero, self.exportSession.asset.duration);
    self.exportSession.shouldOptimizeForNetworkUse = self.videoModel.shouldOptimizeForNetworkUse;
    [self removeOutputFileIfExist:self.videoModel.outputURL];
    __weak VideoExporter *weakSelf = self;
    [self.exportSession exportAsynchronouslyWithCompletionHandler:^{
        if (weakSelf.exportSession.status != AVAssetExportSessionStatusCompleted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.exportSession.status != AVAssetExportSessionStatusExporting) {
                    [weakSelf.progressTimer invalidate];
                }
                if (weakSelf.onCompletion != nil) {
                    weakSelf.onCompletion(NO, nil);
                }
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.progressTimer invalidate];
                if (weakSelf.onCompletion != nil) {
                    weakSelf.onCompletion(YES, weakSelf.exportSession.outputURL);
                }
            });
        }
    }];
    
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSDefaultRunLoopMode];
}

- (void)cancelExport{
    [self.exportSession cancelExport];
}

- (void) update:(NSTimer*)timer{
    if (self.progressHandler != nil) {
        if (self.exportSession.status == AVAssetExportSessionStatusExporting){
            self.progressHandler(self.exportSession.progress);
        }
    }
}

- (void) removeOutputFileIfExist:(NSURL*)fileUrl{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[fileUrl path]]) {
        if ([[NSFileManager defaultManager] removeItemAtURL:fileUrl error:nil]) {
            NSLog(@"Old File Removed.");
        }
    }
}

@end
