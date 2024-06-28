import 'package:logging/logging.dart';

final Logger logger = Logger('AppLogger');

void setupLogging() {
  Logger.root.level = Level.ALL; // Adjust as needed
  Logger.root.onRecord.listen((LogRecord rec) {
    // You can format or redirect the logs as needed.
    // This example just prints to the console.
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
