//
//  KGSInternetConnection.h
//  Typography
//
//  Created by KITE GAMES STUDIO on 11/23/16.
//  Copyright © 2016 KITE GAMES STUDIO LTD. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface KGSInternetConnection : UIView

typedef NS_ENUM(NSInteger, KGSICPresentation) {
    
    KGSIC_TopToBottom,
    KGSIC_BottomToTop,
    KGSIC_LeftToRight,
    KGSIC_RightToLeft
};

typedef enum : NSInteger {
    KGSIC_MSG_Warning,
    KGSIC_MSG_Error,
    KGSIC_MSG_Success,
    KGSIC_MSG_Custom,
    KGSIC_MSG_None
    
} KGSICMessageType;

+(instancetype) sharedInstance;

@property (assign, nonatomic) KGSICPresentation parentationType;

@property (assign, nonatomic) KGSICMessageType messageType;

@property (assign, nonatomic) NSString *strMessage;

@property (assign, nonatomic) NSString *strNoInternetMessage;

@property (assign, nonatomic) BOOL boolShouldShowAlertImage;

@property (strong, nonatomic) UIColor *colorBackground;

@property (strong, nonatomic) UIViewController *parentViewController;

@property (assign, nonatomic) BOOL isNotchDevice;

@property (strong, nonatomic) IBOutlet UIView *viewMsgContainer;

@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewAlert;

//Public Methods
//
- (void) initialSettingForNotchDeive:(BOOL)isNotchDevice;

- (BOOL) isInternetConnected;

- (void) showNoInternetAlert;

- (BOOL) checkInternetConnectionWithNoInternetAlert:(BOOL) boolShowAlert;

- (BOOL) checkInternetConnectionWithNoInternetAlertMessage:(NSString *) strMessage;

- (void) showAlertMessage:(NSString *)strMessage withAlertImage:(UIImage *) img ;

- (void) showAlertMessage:(NSString *)strMessage ofType:(KGSICMessageType) messageType __attribute__((deprecated("This method is deprecated, use 'showAlertWithMessage:' instead")));

-(void) showAlertWithMessage:(NSString *)strMessage ofType:(KGSICMessageType) messageType withBackgroundColor:( UIColor* _Nullable) backgroundColor withTextColor: (UIColor* _Nullable) textColor;

-(void) setBackgroundColor:(UIColor *)backgroundColor __attribute__((deprecated("This method is deprecated, use 'showAlertWithMessage:' instead")));

-(void) setMessageTextColor:(UIColor *)backgroundColor __attribute__((deprecated("This method is deprecated, use 'showAlertWithMessage:' instead")));

-(void) setBackgroundColor:(UIColor *)backgroundColor  andMessageTextColor:(UIColor *)msgColor __attribute__((deprecated("This method is deprecated, use 'showAlertWithMessage:' instead")));
@end
