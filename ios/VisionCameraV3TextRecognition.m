#import <MLKitTextRecognition/MLKitTextRecognition.h>
#import <MLKitTextRecognitionCommon/MLKitTextRecognitionCommon.h>
#import <VisionCamera/FrameProcessorPlugin.h>
#import <VisionCamera/FrameProcessorPluginRegistry.h>
#import "VisionCameraProxy.h"
#import <VisionCamera/Frame.h>
@import MLKitVision;
@interface VisionCameraTextRecognitionV3Plugin : FrameProcessorPlugin

@property(nonatomic, strong) MLKTextRecognizer *textRecognizer;

@end

@implementation VisionCameraTextRecognitionV3Plugin

- (instancetype)initWithProxy:(VisionCameraProxyHolder*)proxy
                   withOptions:(NSDictionary* _Nullable)options {
    self = [super initWithProxy:proxy withOptions:options];
    if (self) {
        MLKTextRecognizerOptions *options = [[MLKTextRecognizerOptions alloc] init];
        _textRecognizer = [MLKTextRecognizer textRecognizerWithOptions:options];
    }
    return self;
}

- (id _Nullable)callback:(Frame* _Nonnull)frame
           withArguments:(NSDictionary* _Nullable)arguments {
    CMSampleBufferRef buffer = frame.buffer;
    UIImageOrientation orientation = frame.orientation;
    MLKVisionImage *image = [[MLKVisionImage alloc] initWithBuffer:buffer];
    image.orientation = orientation;
    __block NSString *resultText = @"";
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_enter(dispatchGroup);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self.textRecognizer processImage:image
                                   completion:^(MLKText *_Nullable result,
                                                NSError *_Nullable error) {
            if (error || !result ) {
                NSLog(@"Text recognition error: %@", error);
                dispatch_group_leave(dispatchGroup);
                return;
            }
            
            resultText = result.text;
            dispatch_group_leave(dispatchGroup);
        }];

    });
    dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    return resultText;
}

VISION_EXPORT_FRAME_PROCESSOR(VisionCameraTextRecognitionV3Plugin, scanText)

@end
