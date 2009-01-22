//
//  DelegationHelper.m
//  PatchComposer
//
//  Created by Joachim Bengtsson on 2009-01-22.
//  Copyright 2009 Third Cog Software. All rights reserved.
//

#import "DelegationHelper.h"


@implementation DelegationHelper
-(id)init;
{
	
	_defaults = [[NSMutableDictionary alloc] init];
	
	return self;
}
-(void)dealloc;
{
	self.delegate = nil;
	[_defaults release];
	[super dealloc];
}
@synthesize delegate;
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
	return [[delegate class] instanceMethodSignatureForSelector:sel];
}
- (void)forwardInvocation:(NSInvocation *)invo
{
	if([delegate respondsToSelector:invo.selector]) {
		[invo invokeWithTarget:delegate];
		return;
	}
	
	if(strcmp(@encode(void), invo.methodSignature.methodReturnType) == 0)
		return;
	
	SEL sel = invo.selector;
	id retObj = [_defaults objectForKey:SELobj(sel)];
	if(!retObj) {
		[delegate forwardInvocation:invo]; // this might lead to a runtime error
		return;
	}
	
	if([retObj isKindOfClass:[NSValue class]]) {
		// Unpack primitive
		char retval[invo.methodSignature.methodReturnLength];
		[(NSValue*)retObj getValue:retval];
		[invo setReturnValue:retval];
	} else {
		// Return object
		[invo setReturnValue:&retObj];
	}
		
}
-(void)setDefaultDelegationObject:(id)val forSelector:(SEL)sel;
{
	[_defaults setObject:val forKey:SELobj(sel)];
}
@end
