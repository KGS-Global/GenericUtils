//
//  KGSInternetConnection.m
//  Typography
//
//  Created by KITE GAMES STUDIO on 11/23/16.
//  Copyright © 2016 KITE GAMES STUDIO LTD. All rights reserved.
//

#import "KGSInternetConnection.h"
#import "Reachability.h"

@implementation KGSInternetConnection
{
    
    KGSInternetConnection *icView;
    
    UIView *icViewContainer;
    
    CGRect rectLabelInitial;
    
    CGRect rectImageInitial;
    
    BOOL boolAlertAnimationEnabled;

    UIColor *savedBackgroundColor;
    UIColor *savedTextColor;
    
    NSBundle *bundleName;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(instancetype) sharedInstance {
    
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    
    
    dispatch_once(&p, ^{
        
        _sharedObject = [[KGSInternetConnection alloc] init];
    });
    
    return _sharedObject;
    
}

- (void) initialSettingForNotchDeive:(BOOL)isNotchDevice {

    savedBackgroundColor = [[UIColor alloc] initWithRed:54.0/255.0 green:73.0/255.0 blue:82.0/255.0 alpha:1.0];
    savedTextColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];

    
    self.isNotchDevice = isNotchDevice;
    
    bundleName = [NSBundle bundleForClass: [KGSInternetConnection class]];
              
    icView = [[[UINib nibWithNibName:@"KGSInternetConnection" bundle: bundleName] instantiateWithOwner:nil options:nil] firstObject];
    
    icView.strNoInternetMessage = @"No Internet Connection";
    
    icView.parentationType = KGSIC_TopToBottom;
    
    icView.messageType = KGSIC_MSG_Warning;
    
    CGFloat flActualHeight = 64;
    CGFloat flSafeAreaTop = 0;
    
    if(isNotchDevice) {
        flSafeAreaTop = 20;
    }
    
    NSLog(@"flSafeAreaTop %f", flSafeAreaTop);
    
    icViewContainer = [[UIView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, flActualHeight+flSafeAreaTop)];
    
    [icViewContainer addSubview: icView];
    
    CGRect rectICView = CGRectMake(0, flSafeAreaTop, [UIScreen mainScreen].bounds.size.width, flActualHeight);
    
    if(isNotchDevice) {
        rectICView = CGRectMake(0, icViewContainer.frame.size.height-44, [UIScreen mainScreen].bounds.size.width, 44);
    }
    
    icView.frame = rectICView;
    
    
    [self adjustMessagePosition];
    
    icView.boolShouldShowAlertImage = YES;
    
    [self setAlertFrame];
    
    [self setMessages];
    [Reachability sharedInstance];
    
}

-(void) adjustMessagePosition {
    
    if([[UIApplication sharedApplication] isStatusBarHidden] == YES) {
        
        icView.lblMessage.center = CGPointMake(icView.lblMessage.center.x, icView.lblMessage.superview.frame.size.height/2);
        
    }
    else {
        
        if(!self.isNotchDevice) {
            icView.lblMessage.center = CGPointMake(icView.lblMessage.center.x, ([UIApplication sharedApplication].statusBarFrame.size.height+icView.lblMessage.superview.frame.size.height)/2);
        }
        
    }
    
    rectLabelInitial = icView.lblMessage.frame;
    
    rectImageInitial = icView.imgViewAlert.frame;
    
}


-(void) setMessages {
    
    icView.lblMessage.text= icView.strMessage;
    
}

#pragma mark- Show Alert

-(void) showAlert {
    
    [self setAlertView];
    
    [self animateAlert];
    
}

-(void) showAlertWithMessage:(NSString *)strMessage {
    
    if(boolAlertAnimationEnabled) {
        
        NSLog(@"Alert is already showing.");
        
        return;
        
    }
       
    boolAlertAnimationEnabled = YES;
    
    icView.strMessage = strMessage;
    
    [self setMessages];
    
    [self setMessagePosition];
    
//    NSLog(@"MESSAGE %@", icView.lblMessage.text);



    [self showAlert];
    
}

-(void) showAlertWithMessage:(NSString *)strMessage ofType:(KGSICMessageType) messageType {

    icView.viewMsgContainer.backgroundColor = savedBackgroundColor;
    icViewContainer.backgroundColor = savedBackgroundColor;

    icView.lblMessage.textColor = savedTextColor;

    icView.messageType = messageType;

    [self showAlertWithMessage: strMessage];
}


-(void) showAlertWithMessage:(NSString *)strMessage ofType:(KGSICMessageType) messageType withBackgroundColor:( UIColor* _Nullable) backgroundColor withTextColor: (UIColor* _Nullable) textColor {

    if (backgroundColor == nil ) {
        icView.viewMsgContainer.backgroundColor = savedBackgroundColor;
        icViewContainer.backgroundColor = savedBackgroundColor;
    } else {
        icView.viewMsgContainer.backgroundColor = backgroundColor;
        icViewContainer.backgroundColor = backgroundColor;
    }

    if (textColor == nil) {
        icView.lblMessage.textColor = savedTextColor;
    } else {
        icView.lblMessage.textColor = textColor;
    }

    icView.messageType = messageType;

    [self showAlertWithMessage: strMessage];
}

-(void) setAlertView {
    
    [icViewContainer removeFromSuperview];
    
    UIView *view = [self getCurrentViewController];
    
    [self setAlertFrame];
    
    [view  addSubview: icViewContainer];
}


-(UIView *) getCurrentViewController {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    
    return window;
    
}

-(void) setAlertFrame {
    
    if(icView.parentationType == KGSIC_TopToBottom) {
        
        icViewContainer.frame = CGRectMake(0, -icViewContainer.frame.size.height, icViewContainer.frame.size.width, icViewContainer.frame.size.height);
        
    }
    
    if(icView.parentationType == KGSIC_BottomToTop) {
        
        icViewContainer.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height+icViewContainer.frame.size.height, icViewContainer.frame.size.width, icViewContainer.frame.size.height);
        
    }
    
}

-(void) animateAlert {
    
    icViewContainer.backgroundColor = icView.viewMsgContainer.backgroundColor;
    
    CGFloat flAnimationDuration = 0.3;
    
    CGRect rectFinal = icViewContainer.frame;
    
    CGRect rectTo = CGRectZero;
    
    if(icView.parentationType == KGSIC_TopToBottom) {
        
        rectTo = CGRectMake(0, 0, icViewContainer.frame.size.width, icViewContainer.frame.size.height);
        
    }
    else if(icView.parentationType == KGSIC_BottomToTop) {
        
        rectTo = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-icViewContainer.frame.size.height, icViewContainer.frame.size.width, icViewContainer.frame.size.height);
        
    }
    
    NSLog(@"KGSIC: From %@ => To %@", NSStringFromCGRect(rectFinal), NSStringFromCGRect(rectTo));
    
    [UIView animateWithDuration: flAnimationDuration animations:^{
        
        icViewContainer.frame = rectTo;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration: flAnimationDuration
                              delay: flAnimationDuration * 3
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             icViewContainer.frame = rectFinal;
                             
                         } completion:^(BOOL finished) {
                             
                             boolAlertAnimationEnabled = NO;
                             
                             [icViewContainer removeFromSuperview];
                             
                             
                         }];
    }];
    
}

-(void) showMessageForInternetConnection:(BOOL) boolNetConnection {
    
    if (boolNetConnection == NO) {
        
        [self showAlertWithMessage: icView.strNoInternetMessage  ofType:KGSIC_MSG_Warning];
        
    }
    
}

- (BOOL) isNetConnnected {
    
    BOOL	boolNetConnection = FALSE;
    
    if ([[Reachability sharedInstance] currentReachabilityStatus]!= NotReachable) {
        
        boolNetConnection = TRUE;
        
    }
    
    return boolNetConnection;
}

-(CGFloat) getLabelWidth {
    

    CGFloat flIconWidth = icView.imgViewAlert.frame.size.width-30;
    
    if(icView.messageType==KGSIC_MSG_None) {
        flIconWidth = 0;
    }
    NSLog(@"Message %@", icView.lblMessage.text);
    
    CGFloat flLlbWidth = [icView.lblMessage.text
                          boundingRectWithSize: CGSizeMake(icView.frame.size.width-flIconWidth, icView.lblMessage.frame.size.height)
                          options: NSStringDrawingUsesLineFragmentOrigin
                          attributes: @{ NSFontAttributeName:icView.lblMessage.font }
                          context:nil].size.width;
    
    return flLlbWidth+20;
    
}

-(void) setMessagePosition {
    
    [self adjustMessagePosition];
    
    CGFloat flLlbWidth = [self getLabelWidth];
    
    CGFloat flContentWidth = flLlbWidth;
    
    CGFloat flOriginY = (icView.frame.size.width-flContentWidth)/2;
    
    icView.imgViewAlert.hidden = YES;
    
    if(icView.boolShouldShowAlertImage && icView.messageType != KGSIC_MSG_None) {
        
        if(icView.messageType != KGSIC_MSG_Custom) {
            
            [self setAlertImage];
            
        }
        
        flContentWidth = rectImageInitial.size.width + flLlbWidth;
        
        flOriginY = (icView.frame.size.width-flContentWidth)/2;
        
        icView.imgViewAlert.frame = CGRectMake(flOriginY, rectLabelInitial.origin.y, rectImageInitial.size.height, rectImageInitial.size.height);
        
        flOriginY=flOriginY+icView.imgViewAlert.frame.size.width;
        
        icView.imgViewAlert.center = CGPointMake(icView.imgViewAlert.center.x, icView.lblMessage.center.y);
        
        icView.imgViewAlert.hidden = NO;
        
    }
    
    icView.lblMessage.frame = CGRectMake(flOriginY, rectLabelInitial.origin.y, flLlbWidth, rectLabelInitial.size.height);
    
//    NSLog(@"Message Position: %f => %f %f %f",icView.frame.size.width, icView.imgViewAlert.frame.origin.x, icView.lblMessage.frame.origin.x, icView.lblMessage.frame.size.width);
    
}

-(void) setAlertImage {
    
    NSString *strImageName;

    if(icView.messageType == KGSIC_MSG_Warning) {
        
        strImageName = @"KGSIC_Warning";
    }
    
    if(icView.messageType == KGSIC_MSG_Error) {
        
        strImageName = @"KGSIC_Error";
    }
    
    if(icView.messageType == KGSIC_MSG_Success) {
        
        strImageName = @"KGSIC_Success";
    }
    
    icView.imgViewAlert.image = [UIImage imageWithContentsOfFile:[bundleName pathForResource:strImageName ofType:@"png"]];
    
}


#pragma mark- Public Methods

- (BOOL) checkInternetConnectionWithNoInternetAlert:(BOOL) boolShowAlert {
    
    BOOL boolNetConnection = [self isNetConnnected];
    
    if(boolShowAlert) {
        
        [self showMessageForInternetConnection: boolNetConnection];
        
    }
    
    return boolNetConnection;
    
}

- (BOOL) checkInternetConnectionWithNoInternetAlertMessage:(NSString *) strMessage {
    
    if(strMessage == nil) {
        
        return [self checkInternetConnectionWithNoInternetAlert: NO];
        
    }
    
    BOOL boolNetConnection = [self isNetConnnected];
    
    icView.strNoInternetMessage = strMessage;
    
    [self showMessageForInternetConnection: boolNetConnection];
    
    return boolNetConnection;
}

- (void) showAlertMessage:(NSString *)strMessage withAlertImage:(UIImage *) img{
    
    if(img == nil) {
        
        icView.boolShouldShowAlertImage = NO;
        
    }
    else {
        
        icView.boolShouldShowAlertImage = YES;
        
        icView.messageType = KGSIC_MSG_Custom;
        
        icView.imgViewAlert.image = img;
        
    }
    
    [self showAlertWithMessage: strMessage];
    
}

-(void) showAlertMessage:(NSString *)strMessage ofType:(KGSICMessageType) messageType {
    
    [self showAlertWithMessage:strMessage ofType:messageType];
    
}

- (BOOL) isInternetConnected {
    
    return [self checkInternetConnectionWithNoInternetAlert: NO];
    
}

- (void) showNoInternetAlert {
    
    [self checkInternetConnectionWithNoInternetAlert: YES];
    
}

-(void) setBackgroundColor:(UIColor *)backgroundColor {
    savedBackgroundColor = backgroundColor;
}

-(void) setMessageTextColor:(UIColor *)backgroundColor {
    savedTextColor = backgroundColor;
}

-(void) setBackgroundColor:(UIColor *)backgroundColor  andMessageTextColor:(UIColor *)msgColor {
    
    [self setBackgroundColor: backgroundColor];
    [self setMessageTextColor: msgColor];
}
@end
