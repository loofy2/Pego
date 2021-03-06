//
//  Entity.h
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KZSprite, KZShader, KZTexture;
@interface KZEntity : NSObject
@property (nonatomic, strong) NSArray *assets;
@property (nonatomic) BOOL isFloating;
@property (nonatomic) vec3 origin;
@property (nonatomic) vec3 angle;
@property (nonatomic) vec3 dimensions;
@property (nonatomic) NSInteger renderPriority;
- (void) update;
- (void) setAngle_z:(float) angle;
- (void) setAngle_y:(float) angle;
- (void) setAngle_x:(float) angle;
+ (KZEntity *) entity:(NSArray *) assets;
- (BOOL) isTouching:(KZEntity *) e;
- (GLKMatrix4) modelMatrix;

@end
