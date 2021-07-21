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
@end

@interface Logger()
@property (nonatomic, strong) NSMutableArray *logEntryList;
@end

@implementation Logger

@synthesize logEntryList = _logEntryList;

- (NSMutableArray *)logEntryList {
    if (!_logEntryList) {
        _logEntryList = [[NSMutableArray alloc] init];
    }
    
    return _logEntryList;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Log: %@", self];
}

- (void)addLog:(NSString *)log {
    [self.logEntryList addObject:[[LogEntry alloc] initWithNSString:log]];
}

- (NSArray *)showLogs {
    return [self.logEntryList copy];
}

- (LogEntry *)lastLog {
    return [self.logEntryList lastObject];
}

@end
