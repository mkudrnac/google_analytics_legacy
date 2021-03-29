package cz.vps4u.google_analytics_legacy;

import androidx.annotation.NonNull;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public final class JsonUtils {
    @NonNull
    public static Map<String, String> toMap(@NonNull final JSONObject object) throws JSONException {
        final Map<String, String> map = new HashMap<>();
        final Iterator<String> keysItr = object.keys();
        while (keysItr.hasNext()) {
            final String key = keysItr.next();
            final Object value = object.get(key);
            map.put(key, value instanceof String ? (String) value : "");
        }
        return map;
    }
}
