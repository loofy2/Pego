//
//  Text.h
//  Cheapo
//
//  Created by Lee Irvine on 2/28/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZAsset.h"

typedef enum {
  KZTextAlignLeft,
  KZTextAlignRight,
  KZTextAlignCenter
} KZTextAlign;

@interface KZText : NSObject <KZAsset>
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) KZTexture *texture;
@property (nonatomic, strong) KZShader *shader;
@property (nonatomic) GLfloat scale;
@property (nonatomic) vec3 angle;
@property (nonatomic) vec3 offset;
@property (nonatomic) rgba tint;
@property (nonatomic) BOOL hidden;
@property (nonatomic) NSInteger zIndex;

- (NSUInteger) numVerts;
+ (KZText *) textWithString:(NSString *) string scale:(GLfloat) scale;

@end
