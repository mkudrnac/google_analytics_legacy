// Autogenerated from Pigeon (v0.1.23), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class GALTrackerBoolValue;
@class GALTrackerIntValue;
@class GALHitBuilderMessage;
@class GALStringValue;
@class GALTrackerStringValue;
@class GALTrackerSetValue;
@class GALTrackerDoubleValue;
@class GALIntValue;

@interface GALTrackerBoolValue : NSObject
@property(nonatomic, strong, nullable) NSNumber * trackerId;
@property(nonatomic, strong, nullable) NSNumber * value;
@end

@interface GALTrackerIntValue : NSObject
@property(nonatomic, strong, nullable) NSNumber * trackerId;
@property(nonatomic, strong, nullable) NSNumber * value;
@end

@interface GALHitBuilderMessage : NSObject
@property(nonatomic, strong, nullable) NSNumber * trackerId;
@property(nonatomic, copy, nullable) NSString * data;
@end

@interface GALStringValue : NSObject
@property(nonatomic, copy, nullable) NSString * value;
@end

@interface GALTrackerStringValue : NSObject
@property(nonatomic, strong, nullable) NSNumber * trackerId;
@property(nonatomic, copy, nullable) NSString * value;
@end

@interface GALTrackerSetValue : NSObject
@property(nonatomic, strong, nullable) NSNumber * trackerId;
@property(nonatomic, copy, nullable) NSString * key;
@property(nonatomic, copy, nullable) NSString * value;
@end

@interface GALTrackerDoubleValue : NSObject
@property(nonatomic, strong, nullable) NSNumber * trackerId;
@property(nonatomic, strong, nullable) NSNumber * value;
@end

@interface GALIntValue : NSObject
@property(nonatomic, strong, nullable) NSNumber * value;
@end

@protocol GALTrackerApi
-(void)enableExceptionReporting:(GALTrackerBoolValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setSessionTimeout:(GALTrackerIntValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)enableAutoActivityTracking:(GALTrackerBoolValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)send:(GALHitBuilderMessage*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(nullable GALStringValue *)get:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)set:(GALTrackerSetValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setSampleRate:(GALTrackerDoubleValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setUseSecure:(GALTrackerBoolValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setScreenName:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setLocation:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setReferrer:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setPage:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setHostname:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setTitle:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setLanguage:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setEncoding:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setScreenColors:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setScreenResolution:(GALIntValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setViewportSize:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setClientId:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setAppName:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setAppId:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setAppInstallerId:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setAppVersion:(GALTrackerStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)setAnonymizeIp:(GALTrackerBoolValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
-(void)enableAdvertisingIdCollection:(GALTrackerBoolValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void GALTrackerApiSetup(id<FlutterBinaryMessenger> binaryMessenger, id<GALTrackerApi> _Nullable api);

@protocol GALGoogleAnalyticsApi
-(void)getInstance:(FlutterError *_Nullable *_Nonnull)error;
-(nullable GALIntValue *)newTracker:(GALStringValue*)input error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void GALGoogleAnalyticsApiSetup(id<FlutterBinaryMessenger> binaryMessenger, id<GALGoogleAnalyticsApi> _Nullable api);

NS_ASSUME_NONNULL_END
