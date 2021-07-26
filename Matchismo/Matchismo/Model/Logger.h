//
//  Logger.h
//  Matchismo
//
//  Created by XIE haochen on 2021/7/20.
//

#ifndef Logger_h
#define Logger_h

#import "Foundation/Foundation.h"

typedef NS_ENUM(NSInteger, logLevel) {
    logLevelDebug = 10,
    logLevelInfo = 20,
    logLevelWarning = 30,
    logLevelError = 40,
    logLevelFatal = 50,
};

@interface LogEntry : NSObject
- (instancetype)initWithNSString:(NSString *)log;
- (NSString *)logDetail;
@end

@interface Logger : NSObject
 - (void)addLog:(NSString *)log;
 - (void)addLog:(NSString *)log logLevel:(logLevel)logLevel;
- (NSArray *)showLogs;
- (LogEntry *)lastLog;

// todo: change to private method?
+ (Logger *)Logger;
+ (void)setLoggerLevel:(logLevel)logLevel;

+ (void)Debug:(NSString *)log;
+ (void)Info:(NSString *)log;
+ (void)Warning:(NSString *)log;
+ (void)Error:(NSString *)log;
+ (void)Fatal:(NSString *)log;

+ (NSString *)lastLog;

@end

#endif /* Logger_h */
