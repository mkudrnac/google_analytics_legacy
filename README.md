# google_analytics_legacy

Flutter plugin for sending events to Google Analytics (Universal Analytics).

## Setup

To use this plugin, add google_analytics_legacy as a dependency in your pubspec.yaml file.

## Example
```dart
import 'package:google_analytics_legacy/googleAnalytics.dart';

final ga = await GoogleAnalytics.instance;
final tracker = await ga.newTracker("UA-xxxxxx");
final screenView = ScreenViewBuilder();
await tracker.setScreenName("Flutter");
await tracker.send(screenView);
```

