//
//  MUKRemoteNotification.m
//  
//
//  Created by Marco on 03/12/15.
//
//

#import "MUKRemoteNotification.h"

NSString *const MUKRemoteNotificationDefaultSoundName = @"MUKRemoteNotificationDefaultSoundName";

@implementation MUKRemoteNotification

- (instancetype)initWithAlert:(MUKRemoteNotificationAlert *)alert badge:(NSNumber *)badge soundName:(NSString *)soundName contentAvailable:(BOOL)contentAvailable categoryIdentifier:(NSString *)categoryIdentifier
{
    self = [super init];
    if (self) {
        _alert = alert;
        _badge = badge;
        _soundName = [soundName copy];
        _contentAvailable = contentAvailable;
        _categoryIdentifier = [categoryIdentifier copy];
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    NSDictionary *const apsDict = dict[@"aps"];
    if (![apsDict isKindOfClass:[NSDictionary class]]) {
        return [self initWithAlert:nil badge:nil soundName:MUKRemoteNotificationDefaultSoundName contentAvailable:NO categoryIdentifier:nil];
    }
    
    MUKRemoteNotificationAlert *const alert = ({
        MUKRemoteNotificationAlert *alert;
        
        id const value = apsDict[@"alert"];
        if ([value isKindOfClass:[NSDictionary class]]) {
            alert = [[MUKRemoteNotificationAlert alloc] initWithDictionary:value];
        }
        else if ([value isKindOfClass:[NSString class]]) {
            alert = [[MUKRemoteNotificationAlert alloc] initWithTitle:nil text:value customActionName:nil launchImageName:nil];
        }
        else {
            alert = nil;
        }
        
        alert;
    });
    
    NSNumber *const badge = apsDict[@"badge"];
    NSString *const soundName = ({
        NSString *const value = apsDict[@"sound"];
        value.length == 0 || [value isEqualToString:@"default"] ? MUKRemoteNotificationDefaultSoundName : value;
    });
    
    BOOL const contentAvailable = [apsDict[@"content-available"] boolValue];
    NSString *const categoryIdentifier = apsDict[@"category"];
    
    return [self initWithAlert:alert badge:badge soundName:soundName contentAvailable:contentAvailable categoryIdentifier:categoryIdentifier];
}

- (BOOL)isEqualToRemoteNotification:(MUKRemoteNotification *)notification {
    BOOL const sameAlert = EqualObjects(self.alert, notification.alert);
    BOOL const sameBadge = EqualObjects(self.badge, notification.badge);
    BOOL const sameSoundName = EqualObjects(self.soundName, notification.soundName);
    BOOL const sameContentAvailable = self.contentAvailable == notification.contentAvailable;
    BOOL const sameCategoryIdentifier = EqualObjects(self.categoryIdentifier, notification.categoryIdentifier);
    
    return sameAlert && sameBadge && sameSoundName && sameContentAvailable && sameCategoryIdentifier;
}

#pragma mark - Overrides

- (instancetype)init {
    return [self initWithAlert:nil badge:nil soundName:MUKRemoteNotificationDefaultSoundName contentAvailable:NO categoryIdentifier:nil];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if ([object isKindOfClass:[self class]]) {
        return [self isEqualToRemoteNotification:object];
    }
    
    return NO;
}

- (NSUInteger)hash {
    return 43754 ^ self.alert.hash ^ self.badge.hash ^ self.soundName.hash;
}

#pragma mark - Private

static inline BOOL EqualObjects(id _Nullable obj1, id _Nullable obj2) {
    return (!obj1 && !obj2) || [obj1 isEqual:obj2];
}

@end
