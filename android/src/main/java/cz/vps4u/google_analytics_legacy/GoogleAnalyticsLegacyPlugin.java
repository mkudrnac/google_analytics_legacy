package cz.vps4u.google_analytics_legacy;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.google.android.gms.analytics.GoogleAnalytics;
import com.google.android.gms.analytics.Logger;
import com.google.android.gms.analytics.Tracker;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;

/**
 * GoogleAnalyticsLegacyPlugin
 */
public final class GoogleAnalyticsLegacyPlugin implements FlutterPlugin {
    private final Map<Long, Tracker> trackers = new HashMap<>();
    private Context context;
    private GoogleAnalytics ga;
    private long trackerId = 0;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext();
        Messages.GoogleAnalyticsApi.setup(flutterPluginBinding.getBinaryMessenger(), new GoogleAnalyticsApiHandler());
        Messages.TrackerApi.setup(flutterPluginBinding.getBinaryMessenger(), new TrackerApiHandler());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        Messages.GoogleAnalyticsApi.setup(flutterPluginBinding.getBinaryMessenger(), null);
        Messages.TrackerApi.setup(flutterPluginBinding.getBinaryMessenger(), null);
    }

    private final class GoogleAnalyticsApiHandler implements Messages.GoogleAnalyticsApi {
        @Override
        public void getInstance() {
            ga = GoogleAnalytics.getInstance(context);
        }

        @SuppressWarnings("deprecation")
        @Override
        public void setLogLevelVerbose() {
            ga.getLogger().setLogLevel(Logger.LogLevel.VERBOSE);
        }

        @Override
        public void setDryRun(Messages.GABool arg) {
            ga.setDryRun(arg.getValue());
        }

        @Override
        public Messages.GABool isDryRunEnabled() {
            final Messages.GABool value = new Messages.GABool();
            value.setValue(ga.isDryRunEnabled());
            return value;
        }

        @Override
        public Messages.GABool getAppOptOut() {
            final Messages.GABool value = new Messages.GABool();
            value.setValue(ga.getAppOptOut());
            return value;
        }

        @Override
        public void setAppOptOut(Messages.GABool arg) {
            ga.setAppOptOut(arg.getValue());
        }

        @Override
        public void setLocalDispatchPeriod(Messages.GAInt arg) {
            ga.setLocalDispatchPeriod(arg.getValue().intValue());
        }

        @Override
        public Messages.TrackerId newTracker(Messages.TrackingId arg) {
            synchronized (this) {
                trackerId += 1;
                trackers.put(trackerId, ga.newTracker(arg.getTrackingId()));
                final Messages.TrackerId tracker = new Messages.TrackerId();
                tracker.setTrackerId(trackerId);
                return tracker;
            }
        }
    }

    private final class TrackerApiHandler implements Messages.TrackerApi {
        @Override
        public void enableExceptionReporting(Messages.TrackerBoolValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.enableExceptionReporting(arg.getValue());
            }
        }

        @Override
        public void setSessionTimeout(Messages.TrackerIntValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setSessionTimeout(arg.getValue());
            }
        }

        @Override
        public void enableAutoActivityTracking(Messages.TrackerBoolValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.enableAutoActivityTracking(arg.getValue());
            }
        }

        @Override
        public void send(Messages.HitBuilderMessage arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                try {
                    final JSONObject json = new JSONObject(arg.getData());
                    final Map<String, String> map = JsonUtils.toMap(json);
                    tracker.send(map);
                } catch (final JSONException e) {
                    Log.e("TrackerApiHandler", e.toString());
                }
            } else {
                throw new NullPointerException("GATracker is null");
            }
        }

        @Override
        public Messages.TrackerGetValue get(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                final Messages.TrackerGetValue value = new Messages.TrackerGetValue();
                value.setValue(tracker.get(arg.getValue()));
                return value;
            }
            return null;
        }

        @Override
        public void set(Messages.TrackerSetValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.set(arg.getKey(), arg.getValue());
            }
        }

        @Override
        public void setSampleRate(Messages.TrackerDoubleValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setSampleRate(arg.getValue());
            }
        }

        @Override
        public void setUseSecure(Messages.TrackerBoolValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setUseSecure(arg.getValue());
            }
        }

        @Override
        public void setScreenName(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setScreenName(arg.getValue());
            }
        }

        @Override
        public void setLocation(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setLocation(arg.getValue());
            }
        }

        @Override
        public void setReferrer(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setReferrer(arg.getValue());
            }
        }

        @Override
        public void setPage(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setPage(arg.getValue());
            }
        }

        @Override
        public void setHostname(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setHostname(arg.getValue());
            }
        }

        @Override
        public void setTitle(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setTitle(arg.getValue());
            }
        }

        @Override
        public void setLanguage(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setLanguage(arg.getValue());
            }
        }

        @Override
        public void setEncoding(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setEncoding(arg.getValue());
            }
        }

        @Override
        public void setScreenColors(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setScreenColors(arg.getValue());
            }
        }

        @Override
        public void setScreenResolution(Messages.TrackerSetScreenResolutionValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setScreenResolution(arg.getValue1().intValue(), arg.getValue2().intValue());
            }
        }

        @Override
        public void setViewportSize(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setViewportSize(arg.getValue());
            }
        }

        @Override
        public Messages.TrackerGetClientIdValue getClientId(Messages.TrackerIdValue arg) {
            final Messages.TrackerGetClientIdValue value = new Messages.TrackerGetClientIdValue();
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                value.setValue(tracker.get("&cid"));
            } else {
                value.setValue("");
            }
            return value;
        }

        @Override
        public void setClientId(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setClientId(arg.getValue());
            }
        }

        @Override
        public void setAppName(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setAppName(arg.getValue());
            }
        }

        @Override
        public void setAppId(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setAppId(arg.getValue());
            }
        }

        @Override
        public void setAppInstallerId(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setAppInstallerId(arg.getValue());
            }
        }

        @Override
        public void setAppVersion(Messages.TrackerStringValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setAppVersion(arg.getValue());
            }
        }

        @Override
        public void setAnonymizeIp(Messages.TrackerBoolValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.setAnonymizeIp(arg.getValue());
            }
        }

        @Override
        public void enableAdvertisingIdCollection(Messages.TrackerBoolValue arg) {
            final Tracker tracker = trackers.get(arg.getTrackerId());
            if (tracker != null) {
                tracker.enableAdvertisingIdCollection(arg.getValue());
            }
        }
    }
}
