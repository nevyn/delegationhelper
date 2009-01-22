//
//  main.m
//  DelegationHelper
//
//  Created by Joachim Bengtsson on 2009-01-22.
//  Copyright Third Cog Software 2009. All rights reserved.
//
#import "DelegationHelper.h"
@protocol FooDelegate
@optional
-(void)doThis;
-(BOOL)doThat;
-(NSString*)didNothing;
@end
@interface FooDelegateHelper : DelegationHelper <FooDelegate> {}
@end

@interface DelegateConsumer : NSObject < FooDelegate >
{}
@end
@implementation DelegateConsumer
//-(void)doThis; { NSLog(@"This"); }
-(BOOL)doThat; { NSLog(@"That?"); return YES; }
//-(NSString*)didNothing; { NSLog(@"NOTHING"); return @"woah"; }
@end

@interface Foo : NSObject
{
	FooDelegateHelper *delegate;
}
-(void)doit;
@end
@implementation Foo
-(id)init;
{
	if( ! [super init] ) return nil;
	
	delegate = [[DelegationHelper alloc] init];
	[delegate setDefaultDelegationObject:BOOLobj(NO) forSelector:@selector(doThat)];
	[delegate setDefaultDelegationObject:@"default" forSelector:@selector(didNothing)];

	delegate.delegate = [DelegateConsumer new];
	
	return self;
}
-(void)doit;
{
	[delegate doThis];
	BOOL didIt = [delegate doThat];
	NSLog(@"Did that? %d", didIt);
	NSString *nothing = [delegate didNothing];
	NSLog(@"Nothing: %@", nothing);
}
@end





#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
	NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
	[[Foo new] doit];
	[p drain];
    return 0;
}
