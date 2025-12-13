import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

/// Инициализация приложения с обработкой ошибок
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
      error: details.exception,
    );
  };

  await runZonedGuarded(
    () async => runApp(await builder()),
    (error, stackTrace) => log(
      error.toString(),
      stackTrace: stackTrace,
      error: error,
    ),
  );
}