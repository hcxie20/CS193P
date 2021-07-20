//
//  Logger.h
//  Matchismo
//
//  Created by XIE haochen on 2021/7/20.
//

#ifndef Logger_h
#define Logger_h

#import "Foundation/Foundation.h"

@interface LogEntry : NSObject
- (instancetype)initWithNSString:(NSString *)log;
@end

@interface Logger : NSObject
- (void)addLog:(NSString *)log;
- (NSArray *)showLogs;
- (LogEntry *)lastLog;
@end

#endif /* Logger_h */
