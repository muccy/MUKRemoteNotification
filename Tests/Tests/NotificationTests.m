//
//  NotificationTests.m
//  Tests
//
//  Created by Marco on 03/12/15.
//
//

#import <XCTest/XCTest.h>
#import <MUKRemoteNotification/MUKRemoteNotification.h>

@interface NotificationTests : XCTestCase

@end

@implementation NotificationTests

- (void)testSimpleAlert {
    NSString *const JSONString = @"{\
        \"aps\" : { \"alert\" : \"Message received from Bob\" },\
        \"acme2\" : [ \"bang\",  \"whiz\" ]\
    }";
    NSDictionary *const dict = [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

    MUKRemoteNotification *const notification = [[MUKRemoteNotification alloc] initWithDictionary:dict];
    XCTAssertEqualObjects(notification.alert.text, @"Message received from Bob");
    XCTAssertNil(notification.alert.title);
    XCTAssertNil(notification.badge);
    XCTAssertEqualObjects(notification.soundName, MUKRemoteNotificationDefaultSoundName);
    XCTAssertFalse(notification.contentAvailable);
    XCTAssertNil(notification.categoryIdentifier);
}

- (void)testComplexAlert {
    NSString *const JSONString = @"{\
        \"aps\" : {\
            \"alert\" : {\
                \"title\" : \"Game Request\",\
                \"body\" : \"Bob wants to play poker\"\
            },\
            \"badge\" : 5,\
            \"category\" : \"aCategoryID\",\
            \"content-available\" : true,\
        },\
        \"acme1\" : \"bar\",\
        \"acme2\" : [ \"bang\",  \"whiz\" ]\
    }";
    NSDictionary *const dict = [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    MUKRemoteNotification *const notification = [[MUKRemoteNotification alloc] initWithDictionary:dict];
    XCTAssertEqualObjects(notification.alert.title, @"Game Request");
    XCTAssertEqualObjects(notification.alert.text, @"Bob wants to play poker");
    XCTAssertEqualObjects(notification.badge, @5);
    XCTAssertEqualObjects(notification.soundName, MUKRemoteNotificationDefaultSoundName);
    XCTAssertTrue(notification.contentAvailable);
    XCTAssertEqualObjects(notification.categoryIdentifier, @"aCategoryID");
}

- (void)testAlertWithSound {
    NSString *const JSONString = @"{\
        \"aps\" : {\
            \"alert\" : \"You got your emails.\",\
            \"badge\" : 9,\
            \"sound\" : \"bingbong.aiff\"\
        },\
        \"acme1\" : \"bar\",\
        \"acme2\" : 42\
    }";
    NSDictionary *const dict = [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    MUKRemoteNotification *const notification = [[MUKRemoteNotification alloc] initWithDictionary:dict];
    XCTAssertNil(notification.alert.title);
    XCTAssertEqualObjects(notification.alert.text, @"You got your emails.");
    XCTAssertEqualObjects(notification.badge, @9);
    XCTAssertEqualObjects(notification.soundName, @"bingbong.aiff");
    XCTAssertFalse(notification.contentAvailable);
    XCTAssertNil(notification.categoryIdentifier);
}

@end
