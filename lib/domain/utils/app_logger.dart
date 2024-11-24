import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

abstract class AppLogger {
  static final _logger = Logger();

  static String get _timeNow => DateFormat('HH:mm:ss').format(DateTime.now());

  static void logTrace(
    String msg, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.t(
      '[$_timeNow]: $msg',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void logDebug(
    String msg, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.d(
      '[$_timeNow]: $msg',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void logInfo(
    String msg, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.i(
      '[$_timeNow]: $msg',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void logWarning(
    String msg, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.w(
      '[$_timeNow]: $msg',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void logError(
    String msg, {
    required Object? error,
    required StackTrace? stackTrace,
  }) {
    _logger.e(
      '[$_timeNow]: $msg',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void logFatal(
    String msg, {
    required Object? error,
    required StackTrace? stackTrace,
  }) {
    _logger.f(
      '[$_timeNow]: $msg',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
