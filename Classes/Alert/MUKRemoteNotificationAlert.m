//
//  MUKRemoteNotificationAlert.m
//  
//
//  Created by Marco on 03/12/15.
//
//

#import "MUKRemoteNotificationAlert.h"
#import "MUKRemoteNotificationAlert+Localization.h"

@interface MUKRemoteNotificationAlert ()

@end

@implementation MUKRemoteNotificationAlert

- (instancetype)initWithTitle:(NSString *)title text:(NSString *)text customActionName:(NSString *)customActionName launchImageName:(NSString *)launchImageName
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _text = [text copy];
        _customActionName = [customActionName copy];
        _launchImageName = [launchImageName copy];
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    NSString *const title = LocalizedStringInDict(dict, @"title-loc-key", @"title-loc-args", @"title", self.localizationBundle);
    NSString *const text = LocalizedStringInDict(dict, @"loc-key", @"loc-args", @"body", self.localizationBundle);
    NSString *const customActionName = LocalizedStringInDict(dict, @"action-loc-key", nil, nil, self.localizationBundle);
    NSString *const launchImageName = dict[@"launch-image"];
    
    return [self initWithTitle:title text:text customActionName:customActionName launchImageName:launchImageName];
}

- (BOOL)isEqualToRemoteNotificationAlert:(MUKRemoteNotificationAlert *)alert {
    BOOL const sameTitle = EqualObjects(self.title, alert.title);
    BOOL const sameText = EqualObjects(self.text, alert.text);
    BOOL const sameCustomActionName = EqualObjects(self.customActionName, alert.customActionName);
    BOOL const sameLaunchImageName = EqualObjects(self.launchImageName, alert.launchImageName);
    
    return sameTitle && sameText && sameCustomActionName && sameLaunchImageName;
}

#pragma mark - Overrides

- (instancetype)init {
    return [self initWithTitle:nil text:nil customActionName:nil launchImageName:nil];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if ([object isKindOfClass:[self class]]) {
        return [self isEqualToRemoteNotificationAlert:object];
    }
    
    return NO;
}

- (NSUInteger)hash {
    return 4793854 ^ self.title.hash;
}

#pragma mark - Localization

- (NSBundle *)localizationBundle {
    return [NSBundle mainBundle];
}

#pragma mark - Private

// You can't convert NSArray to varargs
// http://stackoverflow.com/questions/431910/is-possible-send-a-array-in-obj-c-for-a-variable-arguments-function
// The only way to achieve this it to hardcode a number of args for initWithFormat:
static inline NSString * _Nonnull StringWithMask(NSString * _Nonnull format, NSArray * _Nullable args)
{
    return [NSString stringWithFormat:format, ValueOrNil(args, 0), ValueOrNil(args, 1),
            ValueOrNil(args, 2), ValueOrNil(args, 3), ValueOrNil(args, 4),
            ValueOrNil(args, 5), ValueOrNil(args, 6), ValueOrNil(args, 7),
            ValueOrNil(args, 8), ValueOrNil(args, 9), ValueOrNil(args, 10),
            ValueOrNil(args, 11), ValueOrNil(args, 12), ValueOrNil(args, 13),
            ValueOrNil(args, 14), ValueOrNil(args, 15), ValueOrNil(args, 16),
            ValueOrNil(args, 17), ValueOrNil(args, 18), ValueOrNil(args, 19), nil];
    
}

static inline id _Nullable ValueOrNil(NSArray * _Nullable array, NSUInteger idx) {
    return array.count > idx ? array[idx] : nil;
}

static NSString * _Nullable LocalizedStringInDict(NSDictionary * _Nonnull dict, NSString * _Nonnull key, NSString * _Nullable argsKey, NSString * _Nullable backfillKey, NSBundle * _Nonnull bundle)
{
    NSString *string = nil;
    NSString *const maskKey = dict[key];
    
    if (maskKey) {
        NSString *const mask = NSLocalizedStringWithDefaultValue(maskKey, nil, bundle, nil, nil);
        
        if (mask && argsKey) {
            NSArray<NSString *> *const args = dict[argsKey];
            string = StringWithMask(mask, args);
        }
        else {
            string = mask;
        }
    }
    
    if (!string && backfillKey) {
        string = dict[backfillKey];
    }
    
    return string;
}

static inline BOOL EqualObjects(id _Nullable obj1, id _Nullable obj2) {
    return (!obj1 && !obj2) || [obj1 isEqual:obj2];
}

@end
