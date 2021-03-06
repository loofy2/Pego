//
//  Sprite.h
//  Cheapo
//
//  Created by Lee Irvine on 11/7/11.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZAsset.h"

@interface KZSprite : KZAsset

@property (nonatomic, strong) KZAnimation *animation;
@property (nonatomic) GLfloat scale;

+ (KZSprite *) spriteWithName:(NSString *) name;
+ (KZSprite *) spriteWithTexture:(KZTexture *) texture;
@end
