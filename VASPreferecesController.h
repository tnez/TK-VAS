//
//  VASPreferecesController.h
//  VAS
//
//  Created by Control Mac on 7/28/10.
//  Copyright 2010 University of Kentucky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <TKUtility/TKUtility.h>

@interface VASPreferecesController : NSObject {
	IBOutlet id dataDirectoryBox;
	IBOutlet id questionFileBox;
}
@property (assign) IBOutlet id dataDirectoryBox;
@property (assign) IBOutlet id questionFileBox;
-(IBAction) browseForDataDirectory:(id) sender;
-(IBAction) browseForQuestionFile:(id) sender;
-(IBAction) updateNumberOfTickMarks:(id) sender;
@end
