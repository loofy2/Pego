//
//  KZTriangle.h
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZTriangle : KZAsset

+ (KZTriangle *) triangle:(vec3) a : (vec3) b : (vec3) c;
+ (KZTriangle *) triangle:(tri) t;

- (tri) tri;

@property (nonatomic, readonly) vec3 va;
@property (nonatomic, readonly) vec3 vb;
@property (nonatomic, readonly) vec3 vc;
@end
