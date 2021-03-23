# google_analytics_legacy

Flutter plugin for Google Analytics (360 not GA4).

## Getting Started

```dart
final ga = await GoogleAnalytics.instance;
final tracker = await ga.newTracker("UA-xxxxxx");
final screenView = ScreenViewBuilder();
await tracker.setScreenName("Flutter");
await tracker.send(screenView);
```

