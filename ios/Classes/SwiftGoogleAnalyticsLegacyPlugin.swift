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
            error.pointee = FlutterError(code: "GAL", message: "Google Analytics not configured correctly", details: nil)
            return
        }
        gai.logger.logLevel = .verbose
    }

    func setDryRun(_ value: GALGABool, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let value = value.value?.boolValue else {
            error.pointee = FlutterError(code: "GAL", message: "setDryRun: value is nil", details: nil)
            return
        }
        gai.dryRun = value
    }

    func isDryRunEnabled(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> GALGABool? {
        let result = GALGABool()
        result.value = NSNumber(booleanLiteral: gai.dryRun)
        return result
    }

    func setAppOptOut(_ value: GALGABool, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let value = value.value?.boolValue else {
            error.pointee = FlutterError(code: "GAL", message: "setAppOptOut: value is nil", details: nil)
            return
        }
        gai.optOut = value
    }

    func getAppOptOut(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> GALGABool? {
        let result = GALGABool()
        result.value = NSNumber(booleanLiteral: gai.optOut)
        return result
    }

    func setLocalDispatchPeriod(_ value: GALGAInt, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let value = value.value?.doubleValue else {
            error.pointee = FlutterError(code: "GAL", message: "setLocalDispatchPeriod: value is nil", details: nil)
            return
        }
        gai.dispatchInterval = value
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
    
    private func tracker(_ trackerId: NSNumber?) -> GAITracker? {
        let gaiTrackerId = trackerId?.stringValue
        return gai.tracker(withName: gaiTrackerId, trackingId: nil)
    }
    
    private func convertToGABool(_ value: NSNumber?) -> String? {
        guard let value = value else { return nil }
        return value.boolValue ? "1" : "0"
    }

    func enableExceptionReporting(_ input: GALTrackerBoolValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let value = input.value?.boolValue else {
            error.pointee = FlutterError(code: "GAL", message: "enableExceptionReporting: value is nil", details: nil)
            return
        }
        gai.trackUncaughtExceptions = value
    }
    
    func setSessionTimeout(_ input: GALTrackerIntValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        // not implemented in iOS SDK
    }
    
    func enableAutoActivityTracking(_ input: GALTrackerBoolValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        // not for iOS
    }
    
    func send(_ input: GALHitBuilderMessage, error returnError: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        if let data = input.data?.data(using: .utf8) {
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : String]
                guard let tracker = tracker(input.trackerId) else { return }
                tracker.send(json)
            } catch {
                returnError.pointee = FlutterError(code: "GAL", message: error.localizedDescription, details: nil)
            }
        } else {
            returnError.pointee = FlutterError(code: "GAL", message: "Input error: \(input.data)", details: nil)
        }
    }
    
    func get(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> GALTrackerGetValue? {
        guard let tracker = tracker(input.trackerId) else { return nil }
        let result = GALTrackerGetValue()
        result.value = tracker.get(input.value)
        return result
    }
    
    func set(_ input: GALTrackerSetValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(input.key, value: input.value)
    }
    
    func setSampleRate(_ input: GALTrackerDoubleValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAISampleRate, value: input.value?.stringValue)
    }
    
    func setUseSecure(_ input: GALTrackerBoolValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        // not implemented in iOS SDK
    }
    
    func setScreenName(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIScreenName, value: input.value)
    }
    
    func setLocation(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAILocation, value: input.value)
    }
    
    func setReferrer(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIReferrer, value: input.value)
    }
    
    func setPage(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIPage, value: input.value)
    }
    
    func setHostname(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIHostname, value: input.value)
    }
    
    func setTitle(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAITitle, value: input.value)
    }
    
    func setLanguage(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAILanguage, value: input.value)
    }
    
    func setEncoding(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIEncoding, value: input.value)
    }
    
    func setScreenColors(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIScreenColors, value: input.value)
    }
    
    func setScreenResolution(_ input: GALTrackerSetScreenResolutionValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIScreenResolution, value: "\(input.value1)x\(input.value2)")
    }
    
    func setViewportSize(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIViewportSize, value: input.value)
    }
    
    func setClientId(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIClientId, value: input.value)
    }
    
    func setAppName(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIAppName, value: input.value)
    }
    
    func setAppId(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIAppId, value: input.value)
    }
    
    func setAppInstallerId(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIAppInstallerId, value: input.value)
    }
    
    func setAppVersion(_ input: GALTrackerStringValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIAppVersion, value: input.value)
    }
    
    func setAnonymizeIp(_ input: GALTrackerBoolValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        tracker.set(kGAIAnonymizeIp, value: convertToGABool(input.value))
    }
    
    func enableAdvertisingIdCollection(_ input: GALTrackerBoolValue, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let tracker = tracker(input.trackerId) else { return }
        guard let value = input.value?.boolValue else {
            error.pointee = FlutterError(code: "GAL", message: "enableAdvertisingIdCollection: value is nil", details: nil)
            return
        }
        tracker.allowIDFACollection = value
    }
}
