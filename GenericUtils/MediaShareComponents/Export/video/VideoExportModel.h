//
//  VideoExportModel.h
//  MediaShareController
//
//  Created by Towhidul Islam on 12/13/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "MediaExportModel.h"
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM (NSInteger, VideoExportQuality){
    PresetLow,
    PresetMedium,
    PresetHighest,
    Preset640x480,
    Preset960x540,
    Preset1280x720,
    PresetAppleM4A
};

@interface VideoExportModel : MediaExportModel

@property (nonatomic, strong) AVMutableComposition 				*composition;
@property (nonatomic, strong) AVMutableVideoComposition 		*videoComposition;
@property (nonatomic, strong) AVMutableVideoComposition 		*avVidCompositionPlayable;
@property (nonatomic, strong) AVMutableVideoCompositionInstruction	*compositionInstruction;

@property (nonatomic, assign) VideoExportQuality 				exportQuality;
@property (nonatomic, strong) AVAudioMix 						*audioMix;
@property (nonatomic, copy) NSString 							*outputFileType;
@property (nonatomic, assign) CMTimeRange 						timeRange;
@property (nonatomic, assign) BOOL 								shouldOptimizeForNetworkUse;

- (NSString*) videoExportQuality;

@end
