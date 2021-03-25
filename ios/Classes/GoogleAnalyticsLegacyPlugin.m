#import "GoogleAnalyticsLegacyPlugin.h"
#import "messages.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIFields.h>

@interface GoogleAnalyticsApiHandler : NSObject<GALGoogleAnalyticsApi>
@property (nonatomic) int trackerId;
@end

@interface TrackerApiHandler : NSObject<GALTrackerApi>
- (id<GAITracker>) tracker:(NSNumber *)trackerId;
- (NSString *) convertToGABool:(NSNumber *)value;
@end

@implementation GoogleAnalyticsLegacyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    GALGoogleAnalyticsApiSetup(registrar.messenger , [[GoogleAnalyticsApiHandler alloc] init]);
    GALTrackerApiSetup(registrar.messenger, [[TrackerApiHandler alloc] init]);
}
@end

@implementation GoogleAnalyticsApiHandler
@synthesize trackerId;

- (nullable GALGABool *)getAppOptOut:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    GALGABool *result = [[GALGABool alloc] init];
    result.value = [NSNumber numberWithBool:[GAI sharedInstance].optOut];
    return result;
}

- (void)getInstance:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    GAI *gai = [GAI sharedInstance];
    if (gai == nil) {
        *error = [FlutterError errorWithCode:@"GoogleAnalyticsApiHandler"
                                     message:@"Google Analytics not configured correctly"
                                     details:nil];
    }
}

- (nullable GALGABool *)isDryRunEnabled:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    GALGABool *result = [[GALGABool alloc] init];
    result.value = [NSNumber numberWithBool:[GAI sharedInstance].dryRun];
    return result;
}

- (nullable GALTrackerId *)newTracker:(nonnull GALTrackingId *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    trackerId += 1;
    NSString *trackerName = [NSString stringWithFormat:@"%d", trackerId];
    [[GAI sharedInstance] trackerWithName:trackerName trackingId:input.trackingId];
    GALTrackerId *result = [[GALTrackerId alloc] init];
    result.trackerId = @(trackerId);
    return result;
}

- (void)setAppOptOut:(nonnull GALGABool *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [GAI sharedInstance].optOut = input.value.boolValue;
}

- (void)setDryRun:(nonnull GALGABool *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [GAI sharedInstance].dryRun = input.value.boolValue;
}

- (void)setLocalDispatchPeriod:(nonnull GALGAInt *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [GAI sharedInstance].dispatchInterval = input.value.doubleValue;
}

- (void)setLogLevelVerbose:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [GAI sharedInstance].logger.logLevel = kGAILogLevelVerbose;
}

@end

@implementation TrackerApiHandler
- (id<GAITracker>) tracker:(NSNumber *)trackerId {
    return [[GAI sharedInstance] trackerWithName:trackerId.stringValue trackingId:nil];
}

- (NSString *) convertToGABool:(NSNumber *)value {
    return value.boolValue ? @"1" : @"0";
}

- (void)enableAdvertisingIdCollection:(nonnull GALTrackerBoolValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [self tracker:input.trackerId].allowIDFACollection = input.value.boolValue;
}

- (void)enableAutoActivityTracking:(nonnull GALTrackerBoolValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    // not for iOS
}

- (void)enableExceptionReporting:(nonnull GALTrackerBoolValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [GAI sharedInstance].trackUncaughtExceptions = input.value.boolValue;
}

- (nullable GALTrackerGetValue *)get:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    GALTrackerGetValue *result = [[GALTrackerGetValue alloc] init];
    result.value = [[self tracker:input.trackerId] get:input.value];
    return result;
}

- (nullable GALTrackerGetClientIdValue *)getClientId:(nonnull GALTrackerIdValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    GALTrackerGetClientIdValue *result = [[GALTrackerGetClientIdValue alloc] init];
    result.value = [[self tracker:input.trackerId] get:kGAIClientId];
    return result;
}

- (void)send:(nonnull GALHitBuilderMessage *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    NSData *data = [input.data dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonError = nil;
    NSDictionary *sendMap = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:&jsonError];
    if (jsonError == nil) {
        [[self tracker:input.trackerId] send:sendMap];
    } else {
        *error = [FlutterError errorWithCode:@"TrackerApiHandler"
                                     message:jsonError.localizedDescription
                                     details:nil];
    }
}

- (void)set:(nonnull GALTrackerSetValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:input.key value:input.value];
}

- (void)setAnonymizeIp:(nonnull GALTrackerBoolValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIAnonymizeIp value:[self convertToGABool:input.value]];
}

- (void)setAppId:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIAppId value:input.value];
}

- (void)setAppInstallerId:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIAppInstallerId value:input.value];
}

- (void)setAppName:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIAppName value:input.value];
}

- (void)setAppVersion:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIAppVersion value:input.value];
}

- (void)setClientId:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIClientId value:input.value];
}

- (void)setEncoding:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIEncoding value:input.value];
}

- (void)setHostname:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIHostname value:input.value];
}

- (void)setLanguage:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAILanguage value:input.value];
}

- (void)setLocation:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAILocation value:input.value];
}

- (void)setPage:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIPage value:input.value];
}

- (void)setReferrer:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIReferrer value:input.value];
}

- (void)setSampleRate:(nonnull GALTrackerDoubleValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAISampleRate value:input.value.stringValue];
}

- (void)setScreenColors:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIScreenColors value:input.value];
}

- (void)setScreenName:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIScreenName value:input.value];
}

- (void)setScreenResolution:(nonnull GALTrackerSetScreenResolutionValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    NSString *resolution = [NSString stringWithFormat:@"%dx%d", input.value1.intValue, input.value2.intValue];
    [[self tracker:input.trackerId] set:kGAIScreenResolution value:resolution];
}

- (void)setSessionTimeout:(nonnull GALTrackerIntValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    // not implemented in iOS SDK
}

- (void)setTitle:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAITitle value:input.value];
}

- (void)setUseSecure:(nonnull GALTrackerBoolValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    // not implemented in iOS SDK
}

- (void)setViewportSize:(nonnull GALTrackerStringValue *)input error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [[self tracker:input.trackerId] set:kGAIViewportSize value:input.value];
}

@end
