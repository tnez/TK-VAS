//
//  VASController.m
//  VAnalog
//
//  Created by Travis Nesland <Travis Nesland <tnesland@gmail.com>@gmail.com> on 4/29/10.
//  Copyright 2010 University of Kentucky, Residential Research Facility. All rights reserved.
//

#import "VASController.h"

@implementation VASController

-(void) event:(NSDictionary *) eventInfo didOccurInComponent:(id) sender {
	if([sender isKindOfClass:[TKVasController class]]) {
		// add to crash recovery log
		NSString *crashEntry = [[NSString alloc] initWithString:[eventInfo valueForKey:@"questionID"]];
		[[TKLogging crashRecoveryLogger] logString: [crashEntry autorelease]];
		// add to main log
		NSString *mainEntry = [[NSString alloc] initWithFormat: @"%@\t%@\t%@\t%@",
													 [eventInfo valueForKey: @"questionID"],
													 [eventInfo valueForKey: @"response"],
													 [eventInfo valueForKey: @"latency"],
													 [eventInfo valueForKey: @"questionText"]];
		[[TKLogging mainLogger] logString: [mainEntry autorelease]];
	} 
	// . . . no other cases
}

-(BOOL) didLoadVasComponent {
	questionSet = [[TKQuestionSet alloc] initFromFile: QUESTION_FILE
																	usingAccessMethod: QUESTION_ACCESS_METHOD];
	if(questionSet) {
		// setup vas component
		vasComponenet = [[TKVasController alloc] initWithQuestions:questionSet];
		[vasComponenet setNumberOfIntendedQuestions:[questionSet count]];
	} else {
		return NO;
	}
	return YES;
}

-(BOOL) isClearedToBeginSession {
	// check that data directory exists
	if(![self directoryExistsAtPath: DATA_DIRECTORY]) {
		[self alertWithMessage:@"Data Directory is not valid!"];
		return NO;
	}
	// attempt to load setup info
	if(![self didLoadDefaultSetupInfo]) {
		[self alertWithMessage:@"Could not load setup info!"];
		return NO;
	}
	// attempt to setup vas component
	if(![self didLoadVasComponent]) {
		[self alertWithMessage:@"Could not load VAS Component!"];
		return NO;
	}
	// passed all our checks
	return YES;
}

-(void) loadSession {
	// setup session
	[session addComponent:vasComponenet];
}

-(void) recoverFromCrash {
	TKDelimitedFileParser *recoveryInfo = 
	[[TKDelimitedFileParser alloc] initParserWithFile:CRASH_RECOVERY_FILE
																			usingEncoding:TKDELIM_DEFAULT_ENCODING
																withRecordDelimiter:@"\n"
																 withFieldDelimiter:@"\t"];
	// for every entry in the crash recovery file...
	for(NSArray *record in [recoveryInfo records]) {
		//...remove the question from current session by id
		[questionSet removeQuestionWithId:[record objectAtIndex:0]];
	}
}

-(void) unloadSession {
	[questionSet release];
	[vasComponenet release];
	[super unloadSession];
}
			
@end
