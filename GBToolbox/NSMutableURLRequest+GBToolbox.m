//
//  NSMutableURLRequest+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSMutableURLRequest+GBToolbox.h"

static CGFloat const kRequestTimeoutInterval =      30;
static NSString * const kDefaultFormBoundary =      @"GBFormBoundary_B6bjp9UyZcXHTf_f)m(YsWW1S.aUbx/ls+zQbnF)dTCHX+e1lkJD";

@implementation GBFormPayload

#pragma mark - creation

-(id)initWithName:(NSString *)name filename:(NSString *)filename contentType:(NSString *)contentType data:(NSData *)data {
    if (self = [super init]) {
        self.name = name;
        self.contentType = contentType;
		self.filename = filename;
        self.data = data;
    }
    
    return self;
}

-(id)initWithName:(NSString *)name contentType:(NSString *)contentType data:(NSData *)data {
	self = [self initWithName:name filename:nil contentType:contentType data:data];
    return self;
}

+(GBFormPayload *)formPayloadWithName:(NSString *)name filename:(NSString *)filename contentType:(NSString *)contentType data:(NSData *)data {
    return [[self alloc] initWithName:name filename:filename contentType:contentType data:data];
}

+(GBFormPayload *)formPayloadWithName:(NSString *)name contentType:(NSString *)contentType data:(NSData *)data {
    return [[self alloc] initWithName:name contentType:contentType data:data];
}

#pragma mark - convenience

-(NSData *)representationInMultipartForm {
    //create the little subheader
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", self.name];
    if ([self.contentType isEqualToString:@"application/octet-stream"]) disposition = [disposition stringByAppendingString:[NSString stringWithFormat:@"; filename=\"%@\"", self.filename ? self.filename : @"file"]];
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@", self.contentType];
    NSString *subheaderString = [NSString stringWithFormat:@"%@\r\n%@\r\n\r\n", disposition, type];

    //stitch the subheader together with the data
    NSMutableData *data = [[subheaderString dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    [data appendData:self.data];
    
    return data;
}

@end


@implementation NSMutableURLRequest (GBToolbox)

+(NSMutableURLRequest *)postRequestWithURLString:(NSString *)urlString jsonPayload:(NSData *)data {
    return [self postRequestWithURLString:urlString payloadType:@"application/json" payloadData:data];
}

+(NSMutableURLRequest *)postRequestWithURLString:(NSString *)urlString jsonPayload:(NSData *)data headers:(NSDictionary *)headers {
    return [self postRequestWithURLString:urlString payloadType:@"application/json" payloadData:data headers:headers];
}


+(NSMutableURLRequest *)postRequestWithURLString:(NSString *)urlString payloadType:(NSString *)contentType payloadData:(NSData *)data {
    return [self postRequestWithURLString:urlString payloadType:contentType payloadData:data headers:nil];
}

+(NSMutableURLRequest *)postRequestWithURLString:(NSString *)urlString payloadType:(NSString *)contentType payloadData:(NSData *)data headers:(NSDictionary *)headers {
    //augment headers with content type
    NSMutableDictionary *headers2 = headers ? [headers mutableCopy] : [NSMutableDictionary new];
    headers2[@"Content-Type"] = contentType;
    
    //return new request
    return [NSMutableURLRequest requestWithURLString:urlString method:@"POST" body:data headers:headers2];
}


+(NSMutableURLRequest *)multipartPostRequestWithURLString:(NSString *)urlString payloads:(NSArray *)payloads {
    return [self multipartPostRequestWithURLString:urlString payloads:payloads headers:nil];
}

+(NSMutableURLRequest *)multipartPostRequestWithURLString:(NSString *)urlString payloads:(NSArray *)payloads headers:(NSDictionary *)headers {
    //augment headers with content type
    NSMutableDictionary *headers2 = headers ? [headers mutableCopy] : [NSMutableDictionary new];
    headers2[@"Content-Type"] = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", kDefaultFormBoundary];
    
    //create body
    NSMutableData *body = [NSMutableData new];
    
    //append the little sub-bodies
    for (GBFormPayload *payload in payloads) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", kDefaultFormBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[payload representationInMultipartForm]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //append the last boundary
    [body appendData:[[NSString stringWithFormat:@"--%@--", kDefaultFormBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //return new request
    return [NSMutableURLRequest requestWithURLString:urlString method:@"POST" body:body headers:headers2];
}


+(NSMutableURLRequest *)requestWithURLString:(NSString *)urlString method:(NSString *)method body:(NSData *)body headers:(NSDictionary *)headers {
    if (urlString && method) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:kRequestTimeoutInterval];
        
        //http method
        [request setHTTPMethod:method];
        
        //request body
        if (body) {
            NSString *contentLength = [NSString stringWithFormat:@"%lu", (unsigned long)body.length];
            
            [request setValue:contentLength forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:body];
        }
        
        //additional request headers
        if (headers) {
            for (NSString *header in headers) {
                [request setValue:headers[header] forHTTPHeaderField:header];
            }
        }
        
        return request;
    }
    else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"url string and method are required" userInfo:nil];
    }
}

@end
