#import "GoogleAnalyticsLegacyPlugin.h"
#if __has_include(<google_analytics_legacy/google_analytics_legacy-Swift.h>)
#import <google_analytics_legacy/google_analytics_legacy-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "google_analytics_legacy-Swift.h"
#endif

@implementation GoogleAnalyticsLegacyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGoogleAnalyticsLegacyPlugin registerWithRegistrar:registrar];
}
@end
