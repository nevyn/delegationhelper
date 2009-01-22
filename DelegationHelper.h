//
//  DelegationHelper.h
//  PatchComposer
//
//  Created by Joachim Bengtsson on 2009-01-22.
//  Copyright 2009 Third Cog Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define SELobj(s) [NSValue value:&(s) withObjCType:@encode(SEL)]
#define BOOLobj(b) [NSNumber numberWithBool:b]

@interface DelegationHelper : NSObject {
	id delegate;
	NSMutableDictionary *_defaults;
}
// NSValue with subclasses are unpacked and returned as primitives, all other as pointers
-(void)setDefaultDelegationObject:(id)val forSelector:(SEL)sel;
@property (retain) id delegate;

@end
