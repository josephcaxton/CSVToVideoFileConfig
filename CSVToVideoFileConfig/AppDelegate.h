//
//  AppDelegate.h
//  CSVToVideoFileConfig
//
//  Created by Editor on 22/02/2014.
//  Copyright (c) 2014 LearnersCloud. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    
    
   //NSTextField IBOutlet *textSubject;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *textSubject;
- (IBAction)SelectFile:(id)Id;

@end


