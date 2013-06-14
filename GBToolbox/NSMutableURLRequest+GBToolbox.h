//
//  NSMutableURLRequest+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBFormPayload : NSObject

@property (copy, nonatomic) NSString        *contentType;
@property (copy, nonatomic) NSString        *name;
@property (strong, nonatomic) NSData        *data;

+(GBFormPayload *)formPayloadWithName:(NSString *)name contentType:(NSString *)contentType data:(NSData *)data;
-(id)initWithName:(NSString *)name contentType:(NSString *)contentType data:(NSData *)data;

-(NSData *)representationInMultipartForm;

@end

@interface NSMutableURLRequest (GBToolbox)

+(NSMutableURLRequest *)postRequestWithURLString:(NSString *)urlString jsonPayload:(NSData *)data;
+(NSMutableURLRequest *)postRequestWithURLString:(NSString *)urlString jsonPayload:(NSData *)data headers:(NSDictionary *)headers;

+(NSMutableURLRequest *)postRequestWithURLString:(NSString *)urlString payloadType:(NSString *)contentType payloadData:(NSData *)data;
+(NSMutableURLRequest *)postRequestWithURLString:(NSString *)urlString payloadType:(NSString *)contentType payloadData:(NSData *)data headers:(NSDictionary *)headers;

+(NSMutableURLRequest *)multipartPostRequestWithURLString:(NSString *)urlString payloads:(NSArray *)payloads;
+(NSMutableURLRequest *)multipartPostRequestWithURLString:(NSString *)urlString payloads:(NSArray *)payloads headers:(NSDictionary *)headers;

+(NSMutableURLRequest *)requestWithURLString:(NSString *)urlString method:(NSString *)method body:(NSData *)body headers:(NSDictionary *)headers;

@end
