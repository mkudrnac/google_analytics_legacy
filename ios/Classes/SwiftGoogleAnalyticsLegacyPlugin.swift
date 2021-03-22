import Flutter
import UIKit
import GoogleAnalytics

public class SwiftGoogleAnalyticsLegacyPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger: FlutterBinaryMessenger = registrar.messenger()
        GALGoogleAnalyticsApiSetup(messenger, GoogleAnalyticsApiHandler())
        GALTrackerApiSetup(messenger, TrackerApiHandler())
    }
}

private class GoogleAnalyticsApiHandler: GALGoogleAnalyticsApi {
    private var trackerId = 0
    private var gai: GAI {
        get { return GAI.sharedInstance() }
    }
    
    func getInstance(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let _ = GAI.sharedInstance() else {
            assert(false, "Google Analytics not configured correctly")
            return
        }
    }

    func setDryRun(_ value: GALGABool, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        gai.dryRun = value.value?.boolValue ?? false
    }

    func isDryRunEnabled(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> GALGABool? {
        let result = GALGABool()
        result.value = NSNumber(booleanLiteral: gai.dryRun)
        return result
    }

    func setAppOptOut(_ value: GALGABool, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        gai.optOut = value.value?.boolValue ?? false
    }

    func getAppOptOut(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> GALGABool? {
        let result = GALGABool()
        result.value = NSNumber(booleanLiteral: gai.optOut)
        return result
    }

    func setLocalDispatchPeriod(_ value: GALGAInt, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        gai.dispatchInterval = value.value?.doubleValue ?? 0
    }

    func newTracker(_ trackingId: GALTrackingId, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> GALTrackerId? {
        trackerId += 1
        gai.tracker(withName: "\(trackerId)", trackingId: trackingId.trackingId)
        let result = GALTrackerId.init()
        result.trackerId = NSNumber(integerLiteral: trackerId)
        return result
    }
}

private class TrackerApiHandler: GALTrackerApi {
    private var gai: GAI {
        get { return GAI.sharedInstance() }
    }
    
    func enableExceptionReporting(_ input: GALTrackerBoolValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setSessionTimeout(_ input: GALTrackerIntValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func enableAutoActivityTracking(_ input: GALTrackerBoolValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func send(_ input: GALHitBuilderMessage, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func get(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> GALTrackerGetValue? {
        return nil
    }
    
    func set(_ input: GALTrackerSetValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setSampleRate(_ input: GALTrackerDoubleValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setUseSecure(_ input: GALTrackerBoolValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setScreenName(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setLocation(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setReferrer(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setPage(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setHostname(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setTitle(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setLanguage(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setEncoding(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setScreenColors(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setScreenResolution(_ input: GALTrackerSetScreenResolutionValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setViewportSize(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setClientId(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setAppName(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setAppId(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setAppInstallerId(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setAppVersion(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func setAnonymizeIp(_ input: GALTrackerBoolValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func enableAdvertisingIdCollection(_ input: GALTrackerBoolValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let trackerId = input.trackerId?.stringValue
        let tracker = gai.tracker(withName: trackerId, trackingId: nil)
        tracker?.allowIDFACollection = input.value?.boolValue ?? false
    }
}
