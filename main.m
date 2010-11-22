//
//  main.m
//  converter
//
//  Created by 黒澤 隆之 on 10/11/20.
//  Copyright Renesas Technology Corp. 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
	[[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];

	return NSApplicationMain(argc, (const char **) argv);
}
