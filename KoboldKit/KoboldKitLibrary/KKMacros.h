//
//  KKMacros.h
//  KoboldKitDemo
//
//  Created by Steffen Itterheim on 13.06.13.
//  Copyright (c) 2013 Steffen Itterheim. All rights reserved.
//

// Some code adopted from cocos2d-iphone, License:
/*
 * cocos2d for iPhone: http://www.cocos2d-iphone.org
 *
 * Copyright (c) 2008-2010 Ricardo Quesada
 * Copyright (c) 2011 Zynga Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#ifndef KoboldKitDemo_KKMacros_h
#define KoboldKitDemo_KKMacros_h

#import "float.h"

/** @file KKMacros.h */

/** typedefs for platform compatibility */
#if TARGET_OS_IPHONE
typedef UIResponder KKResponder;
#elif TARGET_OS_MAC
typedef NSResponder KKResponder;
#endif

/** Epsilon and Float equality */
#if CGFLOAT_IS_DOUBLE
#define EPSILON_VALUE DBL_EPSILON
#else
#define EPSILON_VALUE FLT_EPSILON
#endif

#define CGFloatEqualToFloat(__x, __y) (fabs(__x - __y) <= (fabs(__x) > fabs(__y) ? fabs(__y) : fabs(__x)) * EPSILON_VALUE)


/**  */
#define KKMethodUnavailable(reason) __attribute__((unavailable(reason)))
#define KKMustOverrideMethod()      [NSException raise : NSInternalInconsistencyException format : @"%s must be overridden in subclass/category or you called [super %s]", __PRETTY_FUNCTION__, __PRETTY_FUNCTION__]



/** Radians to Degrees and vice versa */
#define M_PI_180			0.01745329251994	/* pi/180           */
#define M_180_PI			57.29577951308233	/* 180/pi           */
#define KK_DEG2RAD(__ANGLE__) ((__ANGLE__) * M_PI_180)
#define KK_RAD2DEG(__ANGLE__) ((__ANGLE__) * M_180_PI)


/** simple random */
#define KKRANDOM_MINUS1_1()              ((random() / (float)0x3fffffff) - 1.0f)
#define KKRANDOM_0_1()                   ((random() / (float)0x7fffffff))

#endif
