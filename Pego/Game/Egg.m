//
//  Egg.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Egg.h"

@implementation Egg
+ (Egg *) spawn: (vec3) origin {
  Egg *egg = [[Egg alloc] init];
  egg.sprite = [KZSprite spriteWithName:@"egg"];
  egg.assets = @[egg.sprite];
  egg.origin = origin;
  
  return egg;
}
@end