//
//  NetCapsul.h
//  RequestSynchronizer
//
//  Created by NGStack on 4/30/14.
//  Copyright (c) 2014 Towhid Islam. All rights reserved.
//

//@import OldProjectDependency;
#import "CommunicationHeader.h"
#import "KGObject.h"
@class HttpRequestHeader;

@interface HttpWebRequest : KGObject
@property (nonatomic, readonly) NSString *baseUrl;
@property (nonatomic, strong) NSArray *pathComponent;
@property (nonatomic, strong) id<KGObjectProtocol> payLoad;
@property (nonatomic, strong) HttpRequestHeader *requestHeaderFields;
@property (nonatomic, readonly) HTTP_METHOD http_method;
@property (nonatomic, readonly) Application_ContentType contentType;
@property (nonatomic, readonly) BOOL authenticationEnabled;

- (instancetype) initWithBaseUrl:(NSString*)baseUrl;
- (instancetype) initWithBaseUrl:(NSString*)baseUrl method:(HTTP_METHOD)httpMethod;
- (instancetype) initWithBaseUrl:(NSString*)baseUrl method:(HTTP_METHOD)httpMethod contentType:(Application_ContentType)contentType;
- (instancetype) initWithBaseUrl:(NSString*)baseUrl method:(HTTP_METHOD)httpMethod contentType:(Application_ContentType)contentType cachePolicy:(NSURLRequestCachePolicy)policy;
- (NSURLRequest*) createRequest;
- (NSURLRequest*) createRequestWithPathComponent:(NSArray*)pathComponent andPayload:(id<KGObjectProtocol>)payload;
- (void) httpRequestConfiguration:(NSMutableURLRequest*)request;
- (void) updateCredentialWithUser:(NSString*)userId andPassword:(NSString*)password;
- (void) updateCredentialWithUser:(NSString*)userId andPassword:(NSString*)password persistance:(NSURLCredentialPersistence)persistence;
- (NSURLCredential*) credentialForChallenge:(NSURLAuthenticationChallenge*)challenge;
- (NSString *) convertValue:(id)value forKey:(NSString*)key;
- (NSURL*) createUrlFromPath:(NSArray*)path;
- (NSString *)getApplicationContentType:(Application_ContentType)contentType;
- (NSString *)getHTTPMethod:(HTTP_METHOD)method;

@end
