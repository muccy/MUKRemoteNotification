//
//  MUKRemoteNotificationAlert.h
//  
//
//  Created by Marco on 03/12/15.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUKRemoteNotificationAlert : NSObject
/**
 A short string describing the purpose of the notification. Apple Watch displays 
 this string as part of the notification interface.
 */
@property (nonatomic, readonly, copy, nullable) NSString *title;
/// The text of the alert message.
@property (nonatomic, readonly, copy) NSString *text;
/**
 The string is used as a key to get a localized string in the current localization 
 to use for the right button’s title instead of “View”
 */
@property (nonatomic, readonly, copy, nullable) NSString *customActionName;
/**
 The filename of an image file in the app bundle; it may include the extension 
 or omit it. The image is used as the launch image when users tap the action
 button or move the action slider.
 */
@property (nonatomic, readonly, copy, nullable) NSString *launchImageName;

/// Designated initializer
- (instancetype)initWithTitle:(nullable NSString *)title text:(NSString *)text customActionName:(nullable NSString *)customActionName launchImageName:(nullable NSString *)launchImageName NS_DESIGNATED_INITIALIZER;
/**
 Convenience initializer
 @param dict Dictionary found inside "aps" dictionary at key "alert"
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (BOOL)isEqualToRemoteNotificationAlert:(MUKRemoteNotificationAlert *)alert;
@end

NS_ASSUME_NONNULL_END
