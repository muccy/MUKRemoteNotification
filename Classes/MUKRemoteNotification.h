//
//  MUKRemoteNotification.h
//  
//
//  Created by Marco on 03/12/15.
//
//

#import <Foundation/Foundation.h>
#import <MUKRemoteNotification/MUKRemoteNotificationAlert.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const MUKRemoteNotificationDefaultSoundName;

/**
 An incoming remote notification
 @see https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ApplePushService.html#//apple_ref/doc/uid/TP40008194-CH100-SW1
 */
@interface MUKRemoteNotification : NSObject
@property (nonatomic, readonly, nullable) MUKRemoteNotificationAlert *alert;
/**
 The number to display as the badge of the app icon.
 If this property is nil, the badge is not changed. To remove the badge, set
 the value of this property to 0.
 */
@property (nonatomic, readonly, nullable) NSNumber *badge;
/**
 The name of a sound file in the app bundle or in the Library/Sounds folder of 
 the app’s data container. The sound in this file is played as an alert. 
 If the sound file doesn’t exist or MUKRemoteNotificationDefaultSoundName is 
 specified as the value, the default alert sound is played.
 */
@property (nonatomic, readonly, copy) NSString *soundName;
/**
 It indicates if new content is available. Including this key and value means that 
 when your app is launched in the background or resumed, 
 application:didReceiveRemoteNotification:fetchCompletionHandler: is called.
 */
@property (nonatomic, readonly, getter=isContentAvailable) BOOL contentAvailable;
/**
 It rrepresents the identifier property of the UIMutableUserNotificationCategory 
 object you created to define custom actions
 */
@property (nonatomic, readonly, copy, nullable) NSString *categoryIdentifier;

/// Designated initializer
- (instancetype)initWithAlert:(nullable MUKRemoteNotificationAlert *)alert badge:(nullable NSNumber *)badge soundName:(NSString *)soundName contentAvailable:(BOOL)contentAvailable categoryIdentifier:(nullable NSString *)categoryIdentifier NS_DESIGNATED_INITIALIZER;
/**
 Convenience initializer to use inside -application:didFinishLaunchingWithOptions:
 @param dict The dictionary inside launch options at key UIApplicationLaunchOptionsRemoteNotificationKey
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (BOOL)isEqualToRemoteNotification:(MUKRemoteNotification *)notification;
@end

NS_ASSUME_NONNULL_END
