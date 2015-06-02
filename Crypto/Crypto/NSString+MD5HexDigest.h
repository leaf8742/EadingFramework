//
//  NSString+MD5HexDigest.h
//  NeuForum
//
//  Created by LEAF on 13-2-16.
//  Copyright (c) 2013年 LEAF. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@interface NSString (md5)

-(NSString *) md5HexDigest;

@end
