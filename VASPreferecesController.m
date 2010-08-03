//
//  VASPreferecesController.m
//  VAS
//
//  Created by Control Mac on 7/28/10.
//  Copyright 2010 University of Kentucky. All rights reserved.
//

#import "VASPreferecesController.h"

@implementation VASPreferecesController

@synthesize dataDirectoryBox, questionFileBox;

-(IBAction) browseForDataDirectory:(id) sender {
	// configure panel
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setDirectory:[dataDirectoryBox stringValue]];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	// run panel
	[panel runModal];
	// set data directory value (using key-value-observing compliant methods)
	[[TKPreferences defaultPrefs] setValue:[[panel filenames] objectAtIndex:0]
																	forKey:@"dataDirectory"];
}

-(IBAction) browseForQuestionFile:(id) sender {
	// configure panel
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setDirectory:[questionFileBox stringValue]];
	[panel setCanChooseFiles:YES];
	[panel setCanChooseDirectories:NO];
	[panel setAllowsMultipleSelection:NO];
	// run panel
	[panel runModal];
	// set text box equal to user selection
	[questionFileBox setStringValue:[[panel filenames] objectAtIndex:0]];
	// set question file value (using key-value-observing compliant methods)
	[[TKPreferences defaultPrefs] setValue:[[panel filenames] objectAtIndex:0]
																	forKey:@"questionFile"];	
}

-(IBAction) updateNumberOfTickMarks:(id) sender {
	NSSlider *slider = sender;
	[slider setNumberOfTickMarks:[slider intValue]];
	slider = nil;
}

@end
