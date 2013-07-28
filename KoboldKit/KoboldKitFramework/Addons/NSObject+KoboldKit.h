//
//  NSObject+KoboldKit.h
//  KoboldKit
//
//  Created by Steffen Itterheim on 28.07.13.
//  Copyright (c) 2013 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>

/** NSObject category methods for Kobold Kit */
@interface NSObject (KoboldKit)

/** @name Scheduling Selectors */

/** Performs a selector with delay, with 'self' automatically sent to the selector.
 @param aSelector The selector to perform. Selector must take a single id parameter.
 @param delay The time to wait (in seconds) before performing the selector. */
-(void) performSelector:(SEL)aSelector afterDelay:(NSTimeInterval)delay;

/** Performs a selector in background, with 'self' automatically sent to the selector.
 @param aSelector The selector to perform. Selector must take a single id parameter. */
-(void) performSelectorInBackground:(SEL)aSelector;

@end
