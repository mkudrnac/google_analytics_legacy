import 'package:google_analytics_legacy/googleAnalytics.dart';

void main(List<String> args) async {
  final ga = await GoogleAnalytics.instance;
  final tracker = await ga.newTracker("UA-xxxxxx");
  final screenView = ScreenViewBuilder();
  await tracker.setScreenName("Flutter");
  await tracker.send(screenView);
}
