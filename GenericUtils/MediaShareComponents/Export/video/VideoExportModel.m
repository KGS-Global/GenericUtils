//
//  VideoExportModel.m
//  MediaShareController
//
//  Created by Towhidul Islam on 12/13/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "VideoExportModel.h"
#import <AVFoundation/AVFoundation.h>

@implementation VideoExportModel

- (instancetype)init{
    if (self = [super init]) {
        self.exportQuality = PresetHighest;
        self.outputFileType = AVFileTypeMPEG4;
        self.shouldOptimizeForNetworkUse = YES;
    }
    return self;
}

- (NSString *)videoExportQuality{
    NSString *preset = AVAssetExportPresetHighestQuality;
    switch (self.exportQuality) {
        case PresetLow:
            preset = AVAssetExportPresetLowQuality;
            break;
        case PresetMedium:
            preset = AVAssetExportPresetMediumQuality;
            break;
        case Preset640x480:
            preset = AVAssetExportPreset640x480;
            break;
        case Preset960x540:
            preset = AVAssetExportPreset960x540;
            break;
        case Preset1280x720:
            preset = AVAssetExportPreset1280x720;
            break;
        default:
            preset = AVAssetExportPresetHighestQuality;
            break;
    }
    return preset;
}

@end
