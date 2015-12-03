//
//  Tests.m
//  Tests
//
//  Created by Marco on 03/12/15.
//
//

#import <XCTest/XCTest.h>
#import <MUKRemoteNotification/MUKRemoteNotificationAlert+Localization.h>

@interface TestableAlert : MUKRemoteNotificationAlert
@end

@implementation TestableAlert

- (NSBundle *)localizationBundle {
    return [NSBundle bundleForClass:NSClassFromString(@"AlertTests")];
}

@end

#pragma mark - 

@interface AlertTests : XCTestCase

@end

@implementation AlertTests

- (void)testLocalizedText {
    NSDictionary *const dict = @{
        @"loc-key" : @"ALERT_MASK",
        @"loc-args" : @[ @"Noel", @"Gallagher"]
    };
    
    TestableAlert *const alert = [[TestableAlert alloc] initWithDictionary:dict];
    XCTAssertEqualObjects(alert.text, @"Two words: Noel, Gallagher");
}

- (void)testLocalizedTitle {
    NSDictionary *const dict = @{
        @"title-loc-key" : @"ALERT_MASK",
        @"title-loc-args" : @[ @"Noel", @"Gallagher"]
    };
    
    TestableAlert *const alert = [[TestableAlert alloc] initWithDictionary:dict];
    XCTAssertEqualObjects(alert.title, @"Two words: Noel, Gallagher");
}

- (void)testLocalizedCustomActionName {
    NSDictionary *const dict = @{ @"action-loc-key" : @"ACTION" };
    TestableAlert *const alert = [[TestableAlert alloc] initWithDictionary:dict];
    XCTAssertEqualObjects(alert.customActionName, @"Boom");
}

- (void)testLaunchImageName {
    NSDictionary *const dict = @{ @"launch-image" : @"AnImage" };
    TestableAlert *const alert = [[TestableAlert alloc] initWithDictionary:dict];
    XCTAssertEqualObjects(alert.launchImageName, dict[@"launch-image"]);
}

- (void)testText {
    NSDictionary *const dict = @{ @"body" : @"Something" };
    TestableAlert *const alert = [[TestableAlert alloc] initWithDictionary:dict];
    XCTAssertEqualObjects(alert.text, dict[@"body"]);
}

- (void)testTitle {
    NSDictionary *const dict = @{ @"title" : @"Something" };
    TestableAlert *const alert = [[TestableAlert alloc] initWithDictionary:dict];
    XCTAssertEqualObjects(alert.title, dict[@"title"]);
}

@end
