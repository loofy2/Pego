//
//  Peggy.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Peggy.h"

@interface Peggy ()
@property (nonatomic, strong) KZEvent *blinkEvent;
@property (nonatomic, strong) KZEvent *stopBreakEvent;
@end

@implementation Peggy

+ (Peggy *) spawn: (vec3) origin {
  Peggy *peggy = [[Peggy alloc] init];
  peggy.origin = origin;
  peggy.mass = 1.f;
  
  GLfloat s = 20.f;
  peggy.bounds = _t(_v(-s, s, 0), _v(s, s, 0), _v(0, -s, 0));
  peggy.sprite = [KZSprite spriteWithName:@"peggy"];

  KZTriangle *triangle = [KZTriangle triangle: peggy.bounds];

  peggy.assets = @[peggy.sprite, triangle];
  
  peggy.blinkEvent = [KZEvent every:3.f loop:^{
    if([peggy.sprite.animation.currentAnimation isEqual:@"idle"]) {
      [peggy animateBlinking];
    }
  }];
  
  return peggy;
}

- (void) dealloc {
  [self.blinkEvent cancel];
  [self.stopBreakEvent cancel];
}

- (void) animateWalking {
  [self.sprite.animation setAnimationLoop:@"walk"];
  self.sprite.animation.isLooping = YES;
}

- (void) animateIdling {
  [self.sprite.animation setAnimationLoop:@"idle"];
  self.sprite.animation.isLooping = NO;
}

- (void) animateBlinking {
  [self.sprite.animation setNextAnimationLoop:@"idle" looping:YES];
  self.sprite.animation.animationLoop = @"blink";
  self.sprite.animation.isLooping = NO;
}

- (void) animateBreaking {
  self.sprite.animation.animationLoop = @"break";
  self.sprite.animation.isLooping = NO;
  
  [self.stopBreakEvent cancel];
  self.stopBreakEvent = [KZEvent after:.5f run:^{
    if([self.sprite.animation.currentAnimation isEqual:@"break"]) {
      [self animateIdling];
    }
  }];
}

@end
