//
//  Logger.m
//  Matchismo
//
//  Created by XIE haochen on 2021/7/20.
//
#import "Logger.h"

#import <Foundation/Foundation.h>

@interface LogEntry()
@property (nonatomic, strong) NSString *logEntry;
@end

@implementation LogEntry

@synthesize logEntry = _logEntry;
- (instancetype)initWithNSString:(NSString *)log {
    self = [super init];
    _logEntry = log;
    return self;
}

- (NSString *)logDetail {
    return self.logEntry;
}
@end

@interface Logger()
// a better way to do this should be use a productor - consumer model
@property (atomic, strong) NSMutableArray *logEntryList;
@property (atomic) logLevel logLevel;
@end

@implementation Logger

+ (Logger *)Logger {
    static Logger *sharedLogger = nil;
    static dispatch_once_t onceTokenLoggerInit;
    dispatch_once(&onceTokenLoggerInit, ^{
        sharedLogger = [[self alloc] init];
    });
    
    return sharedLogger;
}

- (instancetype)init {
    self = [super init];
    self.logEntryList = [[NSMutableArray alloc] init];
    self.logLevel = logLevelInfo;
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Log: %@", self];
}

- (void)addLog:(NSString *)log {
    [self.logEntryList addObject:[[LogEntry alloc] initWithNSString:log]];
}

- (void)addLog:(NSString *)log logLevel:(logLevel)logLevel {
    if (logLevel < self.logLevel) return;
    
    [self addLog:log];
}

- (NSArray *)showLogs {
    return [self.logEntryList copy];
}

- (LogEntry *)lastLog {
    return [self.logEntryList lastObject];
}

+ (void)setLoggerLevel:(logLevel)logLevel {
    [Logger Logger].logLevel = logLevel;
}

+ (void)Debug:(NSString *)log {
    [[Logger Logger] addLog:log logLevel:logLevelDebug];
}

+ (void)Info:(NSString *)log {
    [[Logger Logger] addLog:log logLevel:logLevelInfo];
}

+ (void)Warning:(NSString *)log {
    [[Logger Logger] addLog:log logLevel:logLevelWarning];
}

+ (void)Error:(NSString *)log {
    [[Logger Logger] addLog:log logLevel:logLevelError];
}

+ (void)Fatal:(NSString *)log {
    [[Logger Logger] addLog:log logLevel:logLevelFatal];
}

+ (NSString *)lastLog {
    return [[[Logger Logger] lastLog] logDetail];
}

@end
