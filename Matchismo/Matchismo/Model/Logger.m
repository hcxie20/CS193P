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

@synthesize logEntryList = _logEngryList;

- (void)addLog:(NSString *)log {
    [_logEngryList addObject:[LogEntry initWithNSString:log]];
}

- (NSArray *)showLogs {
    return [_logEngryList copy];
}

- (LogEntry *)lastLog {
    return [_logEngryList lastObject];
}

@end
