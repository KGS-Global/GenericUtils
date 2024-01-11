//
//  ContactUs.m
//  MediaShareController
//
//  Created by Towhidul Islam on 12/11/16.
//  Copyright © 2016 KITE GAMES STUDIO. All rights reserved.
//

#import "ContactUs.h"
#import <MessageUI/MessageUI.h>

@interface ContactUs () <MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) ActionCompletion onCompletion;
@property (nonatomic, weak) UIViewController *presentingViewController;
@property (nonatomic, strong) MFMailComposeViewController *mailController;
@property (nonatomic, strong) ContactUsContent *content;

@end

@implementation ContactUs

- (void)dealloc{
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (instancetype)initWithContent:(ContactUsContent *)content{
    
    if (self = [super init]) {
        self.content = content;
    }
    return self;
}


-(void)initializeMailControllerWithContent : (ContactUsContent *)content{
    
    self.mailController = [[MFMailComposeViewController alloc] init];
    self.mailController.mailComposeDelegate = self;
    self.mailController.view.backgroundColor = [UIColor whiteColor];
    
    [self.mailController setToRecipients:content.strRecipients];
    [self.mailController setSubject:content.strSubject];
    [self.mailController setMessageBody:content.strMessageBody isHTML:true];
    [self.mailController addAttachmentData:content.dataAttachment  mimeType:[content getParsedMimeType] fileName:[content fileName]];

}

- (void)addContent:(ContactUsContent *)content{
    self.content = content;
}

- (BOOL)isComponentEnabled{
    return [MFMailComposeViewController canSendMail];
}

- (void) presentOn:(UIViewController*)viewController onCompletion:(ActionCompletion)block{
    self.presentingViewController = viewController;
    self.onCompletion = block;
    [self initializeMailControllerWithContent:self.content];
    self.mailController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.presentingViewController presentViewController:self.mailController animated:YES completion:nil];
}


#pragma MFMailComposeViewControllerDelegate

-(void) mailComposeController : (MFMailComposeViewController *) controller didFinishWithResult : (MFMailComposeResult)result error : (NSError *) error {
    
    __weak ContactUs *weakSelf = self;
    [self.presentingViewController dismissViewControllerAnimated: YES completion : ^{
        
        if (weakSelf.onCompletion != nil /*&& result == MFMailComposeResultSent*/) {
            weakSelf.onCompletion(result == MFMailComposeResultSent);
        }
    }];
}

@end
