//
//  AppDelegate.m
//  CSVToVideoFileConfig
//
//  Created by Editor on 22/02/2014.
//  Copyright (c) 2014 LearnersCloud. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize textSubject;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)SelectFile:(id)Id{
    
    NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
    
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setAllowedFileTypes:[NSArray arrayWithObject:@"csv"]];
    
    
    [openPanel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton && textSubject.stringValue.length > 1) {
           
            for (NSURL *fileURL in [openPanel URLs]) {
                 NSError *outError = nil;
                NSString *fileString = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&outError];
                if (!fileString) {
                    NSLog(@"Error reading file.");
                }
                else{
                    
                     NSArray* rows = [fileString componentsSeparatedByString:@"\n"];
                    // Create a result file in the same location
                    //NSLog(@"%@", fileURL.path);
                    NSString *directory = [fileURL.path stringByDeletingLastPathComponent];
                    NSString *DirectoryPlusFileName = [directory stringByAppendingString:@"/ResultFile.xml"];
                    [[NSFileManager defaultManager] createFileAtPath:DirectoryPlusFileName contents:nil attributes:nil];
                    
                    //NSError *error = nil;
                    //NSLog(@"Documents directory: %@", [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:&error]);
                    //NSLog(@"%@", DirectoryPlusFileName);
                    NSMutableData *FullContent = [NSMutableData dataWithContentsOfFile:DirectoryPlusFileName];
                    for (int i = 0; i< rows.count; i++) {
                        NSArray *items = [rows[i] componentsSeparatedByString:@","];
                        
                            
                            NSString *Subject = textSubject.stringValue ;
                            NSString *LineToWrite = [NSString stringWithFormat:@"<VideoItem Title=|%@| Description=|%@| Free=|0| Subject=|%@| M3u8=|%@| Sociallyfree=|0| ProductId=|%@|<VideoItem>±",items[1],items[2],Subject,items[0],items[0]];
                            //NSLog(@"%@", LineToWrite);
                        NSData* data = [LineToWrite dataUsingEncoding:NSUTF8StringEncoding];
                        [FullContent  appendData:data];
                       
                            
                        
                       
                        
                        
                    }
                     [FullContent writeToFile:DirectoryPlusFileName atomically:YES ];
                    
                    NSAlert *alert = [[NSAlert alloc] init];
                    [alert setMessageText:@"Completed Successfully. Result file is on your desktop."];
                    [alert runModal];
                    
                }
                
            }
        }
        else{
            
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setMessageText:@"You have to enter a subject name to create the file"];
            [alert runModal];
            
        }
        
       
    }];
    
}

@end
