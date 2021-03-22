package cz.vps4u.google_analytics_legacy;

import android.app.Application;
import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.google.android.gms.analytics.GoogleAnalytics;
import com.google.android.gms.analytics.Tracker;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** GoogleAnalyticsLegacyPlugin */
public final class GoogleAnalyticsLegacyPlugin implements FlutterPlugin {
  private static Context context;
  private static GoogleAnalytics ga;
  private static long trackerId = 0;
  private static final Map<Long, Tracker> trackers = new HashMap<>();

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

  private static final class GoogleAnalyticsApiHandler implements Messages.GoogleAnalyticsApi {
    @Override
    public void getInstance() {
      ga = GoogleAnalytics.getInstance(context);
    }

    @Override
    public Messages.IntValue newTracker(Messages.StringValue arg) {
      trackerId += 1;
      trackers.put(trackerId, ga.newTracker(arg.getValue()));
      final Messages.IntValue intValue = new Messages.IntValue();
      intValue.setValue(trackerId);
      return intValue;
    }
  }

  private static final class TrackerApiHandler implements Messages.TrackerApi {

    @Override
    public void enableExceptionReporting(Messages.TrackerBoolValue arg) {

    }

    @Override
    public void setSessionTimeout(Messages.TrackerIntValue arg) {

    }

    @Override
    public void enableAutoActivityTracking(Messages.TrackerBoolValue arg) {

    }

    @Override
    public void send(Messages.HitBuilderMessage arg) {
      final Tracker tracker = trackers.get(arg.getTrackerId());
      if (tracker != null) {
        try {
          final JSONObject json = new JSONObject(arg.getData());
          final Map<String, String> map = JsonUtils.toMap(json);
          tracker.send(map);
        } catch(final JSONException e) {
          Log.e("GoogleAnalyticsApi", e.toString());
        }
      }
    }

    @Override
    public Messages.StringValue get(Messages.TrackerStringValue arg) {
      return null;
    }

    @Override
    public void set(Messages.TrackerSetValue arg) {

    }

    @Override
    public void setSampleRate(Messages.TrackerDoubleValue arg) {

    }

    @Override
    public void setUseSecure(Messages.TrackerBoolValue arg) {

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

    }

    @Override
    public void setReferrer(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setPage(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setHostname(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setTitle(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setLanguage(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setEncoding(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setScreenColors(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setScreenResolution(Messages.IntValue arg) {

    }

    @Override
    public void setViewportSize(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setClientId(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setAppName(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setAppId(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setAppInstallerId(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setAppVersion(Messages.TrackerStringValue arg) {

    }

    @Override
    public void setAnonymizeIp(Messages.TrackerBoolValue arg) {

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
