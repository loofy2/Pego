//
//  Physics.m
//  Pego
//
//  Created by Lee Irvine on 12/31/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "Physics.h"
#import "PhysicalEntity.h"
#import "Collision.h"
#import "NSArray-Extensions.h"
#import "Game.h"

@interface Physics ()
@property (nonatomic, retain) NSMutableArray *entities;
@end

@implementation Physics

+ (Physics *) physics {
  return [[Physics alloc] init];
}

- (id) init {
  if(self = [super init]) {
    self.entities = [[NSMutableArray alloc] initWithCapacity:100];
  }
  
  return self;
}

- (void) removeEntity: (PhysicalEntity *) entity {
  [self.entities removeObject: entity];
}

- (void) addPhysicalEntity: (PhysicalEntity *) entity {
  [self.entities addObject:entity];
}

- (void) addPhysicalEntities: (NSArray *) entities {
  [self.entities addObjectsFromArray: entities];
}

- (void) applyForces {
  const float friction = 0.05f;
  
  for(PhysicalEntity *entity in self.entities) {
    force force = entity.force;

    if(force.power <= 0.f) {
      force.power = 0.f;
      force.direction = _v(0,0,0);
      continue;
    }
    
    vec3 vector = vectorWithMass(force, entity.mass);
    entity.origin = add(entity.origin, vector);
    force.power -= force.power * friction;
    
    entity.force = force;
  }
}

//- (void) peggySlideWithIce {
//  vec3 translation = sub(_game.surfaceMostUnderPeggy.origin, _game.surfaceMostUnderPeggy.lastorigin);
//  _game.peggy.origin = add(_game.peggy.origin, translation);
//
//  vec3 rotation = _v(0, 0, _game.surfaceMostUnderPeggy.angle.z - _game.surfaceMostUnderPeggy.lastAngle);
//  _game.peggy.origin = rotate(_game.peggy.origin, _game.surfaceMostUnderPeggy.origin, rotation);
//  _game.peggy.angle = add(_game.peggy.angle, rotation);
//}

- (void) bounceCollidingEntities:(NSArray *) entities {
  NSArray *collisions = nil;
  NSInteger iteration = 0;

  do {
    collisions = [self findAllCollisions: entities];
    for(Collision *c in collisions) {
      c.attacker.origin = c.point;
      
      c.victim.force = scaleForcePower(c.force, .6f);
      c.attacker.force = scaleForcePower(c.force, .4f);
      
      // TODO: instead of reversing the direction mirror it about the colloding axis.
      c.attacker.force = iteration == 1 ? scaleForceDirection(c.attacker.force, -1.f) : c.attacker.force;
    }
  } while([collisions count] > 0 && iteration++ < 16);
}

- (NSArray *) findAllCollisions:(NSArray *) entities {
  NSMutableArray *collisions = [NSMutableArray array];

  PhysicalEntity *b = nil;
  for(PhysicalEntity *a in entities) {
    if([a isMoving] == NO) continue;
    if((b = [self firstEntity:entities touching:a]) == nil) continue;
    [collisions addObject: [self collisionWith:a and:b] ];
  }
  
  return [NSArray arrayWithArray: collisions];
}

- (PhysicalEntity *) firstEntity:(NSArray *) entities touching:(PhysicalEntity *) t {
  for(PhysicalEntity *e in entities) {
    if(t == e) continue;
    if([t isTouching: e]) return e;
  }
  return nil;
}

- (Collision *) collisionWith:(PhysicalEntity *) a and: (PhysicalEntity *) b {
  Collision *collision = [[Collision alloc] init];
  
  collision.attacker = a;
  collision.victim = b;
  collision.point = a.lastorigin;
  collision.force = addForces(a.force, b.force);
  
  return collision;
}

@end
