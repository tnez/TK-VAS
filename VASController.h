//
//  VASController.h
//  VAnalog
//
//  Created by Travis Nesland <tnesland@gmail.com> on 4/29/10.
//  Copyright 2010 University of Kentucky, Residential Research Facility. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <TKUtility/TKUtility.h>

#define CRASH_RECOVERY_FILE [DATA_DIRECTORY stringByAppendingPathComponent:[preferences valueForKey:@"crashRecoveryFileName"]]
#define DATA_DIRECTORY [preferences valueForKey:@"dataDirectory"]
#define QUESTION_FILE [preferences valueForKey:@"questionFile"]
#define QUESTION_ACCESS_METHOD [[preferences valueForKey:@"vasQuestionAccessMethod"] integerValue]

@interface VASController : TKAppController {
	TKQuestionSet *questionSet;
	TKVasController *vasComponenet;
}
// TKAppController Functions Overridden for the purpose of this program
-(void) event:(NSDictionary *) eventInfo didOccurInComponent:(id) sender;
-(BOOL) isClearedToBeginSession;
-(void) loadSession;
-(void) recoverFromCrash;
-(void) unloadSession;
// Other Functions
-(BOOL) didLoadVasComponent;
@end
